//
//  WBNetworkManager+Extension.swift
//  JTWeibo
//
//  Created by BJT on 17/7/11.
//  Copyright © 2017年 BJT. All rights reserved.
// 封装微博的网络请求方法

import Foundation

extension WBNetworkManager {
    
    /// 加载微博数据字典数组
    ///
    /// - parameter since_id:   则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    /// - parameter max_id:     回ID小于或等于max_id的微博，默认为0
    /// - parameter completion: 完成的回调
    func statusList(since_id:Int64 = 0,max_id:Int64 = 0,completion:@escaping (_ list:[[String : AnyObject]]?,_ isSuccess:Bool)->()){
        
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let params = ["since_id":since_id,
                      "max_id":max_id > 0 ? max_id-1 : 0]
        
        tokenRequest(URLString: urlStr, parameters: params) { (json , isSuccess) in
            
            let result = (json as? [String:Any])?["statuses"]  as? [[String:AnyObject]]
            
            completion(result,isSuccess)
            
        }
        
        
    }
    
    
    /// 获取微博未读数
    ///
    /// - parameter completion: 完成的回调 (未读数)
    func unreadCount(completion:@escaping (_ count:Int)->()){
        
        guard let uid = account.uid else {
            return
        }
        
        let urlStr = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid":uid]
        
        tokenRequest(URLString: urlStr, parameters: params) { (json, isSuccess) in
            
            let dict = json as? [String:AnyObject]
            let count = dict?["status"] as? Int
            completion(count ?? 0)
            
        }
    }
    
}

// MARK: - OAuth 相关方法
extension WBNetworkManager {
    
    /// 用授权码 code 换取 AccessToken
    ///
    /// - parameter code:      授权码
    /// - parameter comletion: 完成的回调
    func loadAccessToken(code:String,comletion:@escaping (_ isSuccess:Bool)->()) {
        
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        let params = [
            "client_id":WBAppKey,
            "client_secret":WBAppSecret,
            "grant_type":"authorization_code",
            "code":code,
            "redirect_uri":WBAppRedirectUri]
        
        request(method: .POST, URLString: urlStr, parameters: params) { (json, isSuccess) in
            print(json)
            
            // 字典转模型
            self.account.yy_modelSet(with: (json as? [String:AnyObject]) ?? [:])
            print(self.account)
            
            self.account.saveAccount()
            comletion(isSuccess)
            
        }
        
    }
    
}

