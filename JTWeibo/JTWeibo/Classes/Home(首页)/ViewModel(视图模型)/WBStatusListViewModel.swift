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
    /// - parameter pullupRefresh: 是否上拉刷新
    /// - parameter completion:    完成回调
    func loadStatus(pullupRefresh:Bool,completion:@escaping (_ isSuccess:Bool)->()){
        
        let since_id =  pullupRefresh ? 0 : (statusList.first?.id ?? 0)
        
        let max_id =  (!pullupRefresh) ? 0 : (statusList.last?.id ?? 0)
        
        
        WBNetworkManager.shared.statusList(since_id:since_id, max_id: max_id) { (list, isSuccess) in
            
            // 字典转模型  (注意 list 是可选项 , 要解包)
            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else {
                
                completion(isSuccess)
                return
            }
            
            // 拼接数据
            if pullupRefresh { // 上拉刷新
                
                self.statusList += array
            }else{ // 下拉刷新
                
                self.statusList = array + self.statusList
            }
            
            // 完成回调
            completion(isSuccess)
            
        }
        
    }
    
    
    
}
