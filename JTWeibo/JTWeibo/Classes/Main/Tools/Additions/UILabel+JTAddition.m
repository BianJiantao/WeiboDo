
#import "UILabel+JTAddition.h"

@implementation UILabel (JTAddition)

+ (instancetype)labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    
    return label;
}

@end
