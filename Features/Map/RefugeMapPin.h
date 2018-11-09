#import <MapKit/MapKit.h>
@class RefugeRestroom;
@interface RefugeMapPin : NSObject <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;
@property (nonatomic, copy, readonly) RefugeRestroom *restroom;
- (id)initWithRestroom:(RefugeRestroom *)restroom;
@end
