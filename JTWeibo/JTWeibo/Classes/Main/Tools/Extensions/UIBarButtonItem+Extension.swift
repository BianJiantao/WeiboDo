//
//  UIBarButtonItem+Extension.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit


extension UIBarButtonItem{
    
    /// 自定义 UIBarButtonItem
    ///
    /// - parameter title:    title
    /// - parameter fontSize: fontSize 默认16
    /// - parameter target:  target
    /// - parameter action:   action
    ///
    /// - returns: UIBarButtonItem
    convenience init(title:String,fontSize:CGFloat = 16,target: Any?, action: Selector ) {
        
        let btn:UIButton = UIButton.textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
    }
    
    
}
