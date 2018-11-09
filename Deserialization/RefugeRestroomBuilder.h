#import <Foundation/Foundation.h>
extern NSString *RefugeRestroomBuilderErrorDomain;
typedef NS_ENUM(NSInteger, RefugeRestroomBuilderErrorCode) { RefugeRestroomBuilderDeserializationErrorCode };
@interface RefugeRestroomBuilder : NSObject
- (NSArray *)buildRestroomsFromJSON:(id)jsonObjects error:(NSError **)error;
@end
