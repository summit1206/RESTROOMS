#import <CoreData/CoreData.h>
#import "RefugeDataPeristenceManagerDelegate.h"
@interface RefugeDataPersistenceManager : NSObject
@property (nonatomic, weak) id<RefugeDataPeristenceManagerDelegate> delegate;
- (NSArray *)allRestrooms;
- (void)saveRestrooms:(NSArray *)restrooms;
@end
