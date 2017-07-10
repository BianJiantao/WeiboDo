//
//  WBVisitorView.swift
//  JTWeibo
//
//  Created by BJT on 17/7/10.
//  Copyright © 2017年 BJT. All rights reserved.
// 访客视图

import UIKit

class WBVisitorView: UIView {

    
    // 访客视图信息字典 [imageName / message ]
    // 如果是首页 imageName = "" ,因为默认的就是首页信息
    var visitorInfo : [String:String]?{
        didSet{
            
            // 取出字典信息
           guard let imageName = visitorInfo?["imageName"],
                    let message = visitorInfo?["message"] else{
                return
            }
            
            // 设置视图信息
            tipLabel.text = message
            
            // 设置图像
            if imageName == ""{ // 首页控制器不需要设置,默认的就是首页的,直接返回
                // 开启动画
                startAnimation()
                return
            }
            
            // 设置首页之外的其他控制器
            iconView.image = UIImage(named: imageName)
            // 其他控制器的访客视图不需要显示小房子图像 和 遮盖
            houseIconView.isHidden = true
            maskImageView.isHidden = true
            
        }
    }
    
    // MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 首页控制器的旋转图标动画
    fileprivate func startAnimation() {
        
        let ani = CABasicAnimation(keyPath: "transform.rotation")
        ani.toValue = 2 * M_PI
        ani.repeatCount = MAXFLOAT
        ani.duration  = 15
        // TIPS : 动画完成不移除, (保证 切换其他子控制器或者 home键退回到手机桌面后, 再切换回来时动画依旧在执行)
        // 在设置连续播放的动画时,非常有用
        ani.isRemovedOnCompletion = false
        
        iconView.layer.add(ani, forKey: nil)
        
    }
    
    
    // MARK:- 私有控件
    // 图像视图
    fileprivate lazy var iconView :UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // 遮盖
    fileprivate lazy var maskImageView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
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
        backgroundColor = UIColor(hex: 0xEDEDED)
        
        // 添加控件
        addSubview(iconView)
        addSubview(maskImageView)
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
                                         constant: 230))
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
        // 遮盖
        let viewDict : [String:UIView] = ["maskImageView":maskImageView,
                                        "registerButton":registerButton]
        let metrics = ["spacing":-registerButton.bounds.height]
        addConstraints(NSLayoutConstraint.constraints(
             withVisualFormat: "H:|-0-[maskImageView]-0-|",
             options: [],
             metrics: nil,
             views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(
              withVisualFormat: "V:|-0-[maskImageView]-(spacing)-[registerButton]",
              options: [],
              metrics: metrics,
              views: viewDict))
        
        
        
    }
    
}
