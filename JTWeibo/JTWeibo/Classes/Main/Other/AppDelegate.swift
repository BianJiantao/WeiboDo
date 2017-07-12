//
//  AppDelegate.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // #available 检测设备版本
        if #available(iOS 10, *) { // iOS 10.0 以后
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.carPlay,.alert,.sound], completionHandler: { (success, error) in
                print("授权" + (success ? "成功":"失败"))
            })
            
        } else { // iOS 10.0 以前
            
            let notificationSettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
        }
        
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBTabbarController()
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }

}

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
