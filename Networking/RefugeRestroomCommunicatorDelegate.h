#import <Foundation/Foundation.h>
@protocol RefugeRestroomCommunicatorDelegate <NSObject>
- (void)didReceiveRestroomsJsonObjects:(id)jsonObjects;
- (void)searchingForRestroomsFailedWithError:(NSError *)error;
@end
