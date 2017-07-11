//
//  WBNetworkManager.swift
//  JTWeibo
//
//  Created by BJT on 17/7/11.
//  Copyright © 2017年 BJT. All rights reserved.
// 网络管理工具

import UIKit
import AFNetworking

class WBNetworkManager: AFHTTPSessionManager {

    // 单例  --- 静态区/常量 , 闭包
    // 第一次访问时执行闭包,并且将结果用 shared常量 保存
    static let shared = WBNetworkManager()
    
}
