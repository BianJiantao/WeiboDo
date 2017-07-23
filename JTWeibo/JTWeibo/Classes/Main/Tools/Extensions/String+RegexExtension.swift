//
//  String+RegexExtension.swift
//  JTWeibo
//
//  Created by BJT on 17/7/23.
//  Copyright © 2017年 BJT. All rights reserved.
// 正则表达式 , 提取微博来源链接和文本

import Foundation

extension String {
    /// 从当前的字符串中，提取链接和文本
    /// Swift中提供了’元祖‘，同时返回多个值
    /// OC 中可以返回字典，或者自定义对象，也可以用指针的指针
    func  rgx_href() -> ((link: String, text: String))? {
        //匹配方案
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        // 创建正则表达式
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []),
            let result =  regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count))else {
                return nil
        }
        //获取结果
        let link = (self as NSString).substring(with: result.rangeAt(1))
        let text = (self as NSString).substring(with: result.rangeAt(2))
        
        return (link,text)
    }
}
