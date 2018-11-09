#import "iRate+Refuge.h"
static NSUInteger const kRefugeAppID = 968531953;
@implementation iRate (Refuge)
- (void)refugeSetup
{
    [iRate sharedInstance].appStoreID = kRefugeAppID;
    [iRate sharedInstance].daysUntilPrompt =
        3; 
    [iRate sharedInstance].usesUntilPrompt =
        3; 
    [iRate sharedInstance].usesPerWeekForPrompt =
        0; 
    [iRate sharedInstance].remindPeriod =
        10; 
    [iRate sharedInstance].messageTitle = @"Enjoying REFUGE?"; 
    [iRate sharedInstance].message = @"Rating REFUGE positively encourages others to use it.";
    [iRate sharedInstance]
        .updateMessage = @"REFUGE was updated! If you're still enjoying it or the improvements, please take a minute "
                         @"to rate."; 
    [iRate sharedInstance].cancelButtonLabel =
        @"No"; 
    [iRate sharedInstance].rateButtonLabel = @"Yes! I'd like to rate it"; 
    [iRate sharedInstance].remindButtonLabel =
        @"Yes, I'd like to rate it later";                       
    [iRate sharedInstance].promptForNewVersionIfUserRated = YES; 
    [iRate sharedInstance].onlyPromptIfLatestVersion =
        YES; 
    [iRate sharedInstance].previewMode =
        NO; 
}
@end
