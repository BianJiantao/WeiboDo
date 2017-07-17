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
    
    /// 重写 description 的计算性属性 (开发模型时,重写模型的description )
    override var description: String{
        return yy_modelDescription()
    }
    
}
