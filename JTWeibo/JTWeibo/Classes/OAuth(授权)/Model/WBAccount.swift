//
//  WBAccount.swift
//  JTWeibo
//
//  Created by BJT on 17/7/13.
//  Copyright © 2017年 BJT. All rights reserved.
// 账户模型

import UIKit

class WBAccount: NSObject {

    
    /// 访问令牌
    var access_token: String? // = "2.00WKSdoG6a1eKB389a618b50dvgDPB"
    
    /// 用户代号
    var uid: String?
    
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
    
    
}
