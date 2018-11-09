#import "NSDate+Refuge.h"
static NSString *const kRefugeDateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
@implementation NSDate (Refuge)
#pragma mark - Public methods
+ (NSString *)RefugeDateFormat
{
    return kRefugeDateFormat;
}
+ (NSDate *)RefugeDateFromString:(NSString *)dateString
{
    return [self.RefugeDateFormatter dateFromString:dateString];
}
+ (NSString *)RefugeStringFromDate:(NSDate *)date
{
    return [self.RefugeDateFormatter stringFromDate:date];
}
#pragma mark - Private methods
+ (NSDateFormatter *)RefugeDateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = kRefugeDateFormat;
    return dateFormatter;
}
@end
