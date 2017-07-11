//
//  WBNetworkManager.swift
//  JTWeibo
//
//  Created by BJT on 17/7/11.
//  Copyright © 2017年 BJT. All rights reserved.
// 网络管理工具(不局限于此项目,通用的)

import UIKit
import AFNetworking

enum WBHTTPMethod {
    case GET
    case POST
}

class WBNetworkManager: AFHTTPSessionManager {

    // 单例  --- 静态区/常量 , 闭包
    // 第一次访问时执行闭包,并且将结果用 shared常量 保存
    static let shared = WBNetworkManager()
    
    /// 使用一个函数封装AFN 的的GET /POST请求
    ///
    /// - parameter method:     GET /POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter completion: 请求的回调代码
    func request(method:WBHTTPMethod = .GET,URLString: String, parameters:[String:Any],completion:@escaping (_ json:Any?,_ isSuccess:Bool)->()){
        
        // 成功的回调
        let success = { (task:URLSessionTask , json:Any?)->() in
            
            completion(json, true)
        }
        // 失败的回调
        let failure = {(task:URLSessionTask? , error:Error)->() in
            print("网络请求错误\(error)")
            completion(nil, false)
        }
        
        if method == .GET {
            
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    
   
    }
    
    
}
