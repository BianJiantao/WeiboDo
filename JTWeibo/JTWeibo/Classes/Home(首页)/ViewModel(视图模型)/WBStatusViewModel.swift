//
//  WBStatusViewModel.swift
//  JTWeibo
//
//  Created by BJT on 17/7/17.
//  Copyright © 2017年 BJT. All rights reserved.
// 单条微博视图模型  (不需要 KVC 设值,  就可以不继承任何父类)

import Foundation

/**
>>>如果没有任何父类 希望在开发时调试 输出调试信息
     1.遵守 CustomStringConvertible 协议
     2.实现 description 计算型属性
>>>关于表格性能优化
     尽量少计算 所有需要的素材提前计算好
     控件上不要设置圆角半径 所有图像渲染的属性 都要注意
     不要动态创建控件 所有的控件提前创建好 在显示的时候 根据数据 隐藏/显示
     cell中控件的层次越少越好, 数量越少越好
     要测量,不要猜测
 */

class WBStatusViewModel:CustomStringConvertible {
    
    /// 微博模型
    var status:WBStatus
    
    /// 会员图标 - 存储型属性（用内存换 CPU）
    var memberIcon:UIImage?
    
    /// 认证图标  类型 : -1 没有认证 ; 0 认证用户 ; 2,3,5 企业用户; 220 达人
    var vipIcon: UIImage?
    
    /// 转发
    var retweetedStr: String?
    
    /// 评论
    var commentStr: String?
    
    /// 点赞
    var likeStr: String?
    
    /// 配图视图大小
    var picturesViewSize = CGSize()
    
    init(model:WBStatus) {
        
        self.status = model
        
        //根据计算出的会员图标0 - 6
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        
        //认证图标
        switch model.user?.verified_type ?? -1 {
        case  0:
            vipIcon = UIImage(named: "avatar_vip")
        case  2,3,5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case  220:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        default:
            break
        }
        
        //设置底部工具栏计数字符串
        retweetedStr = countString(count: model.reposts_count, defaultStr: " 转发")
        commentStr = countString(count: model.comments_count, defaultStr: " 评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: " 赞")
        
        
        //计算配图视图大小
        picturesViewSize = calPicturesViewSize(count: status.pic_urls?.count)
        
    }
    
    var description: String{
        return status.yy_modelDescription()
    }
    
    /// 计算指定数量的图片对应的配图的大小
    ///
    /// - parameter count: 配图数量
    ///
    /// - returns: 配图视图的大小
    private func calPicturesViewSize(count: Int?) ->CGSize {
        
        if count == 0 || count == nil{
            return CGSize()
        }
        
        /// 行数
        let row = (count! - 1)/3 + 1
        
        /// 根据行数计算行高
        let height = pictureOutterMargin + CGFloat(row) * WBStatusPictureItemWidth + CGFloat(row - 1) * pictureInnerMargin
        
        return CGSize(width: WBStatusPictureViewWidth, height: height)
        
    }
    
    
    /// 给定一个数字,返回对应的描述结果
    ///
    /// - parameter count:      数字
    /// - parameter defaultStr: 默认字符串  / 转发,评论,赞
    ///
    /// - returns: 描述结果
    /*
     如果 数量 == 0 显示默认标题
     数量 超过 10000 显示x.xx万
     如果 数量 <10000 显示实际数字
     **/
    private func countString(count:Int, defaultStr: String) ->String {
        
        if count == 0 {
            return defaultStr
        }
        
        if count < 10000 {
            return count.description
        }
        
        return String(format: "%.02f 万",  Double(count / 10000))
    }

    
}
