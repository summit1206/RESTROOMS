#import "RefugeRestroomBuilder.h"
#import "NSDate+Refuge.h"
#import "RefugeRestroom.h"
#import "RefugeSerialization.h"
NSString *RefugeRestroomBuilderErrorDomain = @"RefugeRestroomBuilderErrorDomain";
@implementation RefugeRestroomBuilder
#pragma mark - Public methods
- (NSArray *)buildRestroomsFromJSON:(id)jsonObjects error:(NSError **)error
{
    NSParameterAssert(jsonObjects != nil);
    NSError *errorWhileCreatingRestrooms;
    id jsonArray = nil;
    if (![jsonObjects isKindOfClass:[NSArray class]]) {
        jsonArray = @[ jsonObjects ];
    } else {
        jsonArray = jsonObjects;
    }
    if ([jsonArray count] == 0) {
        return [NSArray array];
    }
    NSArray *restrooms =
        [RefugeSerialization deserializeRestroomsFromJSON:jsonArray error:&errorWhileCreatingRestrooms];
    if (restrooms == nil || errorWhileCreatingRestrooms) {
        [self setErrorToReturn:error withUnderlyingError:errorWhileCreatingRestrooms];
    }
    return restrooms;
}
#pragma mark - Private methods
- (void)setErrorToReturn:(NSError **)error withUnderlyingError:(NSError *)underlyingError
{
    if (error != NULL) {
        NSMutableDictionary *errorInfo = [NSMutableDictionary dictionaryWithCapacity:1];
        if (underlyingError != nil) {
            [errorInfo setObject:underlyingError forKey:NSUnderlyingErrorKey];
        }
        *error = [NSError errorWithDomain:RefugeRestroomBuilderErrorDomain
                                     code:RefugeRestroomBuilderDeserializationErrorCode
                                 userInfo:errorInfo];
    }
}
@end
