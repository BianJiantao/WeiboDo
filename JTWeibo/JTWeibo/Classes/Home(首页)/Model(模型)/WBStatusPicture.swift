//
//  WBStatusPicture.swift
//  JTWeibo
//
//  Created by BJT on 17/7/18.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博配图模型

import UIKit

class WBStatusPicture: NSObject {
    /// 缩略图地址
    var thumbnail_pic: String?{
        didSet{
//            print(thumbnail_pic)
           thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap320/")
            
        }
    }
    
    override var description: String{
        return yy_modelDescription()
    }
}
