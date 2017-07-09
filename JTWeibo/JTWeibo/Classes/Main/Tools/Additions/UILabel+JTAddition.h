

#import <UIKit/UIKit.h>

@interface UILabel (JTAddition)

/// 创建文本标签
///
/// @param text     文本
/// @param fontSize 字体大小
/// @param color    颜色
///
/// @return UILabel
+ (instancetype)labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color;

@end
