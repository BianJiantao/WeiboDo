//
//  Date+Extension.swift
//  JTWeibo
//
//  Created by BJT on 17/7/27.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博日期转换

import Foundation

/// 日期格式化器 -- 不要频繁释放和创建,影响性能
fileprivate let dateFormatter = DateFormatter()

// 取出当前日历 - 提供了大量的日历相关的操作函数
fileprivate let calendar = Calendar.current

extension Date {
    
    /// 将新浪微博格式的字符串转换成日期
      static func dateWithWBDateString(_ string: String) -> Date? {
        // 1. 转换成日期
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        
        return dateFormatter.date(from: string)
    }
    
    /**
     返回当前日期的描述信息
     
     刚刚(一分钟内)
     X分钟前(一小时内)
     X小时前(当天)
     
     昨天 HH:mm(昨天)
     MM-dd HH:mm(一年内)
     yyyy-MM-dd HH:mm(更早期)
     */
    var dateDescription: String {
        
        // 处理今天的日期
        if calendar.isDateInToday(self) {
            
            let delta = Int(Date().timeIntervalSince(self))
            
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                return "\(delta / 60) 分钟前"
            }
            
            return "\(delta / 3600) 小时前"
        }
        
        // 非今天的日期
        var fmt = " HH:mm"
        if calendar.isDateInYesterday(self) {
            fmt = "昨天" + fmt
        } else {
            
            fmt = "MM-dd" + fmt
            
            let year = calendar.component(.year, from: self)
            let thisYear = calendar.component(.year, from: Date())
            
            if year != thisYear {
                fmt = "yyyy-" + fmt
            }
        }
        
        // 根据格式字符串生成描述字符串
        dateFormatter.dateFormat = fmt
        
        return dateFormatter.string(from: self)
    }

    
    
}
