#import <CoreLocation/CoreLocation.h>
@interface RefugeMapPlace : NSObject
typedef NS_ENUM(NSInteger, RefugeMapPlaceType) { RefugeMapPlaceTypeGeocode, RefugeMapPlaceTypeEstablishment };
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, assign) RefugeMapPlaceType type;
@property (nonatomic, strong) NSString *key;
- (void)resolveToPlacemarkWithSuccessBlock:(void (^)(CLPlacemark *placemark))placemarkSuccess
                                   failure:(void (^)(NSError *error))placemarkError;
@end
