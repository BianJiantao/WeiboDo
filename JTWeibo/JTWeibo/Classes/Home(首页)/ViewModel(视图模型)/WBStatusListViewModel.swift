//
//  WBStatusListViewModel.swift
//  JTWeibo
//
//  Created by BJT on 17/7/12.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博列表视图模型
// 负责微博数据处理
// 1. 字典船模型
// 2. 上/下拉刷新

import Foundation

class WBStatusListViewModel {
    
    // 微博模型列表懒加载
    lazy var statusList = [WBStatus]()
    
    
    /// 加载微博数据
    ///
    /// - parameter completion: 完成回调 
    func loadStatus(completion:@escaping (_ isSuccess:Bool)->()){
        
        WBNetworkManager.shared.statusList { (list, isSuccess) in
            
            // 字典抓 模型
            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list) as? [WBStatus] else {
                
                completion(isSuccess)
                return
            }
            
            // 拼接数据
            self.statusList += array
            // 完成回调
            completion(isSuccess)
            
        }
        
    }
    
    
    
}
