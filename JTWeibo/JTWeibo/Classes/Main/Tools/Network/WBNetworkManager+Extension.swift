//
//  WBNetworkManager+Extension.swift
//  JTWeibo
//
//  Created by BJT on 17/7/11.
//  Copyright © 2017年 BJT. All rights reserved.
// 封装微博的网络请求方法(适用于本项目)

import Foundation

extension WBNetworkManager {
    
    /// 加载微博数据字典数组
    ///
    /// - parameter completion: 完成的回调
    func statusList(completion:@escaping (_ list:[[String : AnyObject]]?,_ isSuccess:Bool)->()){
        
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token":"2.00WKSdoG6a1eKB389a618b50dvgDPB"]
        
        request(URLString: urlStr, parameters: params) { (json , isSuccess) in
            
            let result = (json as? [String:Any])?["statuses"]  as? [[String:AnyObject]]
            
            completion(result,isSuccess)
            
        }
        
    }
    
}
