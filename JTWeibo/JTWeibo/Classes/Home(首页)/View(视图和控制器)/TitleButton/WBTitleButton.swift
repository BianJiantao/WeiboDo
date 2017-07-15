//
//  WBTitleButton.swift
//  JTWeibo
//
//  Created by BJT on 17/7/15.
//  Copyright © 2017年 BJT. All rights reserved.
// 首页控制器的标题按钮

import UIKit

class WBTitleButton: UIButton {


    /// title 如果为 nil , 就显示 '首页'
    init(title:String?){
        
        super.init(frame:CGRect())
        
        if title == nil {
            
            setTitle("首页", for: .normal)
            
        }else{
            // " "表示文字和图片间的间距
            setTitle(title! + " ", for: .normal)
            setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
            setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
            
        }
        
        // 设置 字体/颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        guard let titleLabel = titleLabel,
            let imageView = imageView else {
                return
        }
        
        print("\(titleLabel)\n\(imageView)")
    
        titleLabel.frame.origin.x = 0
        imageView.frame.origin.x = titleLabel.frame.size.width
        
        print("\(titleLabel)\n\(imageView)")

    }
    

}
