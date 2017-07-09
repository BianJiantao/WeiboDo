
#import <UIKit/UIKit.h>

@interface UIImage (JTAddition)
/**
 *  颜色转换为图片
 *
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  vImage图片模糊
 *
 *
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/**
 *  高斯图片模糊
 *
 *
 */
+ (UIImage *)coreBlurImage:(UIImage *)image
            withBlurNumber:(CGFloat)blur;
@end
