#import <Foundation/Foundation.h>
extern NSString *RefugeSerializationErrorDomain;
typedef NS_ENUM(NSInteger, RefugeSerializationErrorCode) { RefugeSerializationErrorDeserializationFromJSONCode };
@interface RefugeSerialization : NSObject
+ (NSArray *)deserializeRestroomsFromJSON:(NSArray *)JSON error:(NSError **)error;
@end
