#import <Foundation/Foundation.h>
@protocol RefugeDataPeristenceManagerDelegate <NSObject>
- (void)didSaveRestrooms;
- (void)retrievingAllRestroomsFailedWithError:(NSError *)error;
- (void)savingRestroomsFailedWithError:(NSError *)error;
@end
