#import "RefugeInfoViewController.h"
#import "Mixpanel+Refuge.h"
NSString *RefugeInfoViewErrorDomain = @"RefugeInfoViewErrorDomain";
static NSInteger const kRefugeInfoErrorCode = 0;
static NSString *const kRefugeGithubLinkName = @"https://github.com/summit1206/RESTROOMS";
static NSString *const kRefugeFacebookLinkName = @"https://www.facebook.com/DalyBartlett";
static NSString *const kRefugeTwittetLinkName = @"https://twitter.com/rAFGp6TlHR4CwLb";
@interface RefugeInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *githubImage;
@property (weak, nonatomic) IBOutlet UIImageView *facebookImage;
@property (weak, nonatomic) IBOutlet UIImageView *twitterImage;
@end
@implementation RefugeInfoViewController
#pragma mark - View life-cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addGestureRecognizersToImages];
}
#pragma mark - Touch
- (void)didTouchGithubImage
{
    [self openLinkWithName:kRefugeGithubLinkName];
}
- (void)didTouchFacebookImage
{
    [self openLinkWithName:kRefugeFacebookLinkName];
}
- (void)didTouchTwitterImage
{
    [self openLinkWithName:kRefugeTwittetLinkName];
}
#pragma mark - Private methods
- (void)addGestureRecognizersToImages
{
    UITapGestureRecognizer *githubGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchGithubImage)];
    [self.githubImage addGestureRecognizer:githubGestureRecognizer];
    UITapGestureRecognizer *facebookGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchFacebookImage)];
    [self.facebookImage addGestureRecognizer:facebookGestureRecognizer];
    UITapGestureRecognizer *twitterGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchTwitterImage)];
    [self.twitterImage addGestureRecognizer:twitterGestureRecognizer];
}
- (void)openLinkWithName:(NSString *)linkName
{
    NSURL *url = [NSURL URLWithString:linkName];
    if (![[UIApplication sharedApplication] openURL:url]) {
        [self reportErrorOpeningLinkWithName:linkName];
    }
}
- (void)reportErrorOpeningLinkWithName:(NSString *)linkName
{
    NSDictionary *userInfo =
        @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Could not open link: %@", linkName] };
    NSError *error = [NSError errorWithDomain:RefugeInfoViewErrorDomain code:kRefugeInfoErrorCode userInfo:userInfo];
    [[Mixpanel sharedInstance] refugeTrackError:error ofType:RefugeMixpanelErrorTypeOpeningLinkFailed];
}
@end
