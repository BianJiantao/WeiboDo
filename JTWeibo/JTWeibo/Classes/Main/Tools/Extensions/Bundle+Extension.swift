//
//  Bundle+Extension.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import Foundation


extension Bundle{
    
    // 返回命名空间字符串
    var namespace : String{
        
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
