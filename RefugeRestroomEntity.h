#import <CoreData/CoreData.h>
@interface RefugeRestroomEntity : NSManagedObject
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign) NSNumber *isAccessible;
@property (nonatomic, assign) NSNumber *isUnisex;
@property (nonatomic, assign) NSNumber *numUpvotes;
@property (nonatomic, assign) NSNumber *numDownvotes;
@property (nonatomic, assign) NSNumber *ratingNumber;
@property (nonatomic, strong) NSString *directions;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSDecimalNumber *latitude;
@property (nonatomic, strong) NSDecimalNumber *longitude;
@property (nonatomic, strong) NSDate *createdDate;
@end
