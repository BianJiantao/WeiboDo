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
            
            if let vc = viewController as? WBBaseViewController {
                
                var title = "返回"  // 默认导航条返回按钮文字是 "返回"
                
                if childViewControllers.count == 1 { // 第一级 push 的控制器返回按钮文字用上一级控制器的 title
                    
                    title = childViewControllers.first?.title ?? "返回"
                    
                }
                
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(back))
            }
            
            
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    /// 返回按钮点击监听方法
    @objc fileprivate func back(){
        
        popViewController(animated: true)
    }
    
}
