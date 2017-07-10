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
        setupComposeButton()

    }
    
    // 设置设备方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // MARK: - 监听方法
    /// 发微博
    // FIXME: 没有实现
     @objc fileprivate func composeStatus(){
        print("发微博")
    }
    
    
    // MARK: - 私有控件
    // 加号按钮
    fileprivate lazy var composeButton : UIButton = UIButton.imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")

}

// MARK: - 设置界面
extension WBTabbarController{
    
    
    /// 设置加号按钮
    fileprivate func setupComposeButton(){
        tabBar.addSubview(composeButton)
        
//        composeButton.center.x = tabBar.bounds.width * 0.5
//        composeButton.center.y = tabBar.bounds.height * 0.5
        
        let count = CGFloat(childViewControllers.count)
        // TIPS :  -1 是为了 减小加号按钮的缩进, 使其宽度增大,盖住按钮之间的容错点,点击按钮时就不会穿帮了
        let w = tabBar.bounds.width / count - 1
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w , dy: 0)
        
        // 按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
        
        
    }
    
    /// 设置子控制器
    fileprivate func setupChildControllers() {
        
        let array = [
            ["clsName":"WBHomeViewController","title":"首页","imageName":"home"],
            ["clsName":"WBMessageViewController","title":"消息","imageName":"message_center"],
            ["clsName":"UIViewController"],
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
        // 设置title , 字体(默认是12), 选中时颜色
        vc.title = title
        vc.tabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName:UIColor.orange],
            for: .highlighted)
// TIPS : 设置字体大小 , 要设置 normal 状态字体大小
        vc.tabBarItem.setTitleTextAttributes(
            [NSFontAttributeName:UIFont.systemFont(ofSize: 13)],
            for:.normal)
        
        // 设置 image
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        
        let nav = WBNavigationController(rootViewController: vc)
        
        return nav
        
        
    }
    
    
    
}
