//
//  WBVisitorView.swift
//  JTWeibo
//
//  Created by BJT on 17/7/10.
//  Copyright © 2017年 BJT. All rights reserved.
// 访客视图

import UIKit

class WBVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- 私有控件
    // 图像视图
    fileprivate lazy var iconView :UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // 小房子
    fileprivate lazy var houseIconView :UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // 提示标签
    fileprivate lazy var tipLabel : UILabel = UILabel(
                                    text: "关注一些人,回这里看看有什么惊喜关注一些人,回这里看看有什么惊喜",
                                    fontSize: 14,
                                    color: UIColor.darkGray)
    // 注册按钮
    fileprivate lazy var registerButton:UIButton = UIButton.textButton(
                                                   "注册",
                                                   fontSize: 16,
                                                   normalColor: UIColor.orange,
                                                   highlightedColor:UIColor.black,
                                                   backgroundImageName:"common_button_white_disable")
    
    // 登录按钮
    fileprivate lazy var loginButton:UIButton = UIButton.textButton(
                                                    "登录",
                                                    fontSize: 16,
                                                    normalColor: UIColor.darkGray,
                                                    highlightedColor:UIColor.black,
                                                    backgroundImageName:"common_button_white_disable")
    
    
    
}


// MARK: - 设置界面
extension WBVisitorView {
    
    func setupUI() {
        backgroundColor = UIColor.white
        
        // 添加控件
        addSubview(iconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 取消 Autoresizing
        for subView in subviews {
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        tipLabel.textAlignment = .center
        tipLabel.numberOfLines = 0
        // 添加约束, 自动布局
        let margin : CGFloat = 20
        // >图像视图
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
        // >小房子
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        //提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute:.notAnAttribute ,
                                         multiplier: 1.0,
                                         constant: 220))
        //注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute:.notAnAttribute ,
                                         multiplier: 1.0,
                                         constant: 100))
        //登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: registerButton,
                                         attribute:.width ,
                                         multiplier: 1.0,
                                         constant: 0))
        
        
        
        
    }
    
}
