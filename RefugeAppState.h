#import <Foundation/Foundation.h>
@interface RefugeAppState : NSObject
@property (nonatomic, strong) NSDate *dateLastSynced;
@property (nonatomic, assign) BOOL hasPreloadedRestrooms;
@property (nonatomic, assign) BOOL hasViewedOnboarding;
- (id)initWithUserDefaults:(NSUserDefaults *)userDefaults;
@end
