//
//  WBWelcomeView.swift
//  JTWeibo
//
//  Created by BJT on 17/7/15.
//  Copyright © 2017年 BJT. All rights reserved.
//  没有新版本,进入欢迎界面

import UIKit
import SDWebImage

class WBWelcomeView: UIView {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    // iconView 底部约束
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    // iconView 宽度约束
    @IBOutlet weak var iconWidthCons: NSLayoutConstraint!
    
    
    class func welcomeView()-> WBWelcomeView{
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBWelcomeView
        //从xib 加载的视图  默认 600 * 600
        v.frame  = UIScreen.main.bounds
        return v
    }
    
    override func awakeFromNib() {
        
        guard let urlStr = WBNetworkManager.shared.account.avatar_large,
              let url = URL(string: urlStr)
            else {
                return
        }
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        // - 使用自动布局 就不要用frame了 , 此时 iconView.bounds 是 0 
//        iconView.layer.cornerRadius = iconView.bounds.width
        iconView.layer.cornerRadius = iconWidthCons.constant * 0.5
        iconView.layer.masksToBounds = true
        
    }
    
    
    //视图被添加到window上，表示视图已经显示
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
        //TIPS 视图使用自动布局来设置的 只是设置了约束
        // 当视图被添加到窗口上时，根据父视图的大小 计算约束值 更新控件位置
        // layoutIfNeeded 会直接按照当前的约束直接更新控件位置
        // 执行之后，控件所在位置 就是xib中布局的位置
        layoutIfNeeded()
        
        bottomCons.constant = bounds.size.height - 200
        // 如果控件们的 frame 还没有计算好, 所有的约束会一起动画
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
            // 更新约束
            self.layoutIfNeeded()
            
        }) { (_) in
            UIView.animate(withDuration: 1.0, animations: {
                self.tipLabel.alpha = 1
                }, completion: { (_) in
                    self.removeFromSuperview()
            })
        }
        
    }
}

