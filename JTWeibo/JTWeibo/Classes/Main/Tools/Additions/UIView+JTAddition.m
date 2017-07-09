//
//  UIView+CZAddition.m
//  003-
//
//  Created by 张杰 on 16/5/11.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "UIView+JTAddition.h"

@implementation UIView (JTAddition)

- (UIImage *)snapshotImage {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
