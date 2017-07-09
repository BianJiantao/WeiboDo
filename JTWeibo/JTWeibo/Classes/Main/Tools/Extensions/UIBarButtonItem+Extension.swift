//
//  UIBarButtonItem+Extension.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit


extension UIBarButtonItem{
    
    /// 自定义 UIBarButtonItem , 便利构造函数
    ///
    /// - parameter title:    title
    /// - parameter fontSize: fontSize 默认16
    /// - parameter target:  target
    /// - parameter action:   action
    ///- parameter  isBack:   是否是返回按钮
    /// - returns: UIBarButtonItem
    convenience init(title:String,fontSize:CGFloat = 16,target: Any?, action: Selector ,isBack:Bool=false) {
        
        let btn:UIButton = UIButton.textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        if isBack {
            let imageName = "navigationbar_back"
            btn.setImage(UIImage.init(named: imageName), for:.normal)
            btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
            
        }
        
        
        
        self.init(customView: btn)
    }
    
    
}
