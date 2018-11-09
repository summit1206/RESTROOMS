#import "NSString+Refuge.h"
@implementation NSString (Refuge)
- (instancetype)RefugePrepareForDisplay
{
    return [self stringByReplacingOccurrencesOfString:@"\\'" withString:@"\'"];
}
@end
