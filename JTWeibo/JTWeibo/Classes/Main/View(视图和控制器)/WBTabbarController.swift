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
        
        // 界面的创建依赖于网络请求的 json
        let array:[[String:Any]] = [
            [
             "clsName":"WBHomeViewController",
             "title":"首页",
             "imageName":"home",
             "visitorViewInfo":["imageName":"",
                                "message":"关注一些人，回这里看看有什么惊喜"]
            ],
            
            [
             "clsName":"WBMessageViewController",
             "title":"消息",
             "imageName":"message_center",
             "visitorViewInfo":["imageName":"visitordiscover_image_message",
                                "message":"登陆后，别人评论你的微博，发给你的消息，都会在这里收到通知"]
            ],
            
            ["clsName":"UIViewController"],
            
            [
             "clsName":"WBDiscoverViewController",
             "title":"发现",
             "imageName":"discover",
             "visitorViewInfo":["imageName":"visitordiscover_image_message",
                                "message":"登陆后，最新、最热的微博尽在掌握中，不会再于实事潮流擦肩而过"]
            ],
            
            [
             "clsName":"WBProfileViewController",
             "title":"我",
             "imageName":"profile",
             "visitorViewInfo":["imageName":"visitordiscover_image_profile",
                                "message":"登陆后，你的微博、相册、个人资料会显示在这里，展示给别人"]
            ]
        ]
        // 测试数据格式是否在正确, 转换成 plist 查看
//        (array as NSArray).write(toFile: "/Users/bjt/Desktop/JTWeibo.plist", atomically: true)
        
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
    private func controllerWithDict(dict:[String : Any]) -> UIViewController{
        
        // 取出字典内容
        guard let clsName = dict["clsName"] as? String ,
              let title = dict["title"] as? String ,
              let imageName = dict["imageName"] as? String ,
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
