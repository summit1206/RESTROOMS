#import "RefugeAppDelegate.h"
#import <Crashlytics/Crashlytics.h>
#import <Fabric/Fabric.h>
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocompleteQuery.h>
#import "iRate+Refuge.h"
#import <Mixpanel.h>
#import "Mixpanel+Refuge.h"
#import "RefugeAppState.h"

#define REFUGE_MIXPANEL_TOKEN @"5140bc4b6ebcb9fe05feb7bc7bf7ed11"
static NSString *const kRefugeGooglePlacesAutocompleteApiKey = @"AIzaSyAs1N-hce2hD16SJyh-QGbpeZIwv5mCSlY";
@interface RefugeAppDelegate ()
//<JPUSHRegisterDelegate>
@property (nonatomic, strong) RefugeAppState *appState;
@end
@implementation RefugeAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.appState = [[RefugeAppState alloc] initWithUserDefaults:[NSUserDefaults standardUserDefaults]];
    [self setupSearch];
    [self setupRatingPrompt];
    [self setupAnalytics];
    [self setupCrashReporting];
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//    }
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    [JPUSHService setupWithOption:launchOptions appKey:@"73269ce046ed48e43576bc9b"
//                          channel:@"Rest"
//                 apsForProduction:NO];
//
//    UIApplication.sharedApplication.applicationIconBadgeNumber = 0;
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    UIApplication.sharedApplication.applicationIconBadgeNumber = 0;
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}
/*- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert);
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
} */
#pragma mark - Core Data stack
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory
{
    return
        [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"refuge_ios" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"refuge_ios.sqlite"];
    if (self.appState.hasPreloadedRestrooms == NO) {
        [self preloadRestroomData:storeURL];
    }
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}
#pragma mark - Core Data Saving support
- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark - Private methods
- (void)preloadRestroomData:(NSURL *)storeURL
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
        NSURL *preloadURL =
            [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"RefugeRestroomsSeed" ofType:@"sqlite"]];
        NSError *error = nil;
        if (![[NSFileManager defaultManager] copyItemAtURL:preloadURL toURL:storeURL error:&error]) {
            [[Mixpanel sharedInstance] refugeTrackError:error ofType:RefugeMixpanelErrorTypePreloadingRestrooms];
        } else {
            self.appState.hasPreloadedRestrooms = YES;
        }
    }
}
- (void)setupSearch
{
    [HNKGooglePlacesAutocompleteQuery setupSharedQueryWithAPIKey:kRefugeGooglePlacesAutocompleteApiKey];
}
- (void)setupRatingPrompt
{
    [[iRate sharedInstance] refugeSetup];
}
- (void)setupAnalytics
{
    [Mixpanel sharedInstanceWithToken:REFUGE_MIXPANEL_TOKEN];
    [[Mixpanel sharedInstance] refugeRegisterSuperProperties];
    [[Mixpanel sharedInstance] refugeTrackAppLaunch];
}
- (void)setupCrashReporting
{
    [Fabric with:@[ CrashlyticsKit ]];
}
@end
