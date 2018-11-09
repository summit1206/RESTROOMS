#import <Foundation/Foundation.h>
@interface RefugeSearch : NSObject
- (void)searchForPlaces:(NSString *)searchString
                success:(void (^)(NSArray *places))searchSuccess
                failure:(void (^)(NSError *error))searchError;
@end
