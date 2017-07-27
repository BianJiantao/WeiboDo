//
//  WBNetworkManager.swift
//  JTWeibo
//
//  Created by BJT on 17/7/11.
//  Copyright © 2017年 BJT. All rights reserved.
// 网络管理工具

import UIKit
import AFNetworking

enum WBHTTPMethod {
    case GET
    case POST
}

class WBNetworkManager: AFHTTPSessionManager {

    // 单例  --- 静态区/常量 , 闭包
    // 第一次访问时执行闭包,并且将结果用 shared常量 保存
    static let shared : WBNetworkManager = {
        
        let instance = WBNetworkManager()
        // 设置响应反序列支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        
        return instance
    }()
    
//    // 访问令牌
//    var accessToken:String? //= "2.00WKSdoG6a1eKB389a618b50dvgDPB"
//    // uid
//    var uid : String? = "6244978428"
    
    
    lazy var account = WBAccount()
    
    // 登录标识符
    var userLogon :Bool{
        return (account.access_token != nil)
    }
    
    func tokenRequest(method:WBHTTPMethod = .GET,URLString: String, parameters:[String:Any]?,completion:@escaping (_ json:Any?,_ isSuccess:Bool)->()){
        
        // 判断令牌是否为 nil
        guard let token = account.access_token else {
            
            print("没有 token!需要登录")
            completion(nil,false)
            // 发出通知,登录
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
            
            return
        }
        
        // 判断参数字典是否存在
        var params = parameters
        if parameters == nil { // 不存在,创建
            params = [String:AnyObject]()
        }
        
        // 此处params一定有值,强行解包
        params!["access_token"] = token
        
//        request(URLString: URLString, parameters: params, completion: completion)
        request(method: method, URLString: URLString, parameters: params, completion: completion)
    }
    
    
    /// 使用一个函数封装AFN 的的GET /POST请求
    ///
    /// - parameter method:     GET /POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter completion: 请求的回调代码
    func request(method:WBHTTPMethod = .GET,URLString: String, parameters:[String:Any]?,completion:@escaping (_ json:Any?,_ isSuccess:Bool)->()){
        
        // 成功的回调
        let success = { (task:URLSessionTask , json:Any?)->() in
            
            completion(json, true)
        }
        // 失败的回调
        let failure = {(task:URLSessionTask? , error:Error)->() in
            
            // 针对 403 错误,处理用户 token 过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token过期")
                // 发出通知,重新登录
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: "bad token")
            }
            
            
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
