//
//  WBTabbarController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

class WBTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupChildControllers()

    }
    
    

}

extension WBTabbarController{
    
    /// 设置子控制器
    fileprivate func setupChildControllers() {
        
        let array = [
            ["clsName":"WBHomeViewController","title":"首页","imageName":"home"],
            ["clsName":"WBMessageViewController","title":"消息","imageName":"message_center"],
            ["clsName":"WBDiscoverViewController","title":"发现","imageName":"discover"],
            ["clsName":"WBProfileViewController","title":"我","imageName":"profile"]
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controllerWithDict(dict: dict))
        }
        viewControllers = arrayM
        
       
    }
    
    
    /// 利用字典创建一个子控制器
    ///
    /// - parameter dict: 控制器信息字典[clsName , title , imageName]
    ///
    /// - returns: 子控制器
    private func controllerWithDict(dict:[String : String]) -> UIViewController{
        
        // 取出字典内容
        guard let clsName = dict["clsName"],
              let title = dict["title"],
              let imageName = dict["imageName"],
              let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type  else{
                
            return UIViewController()
        }
        
        // 创建控制器
        let vc = cls.init()
        // 设置title , image
        vc.title = title
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        let nav = WBNavigationController(rootViewController: vc)
        
        return nav
        
        
    }
    
    
    
}
