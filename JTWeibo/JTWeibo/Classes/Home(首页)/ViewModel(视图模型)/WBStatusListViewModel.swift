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
import SDWebImage

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
            
            // 拼接数据
            if pullupRefresh { // 上拉刷新
                self.statusList += array
            }else{ // 下拉刷新
                
                self.statusList = array + self.statusList
            }
            
            if pullupRefresh && array.count == 0{ // 上拉刷新,且没有刷新到数据
                completion(isSuccess,false)
                self.pullupTryTimes += 1
            }else{
                // 完成回调
                self.cacheSingleImage(list: array, finished: completion)
            }
            
            
            
        }
        
    }
    /// 缓存本次下载微博数据数组中是单张图像
    ///
    /// - parameter list: 本次下载的视图模型数组
    private func cacheSingleImage(list: [WBStatusViewModel], finished:@escaping (_ isSuccess: Bool, _ shouldRefresh: Bool)->()) {
        
        //调度组
        let group = DispatchGroup()
        
        //记录数据长度
        var length = 0
        
        for vm in list {
            if vm.picURLs?.count != 1 {
                continue
            }
            
            /// 代码执行到此，数组中有且仅有一张图片
            guard let picUrl = vm.picURLs?[0].thumbnail_pic,
                let url = URL(string: picUrl) else {
                    continue
            }
            
            //入组
            group.enter()
            
            //下载图像  downloadImage 是SDWebImage 的核心方法 图片下载完成后 会自动保存到沙盒中 文件路径是 url 的 MD5
    
            SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _,_,_) in
                if let image = image,
                    let data = UIImagePNGRepresentation(image){
                    
                    //NSData 是 length 属性
                    length += data.count
                    //图像缓存成功 更新配图视图大小
                    vm.updateImageSize(image: image)
                    
                }
                //出组 -放在回调的最后一句
                group.leave()
            })
            
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("图像缓存\(length/1024)k")
            
            //完成回调
            finished(true, true)
            
        }
    }
    
    
}
