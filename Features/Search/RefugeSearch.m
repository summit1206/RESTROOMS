#import "RefugeSearch.h"
#import <CoreLocation/CoreLocation.h>
#import "RefugeMapPlace.h"
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocomplete.h>
@interface RefugeSearch ()
@property (nonatomic, strong) HNKGooglePlacesAutocompleteQuery *searchQuery;
@end
@implementation RefugeSearch
#pragma mark - Initializers
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.searchQuery = [HNKGooglePlacesAutocompleteQuery sharedQuery];
    }
    return self;
}
#pragma mark - Public methods
- (void)searchForPlaces:(NSString *)searchString
                success:(void (^)(NSArray *))searchSuccess
                failure:(void (^)(NSError *))searchError
{
    [self.searchQuery fetchPlacesForSearchQuery:searchString
                                     completion:^(NSArray *places, NSError *error) {
                                         if (error) {
                                             searchError(error);
                                         } else {
                                             NSArray *refugeMapPlaces = [self translateToRefugePlaces:places];
                                             searchSuccess(refugeMapPlaces);
                                         }
                                     }];
}
#pragma mark - Private methods
- (NSArray *)translateToRefugePlaces:(NSArray *)places
{
    NSMutableArray *array = [NSMutableArray array];
    for (HNKGooglePlacesAutocompletePlace *place in places) {
        RefugeMapPlace *refugeMapPlace = [[RefugeMapPlace alloc] init];
        refugeMapPlace.name = place.name;
        refugeMapPlace.placeId = place.placeId;
        refugeMapPlace.key = self.searchQuery.apiKey;
        if (([place.types count] == 1) && [place isPlaceType:HNKGooglePlaceTypeGeocode]) {
            refugeMapPlace.type = RefugeMapPlaceTypeGeocode;
        } else {
            refugeMapPlace.type = RefugeMapPlaceTypeEstablishment;
        }
        [array addObject:refugeMapPlace];
    }
    return [array copy];
}
@end
