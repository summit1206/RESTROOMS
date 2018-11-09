#import "UIImage+Refuge.h"
@implementation UIImage (Refuge)
+ (UIImage *)RefugeResizeImageNamed:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height
{
    CGSize newSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(newSize);
    [[UIImage imageNamed:imageName] drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}
@end
