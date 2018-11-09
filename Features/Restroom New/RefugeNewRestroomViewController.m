#import "RefugeNewRestroomViewController.h"
#import "Mixpanel+Refuge.h"
static NSString *const kRefugeUrlNewRestroom = @"http://www.refugerestrooms.org/restrooms/new?mobile=true";
@interface RefugeNewRestroomViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@end
@implementation RefugeNewRestroomViewController
#pragma mark - View life-cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    self.errorView.hidden = YES;
    NSURL *url = [NSURL URLWithString:kRefugeUrlNewRestroom];
    NSURLRequest *urlResquest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlResquest];
}
#pragma mark - Public methods
#pragma mark UIWebViewDelegate methods
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.loadingView.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[Mixpanel sharedInstance] refugeTrackError:error ofType:RefugeMixpanelErrorTypeLoadingNewRestroomWebViewFailed];
    self.loadingView.hidden = YES;
    self.errorView.hidden = NO;
}
@end
