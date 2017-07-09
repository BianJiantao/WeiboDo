//
//  WBNavigationController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        
        navigationBar.isHidden = true
    }

    // 重写 push 方法, 隐藏底部 tabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 { // 不是栈底控制器
            
            // 隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
}
