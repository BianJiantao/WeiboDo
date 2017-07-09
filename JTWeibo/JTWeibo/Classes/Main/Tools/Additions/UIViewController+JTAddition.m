

#import "UIViewController+JTAddition.h"

@implementation UIViewController (JTAddition)
/**
 *  添加子控制器
 *
 *  @param childVc     要添加的子控制器
 *  @param contentView 子控制器view的父控件
 */
- (void)addChildViewController:(UIViewController *)childVc intoView:(UIView *)contentView{
    // 添加控制器的view
    [contentView addSubview:childVc.view];
    // 添加子控制器
    [self addChildViewController:childVc];
    // 完成子控制器的添加
    [childVc didMoveToParentViewController:self];
}
@end
