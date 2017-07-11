//
//  AppDelegate.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBTabbarController()
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }

}

extension AppDelegate {
    
    fileprivate func loadAppInfo(){
        
        let url = Bundle.main.url(forResource: "JTWeibo.json", withExtension: nil)
        let data = NSData(contentsOf: url!)
        
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("JTWeibo.json")
        
        data?.write(toFile: jsonPath, atomically: true)
        
        print("应用程序网络加载json完毕\(jsonPath)")
        
        
    }
    
}
