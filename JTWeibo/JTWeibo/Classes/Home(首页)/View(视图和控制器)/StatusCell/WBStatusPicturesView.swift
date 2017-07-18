//
//  WBStatusPicturesView.swift
//  JTWeibo
//
//  Created by BJT on 17/7/18.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博配图视图

import UIKit

class WBStatusPicturesView: UIView {

    
    var urls: [WBStatusPicture]? {
        
        didSet{
            
            //隐藏所有的 imageView
            for v in subviews {
                v.isHidden = true
            }
            
            var index = 0
            //设置图像
            for url in urls ?? [] {
                let iv = subviews[index] as! UIImageView
                if index == 1 && urls?.count == 4 {
                    
                    index += 1
                }
                
                iv.jt_setImage(urlStr: url.thumbnail_pic, placeholderImage: UIImage(named: "paceholder"))
                iv.isHidden = false
                index += 1
            }
            
            
            
        }
    }
    
    @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        
        setupUI()
    }
    
    
}


// MARK: - 设置界面
extension WBStatusPicturesView {
    
    fileprivate func setupUI(){
        
        backgroundColor = superview?.backgroundColor
        /// 超出范围不显示
        clipsToBounds = true
        
        let rect = CGRect(x: 0,
                          y: pictureOutterMargin,
                          width: WBStatusPictureItemWidth,
                          height: WBStatusPictureItemWidth)
        let count = 3
        
        for i in 0..<9 {
            
            let row = CGFloat(i / count)
            let col = CGFloat(i % count)
            let iv = UIImageView()
            // 设置 contentMode
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            let xOffset = col * (WBStatusPictureItemWidth + pictureInnerMargin)
            
            let yOffset = row * (WBStatusPictureItemWidth + pictureInnerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            iv.backgroundColor = UIColor.red
            addSubview(iv)
        }
        
    }
}
