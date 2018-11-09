#import <MapKit/MapKit.h>
#import "RefugeMapDelegate.h"
#import "RefugeRestroomManagerDelegate.h"
@interface RefugeMapViewController
    : UIViewController <CLLocationManagerDelegate, RefugeMapDelegate, RefugeRestroomManagerDelegate,
                        UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@end
