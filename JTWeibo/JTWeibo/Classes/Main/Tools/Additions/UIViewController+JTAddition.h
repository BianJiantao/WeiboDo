

#import <UIKit/UIKit.h>

@interface UIViewController (JTAddition)
/**
 *  添加子控制器
 *
 *  @param childVc     要添加的子控制器
 *  @param contentView 子控制器view的父控件
 */
- (void)addChildViewController:(UIViewController *)childVc intoView:(UIView *)contentView;
@end
