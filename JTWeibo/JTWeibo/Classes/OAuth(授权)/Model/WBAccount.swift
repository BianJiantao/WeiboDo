//
//  WBAccount.swift
//  JTWeibo
//
//  Created by BJT on 17/7/13.
//  Copyright © 2017年 BJT. All rights reserved.
// 账户模型

import UIKit

/// 账户文件名
private let accountFile: NSString = "account.json"

class WBAccount: NSObject {

    
    /// 访问令牌
    var access_token: String? // = "2.00WKSdoG6a1eKB389a618b50dvgDPB"
    
    /// 用户代号
    var uid: String?
    
    /// 用户昵称
    var screen_name: String?
    
    /// 用户头像地址（中国） 58 * 58 像素
    var profile_image_url: String?
    
    /// access_token 的生命周期 开发者5年 使用者3天, 单位是秒数
    var expires_in: TimeInterval = 0{
        didSet{
            // 秒数转成日期
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    /// 过期日期
    var expiresDate:Date?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    
    override init() {
        super.init()
        // 从沙盒加载账户文件  -->字典 , 失败则直接返回
        guard let path = accountFile.appendDocumentDir(),
            let data = NSData(contentsOfFile: path) ,
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:AnyObject]else {
                return
        }
        
        // 利用字典给账户模型的属性设值
        yy_modelSet(with: dict ?? [:])
        
        // 判断 token 是否过期
//        expiresDate = Date(timeIntervalSinceNow: -3600*24)
        if expiresDate?.compare(Date()) != .orderedDescending { // 过期
            // 清空 token , UID
            access_token = nil
            uid = nil
            
            // 删除沙盒账户信息文件
            try? FileManager.default.removeItem(atPath: path)
            
        }
        
        
        
    }
    
    
    /// 保存账户到沙盒
    func saveAccount(){
        
        // 模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String:AnyObject]) ?? [:]
        
        // 删除 expires_in 值
        dict.removeValue(forKey: "expires_in")
        
        // 字典序列化
       guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]),
        let filePath = accountFile.appendDocumentDir() else{
            return
        }
        
        (data as NSData).write(toFile: filePath, atomically: true)
        print("账户保存成功:\(filePath)")
        
        
    }
    
    
}
