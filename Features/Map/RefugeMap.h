#import "ADClusterMapView.h"
#import "RefugeMapDelegate.h"
@interface RefugeMap : ADClusterMapView <ADClusterMapViewDelegate>
@property (nonatomic, weak) id<RefugeMapDelegate> mapDelegate;
@end
