//
//  WBStatusListViewModel.swift
//  JTWeibo
//
//  Created by BJT on 17/7/12.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博列表视图模型
// 负责微博数据处理
// 1. 字典转模型
// 2. 上/下拉刷新

import Foundation
// 最大连续上拉刷新尝试次数
private let maxPullupTryTimes = 3

class WBStatusListViewModel {
    
    // 微博模型列表懒加载
    lazy var statusList = [WBStatusViewModel]()
    // 上拉刷新尝试次数
    var pullupTryTimes = 0
    
    /// 加载微博数据 
    ///
    /// - parameter pullupRefresh: 是否上拉刷新
    /// - parameter completion:    完成回调(是否成功,是否刷新表格)
    func loadStatus(pullupRefresh:Bool,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->())
    {
        
        if pullupRefresh && (pullupTryTimes > maxPullupTryTimes) { // 连续上拉刷新超过上限
            completion(true,false)
        }
        
        let since_id =  pullupRefresh ? 0 : (statusList.first?.status.id ?? 0)
        let max_id =  (!pullupRefresh) ? 0 : (statusList.last?.status.id ?? 0)
        
        WBNetworkManager.shared.statusList(since_id:since_id, max_id: max_id) { (list, isSuccess) in
            
            // 判断网络请求是否成功
            if !isSuccess {
                // 直接返回
                completion(false, false)
                return
            }
            // 字典转模型
            var array = [WBStatusViewModel]()
            
            // 遍历服务器返回的字典数组，字典转模型
            for dic in list ?? [] {
                
                // 创建微博模型 - 创建失败 继续遍历
                guard let model = WBStatus.yy_model(with: dic) else{
                    continue
                }
                // 将视图模型添加到数组
                array.append(WBStatusViewModel(model: model))
            }

//            // 字典转模型  (注意 list 是可选项 , 要解包)
//            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else {
//                
//                completion(isSuccess,false)
//                return
//            }
            
            
            
            if pullupRefresh && array.count == 0{ // 上拉刷新,且没有刷新到数据
                completion(isSuccess,false)
                self.pullupTryTimes += 1
            }
            
            // 拼接数据
            if pullupRefresh { // 上拉刷新
                self.statusList += array
            }else{ // 下拉刷新
                
                self.statusList = array + self.statusList
            }
            
            // 完成回调
            completion(isSuccess,true)
            
        }
        
    }
    
    
    
}
