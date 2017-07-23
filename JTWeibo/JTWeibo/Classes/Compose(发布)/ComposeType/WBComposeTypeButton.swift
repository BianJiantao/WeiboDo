//
//  WBComposeTypeButton.swift
//  JTWeibo
//
//  Created by BJT on 17/7/23.
//  Copyright © 2017年 BJT. All rights reserved.
//  

import UIKit

class WBComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //点击按钮展示控制器的类型
    var clsName: String?
    
    /// 使用图像名称、标题创建按钮， 按钮布局从xib加载
    class func composeTypeButton(imageName:String, title: String) ->WBComposeTypeButton {
      let btn = UINib(nibName: "WBComposeTypeButton", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeButton
        
        btn.imageView.image = UIImage(named: imageName)
        btn.titleLabel.text = title
        
        return btn
    }

}
