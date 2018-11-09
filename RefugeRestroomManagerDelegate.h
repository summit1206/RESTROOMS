#import <Foundation/Foundation.h>
@protocol RefugeRestroomManagerDelegate <NSObject>
- (void)didFetchRestrooms;
- (void)fetchingRestroomsFromApiFailedWithError:(NSError *)error;
- (void)fetchingRestroomsFromLocalStoreFailedWithError:(NSError *)error;
- (void)savingRestroomsFailedWithError:(NSError *)error;
@end
