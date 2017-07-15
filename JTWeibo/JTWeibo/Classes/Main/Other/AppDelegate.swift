//
//  AppDelegate.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupCommonSetting()
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBTabbarController()
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }

}

// MARK: - 应用程序的基本设置
extension AppDelegate{
    
     /// 基本设置
     fileprivate func setupCommonSetting(){
        
        // SVProgressHUD 的显示时间设置
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        // AFNetwork 网络指示器设置
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        // 设置用户授权显示通知
        // #available 检测设备版本
        if #available(iOS 10, *) { // iOS 10.0 以后
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.carPlay,.alert,.sound], completionHandler: { (success, error) in
                print("授权" + (success ? "成功":"失败"))
            })
            
        } else { // iOS 10.0 以前
            
            let notificationSettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        }
        
        
    }
}


// MARK: - 模拟从服务器加载界面配置信息
extension AppDelegate {
    
    /// 模拟网络加载 json 界面配置文件
    fileprivate func loadAppInfo(){
        
        // 模拟异步
        DispatchQueue.global().async{
            
            let url = Bundle.main.url(forResource: "JTWeibo.json", withExtension: nil)
            let data = NSData(contentsOf: url!)
            
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("JTWeibo.json")
            // 写入沙盒,供程序下次启动时使用
            data?.write(toFile: jsonPath, atomically: true)
            
            print("应用程序网络加载json完毕\(jsonPath)")
        }
        
        
        
    }
    
}
