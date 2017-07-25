//
//  WBEmoticon.swift
//  JTWeibo
//
//  Created by BJT on 17/7/24.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit
import YYModel
class WBEmoticon: NSObject {

    ///表情类型 false-图片表情/true-emoji
    var type = false
    
    /// 表情字符串，发送给服务器（节约流量）
    var chs: String?
    
    /// 表情的图片名称，用于本地图文混排
    var png: String?
    
    /// emoji 16进制编码
    var code: String? {
        didSet {
            guard let code = code else {
                return
            }
            let scanner = Scanner(string: code)
            var result: UInt32 = 0
            scanner.scanHexInt32(&result)
            emoji =  String(Character(UnicodeScalar(result)!))
        }
    }
    
    /// 表情模型所在的目录
    var directory: String?
    
    /// emoji 的字符串
    var emoji: String?
    
    /// 图片表情对用的图像
    var image:UIImage?{
        //判断表情类型
        if type {
            return nil
        }
        guard let directory = directory,
            let png = png,
            let path = Bundle.main.path(forResource: "WBEmoticon", ofType: "bundle"),
            let bundle = Bundle(path:path)  else {
                return nil
        }
        return UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
    }
    
    //根据当前的图像，生成图像的属性文本
    func imageText(font:UIFont) -> NSAttributedString {
        //判断图像是否存在
        guard let image = image else {
            return NSAttributedString(string: "")
        }
        
        //创建文本附件 -图像
        let attachment = WBEmoticonAttachment()
        //记录是属性文本
        attachment.chs = chs
        attachment.image = image
        //lineHeight 大致和字体大小相等
        let height = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        //返回图像属性文本
        let attrStrM = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        //设置字体属性
        attrStrM.addAttributes([NSFontAttributeName: font], range: NSRange(location: 0, length: 1))
        return attrStrM
    }
   override var description: String{
        return yy_modelDescription()
    }
    
}
