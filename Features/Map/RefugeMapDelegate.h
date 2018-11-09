#import <MapKit/MapKit.h>
@class RefugeMapPin;
@protocol RefugeMapDelegate <NSObject>
- (void)tappingCalloutAccessoryDidRetrievedSingleMapPin:(RefugeMapPin *)mapPin;
- (void)retrievingSingleMapPinFromCalloutAccessoryFailed:(RefugeMapPin *)firstPinRetrieved;
@end
