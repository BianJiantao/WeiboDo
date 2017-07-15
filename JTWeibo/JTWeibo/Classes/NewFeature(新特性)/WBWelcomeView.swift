//
//  WBWelcomeView.swift
//  JTWeibo
//
//  Created by BJT on 17/7/15.
//  Copyright © 2017年 BJT. All rights reserved.
//  没有新版本,进入欢迎界面

import UIKit

class WBWelcomeView: UIView {

    class func welcomeView()-> WBWelcomeView{
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBWelcomeView
        //从xib 加载的视图  默认 600 * 600
        v.frame  = UIScreen.main.bounds
        return v
    }
    

}
