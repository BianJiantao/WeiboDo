//
//  WBEmoticonPackage.swift
//  JTWeibo
//
//  Created by BJT on 17/7/24.
//  Copyright © 2017年 BJT. All rights reserved.
//


import UIKit
import YYModel
class WBEmoticonPackage: NSObject {
    
    /// 表情包的分组名
    var groupName: String?
    
    /// 背景图片名称
    var bgImageName: String?
    
    /// 表情包目录，从目录下加载info.plist 可以创建表情模型数组
    var directory: String?{
        //当设置目录时候，从目录下加载 info.plist
        didSet {
            guard let directory = directory,
                let path = Bundle.main.path(forResource: "WBEmoticon", ofType: "bundle"),
                let bundle = Bundle(path: path),
                let infoPath = bundle.path(forResource: "info", ofType: "plist", inDirectory: directory),
                let array = NSArray(contentsOfFile: infoPath) as? [[String: String]],
                let modelArr = NSArray.yy_modelArray(with: WBEmoticon.self, json: array) as? [WBEmoticon]else {
                    return
            }
            //遍历modelArr 数组，设置每一个表情符号的目录
            for m in modelArr {
                m.directory = directory;
            }
            
            //设置表情模型数组
            emoticonArr += modelArr
            print(emoticonArr.count)
        }
    }
    
    /// 懒加载表情模型空数组，使用懒加载可以避免后续的解包
    lazy var emoticonArr = [WBEmoticon]()
    
    /// 表情页面数量
    var munberOfPages: Int {
        return (emoticonArr.count - 1) / 20 + 1
    }
    
    /// 从懒加载的表情包中，按照page 截取最多 20个表情模型的数组
    func emoticon(page: Int) -> [WBEmoticon] {
        //每一页数量
        let count = 20
        let location = page * count
        var length = count
        
        if location + length > emoticonArr.count {
            length = emoticonArr.count - location
        }
        
        let range = NSRange(location: location, length: length)
        let subArr = (emoticonArr as NSArray).subarray(with: range)
        return subArr as! [WBEmoticon]
    }
    
    
    override var description: String{
        return yy_modelDescription()
    }
}
