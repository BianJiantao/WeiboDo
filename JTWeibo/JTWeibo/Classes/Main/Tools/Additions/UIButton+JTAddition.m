

#import "UIButton+JTAddition.h"
#import "UIImage+JTAddition.h"

@implementation UIButton (JTAddition)
+ (instancetype)textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor {
    return [self textButton:title fontSize:fontSize normalColor:normalColor highlightedColor:highlightedColor backgroundImageName:nil];
}

+ (instancetype)textButton:(NSString *)title fontSize:(CGFloat)fontSize backGroundNormalColor:(UIColor *)normalColor backGroundHighlightedColor:(UIColor *)highlightedColor {
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageWithColor:normalColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:highlightedColor] forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    button.layer.masksToBounds = YES;
//    button.layer.cornerRadius = kBtnCorHeight;
    button.layer.borderWidth = 2;
    button.layer.borderColor = highlightedColor.CGColor;
    
    CALayer *layer = [CALayer layer];
    layer.frame = button.bounds;
    layer.backgroundColor = highlightedColor.CGColor;
    layer.shadowOffset = CGSizeMake(10, 10);
    layer.shadowOpacity = 0.5;
    layer.shadowRadius = 5;// 阴影扩散的范围控制
    
    [button.layer addSublayer:layer];
    
    [button sizeToFit];
    
    return button;
}

+ (instancetype)textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    if (backgroundImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
        
        NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
    }
    
    [button sizeToFit];
    
    return button;
}

+ (instancetype)imageButton:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSString *imageNameHL = [imageName stringByAppendingString:@"_highlighted"];
    [button setImage:[UIImage imageNamed:imageNameHL] forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    
    NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    
    return button;
}

+ (instancetype)imageButton:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName {
    UIButton *button = [[self alloc] init];
    
    //    [button setBackgroundColor:[UIColor clearColor]];
    
    [button setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    
    [button sizeToFit];
    
    return button;
}

@end
