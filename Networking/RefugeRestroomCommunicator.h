#import <Foundation/Foundation.h>
#import "RefugeRestroomCommunicatorDelegate.h"
@class RefugeHTTPSessionManager;
@interface RefugeRestroomCommunicator : NSObject
@property (nonatomic, weak) id<RefugeRestroomCommunicatorDelegate> delegate;
@property (nonatomic, strong, readonly) RefugeHTTPSessionManager *httpSessionManager;
- (id)initWithHttpSessionManager:(RefugeHTTPSessionManager *)httpSessionManager;
- (void)searchForRestrooms;
@end
