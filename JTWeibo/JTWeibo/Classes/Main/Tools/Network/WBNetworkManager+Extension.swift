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
    
}
