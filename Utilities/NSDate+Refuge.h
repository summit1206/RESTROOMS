#import <Foundation/Foundation.h>
@interface NSDate (Refuge)
+ (NSString *)RefugeDateFormat;
+ (NSDate *)RefugeDateFromString:(NSString *)dateString;
+ (NSString *)RefugeStringFromDate:(NSDate *)date;
@end
