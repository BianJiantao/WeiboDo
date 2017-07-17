//
//  WBStatusViewModel.swift
//  JTWeibo
//
//  Created by BJT on 17/7/17.
//  Copyright © 2017年 BJT. All rights reserved.
// 单条微博视图模型  (不需要 KVC 设值,  就可以不继承任何父类)

import Foundation


class WBStatusViewModel {
    
    /// 微博模型
    var status:WBStatus
    
    init(model:WBStatus) {
        
        self.status = model
    }
}
