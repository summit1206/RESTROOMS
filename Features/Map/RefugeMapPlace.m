#import "RefugeMapPlace.h"
#import "CLPlacemark+HNKAdditions.h"
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocomplete.h>
@implementation RefugeMapPlace
#pragma mark - Public methods
- (void)resolveToPlacemarkWithSuccessBlock:(void (^)(CLPlacemark *))placemarkSuccess
                                   failure:(void (^)(NSError *))placemarkError
{
    HNKGooglePlacesAutocompletePlace *place = [self translateToHNKPlace];
    [CLPlacemark hnk_placemarkFromGooglePlace:place
                                       apiKey:self.key
                                   completion:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
                                       if (error) {
                                           placemarkError(error);
                                       } else {
                                           placemarkSuccess(placemark);
                                       }
                                   }];
}
#pragma mark - Private methods
- (HNKGooglePlacesAutocompletePlace *)translateToHNKPlace
{
    NSString *typeString = [self typeToString];
    NSDictionary *placeJSON = @{
        @"description" : self.name,
        @"id" : @"N/A",
        @"matched_substrings" : @[],
        @"place_id" : self.placeId,
        @"reference" : @"N/A",
        @"terms" : @[],
        @"types" : @[ typeString ]
    };
    HNKGooglePlacesAutocompletePlace *place = [HNKGooglePlacesAutocompletePlace modelFromJSONDictionary:placeJSON];
    return place;
}
- (NSString *)typeToString
{
    if (self.type == RefugeMapPlaceTypeGeocode) {
        return @"geocode";
    } else {
        return @"establishment";
    }
}
@end
