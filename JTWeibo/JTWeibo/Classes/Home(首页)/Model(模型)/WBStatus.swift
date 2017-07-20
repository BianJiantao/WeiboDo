//
//  WBStatus.swift
//  JTWeibo
//
//  Created by BJT on 17/7/12.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博数据模型

import UIKit
import YYModel

class WBStatus: NSObject {
    
    /// Int 类型 在64位的机器上是64位 在32位的机器上是32位的
    ///如果不写 Int64 在iPad 2/iphone5/5c/4s/4 都是无法正常运行的
    var id: Int64 = 0
    
    /// 微博信息内容
    var text: String?
    
    /// 微博用户
    var user: WBUser?
    
    /// 被转发微博
    var retweeted_status: WBStatus?
    
    /// 微博配图模型数组
    var pic_urls: [WBStatusPicture]?
    
    /// 转发数
    var reposts_count: Int = 0
    
    /// 评论数
    var comments_count: Int = 0
    
    /// 点赞数
    var attitudes_count: Int = 0
    
    
    /// 重写 description 的计算性属性 (开发模型时,重写模型的description )
    override var description: String{
        return yy_modelDescription()
    }
    
    /// 类函数（如果遇到数组类型的属性，告诉 YY_model 数组中存放的对象是什么类）
    /// NSArray 中保存对象的类型通常是 ' id '类型
    /// OC 中的泛型是 swift 推出后,苹果为了兼容给 OC 增加的
    /// 从运行时角度,仍然不知道数组中应该存放什么类型的对象
    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["pic_urls": WBStatusPicture.self]
    }

    
}
