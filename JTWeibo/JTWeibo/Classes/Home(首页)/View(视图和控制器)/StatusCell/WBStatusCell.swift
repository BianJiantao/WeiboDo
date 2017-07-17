//
//  WBStatusCell.swift
//  JTWeibo
//
//  Created by BJT on 17/7/16.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {

    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    
    /// 会员图标
    @IBOutlet weak var memberIconView: UIImageView!
    
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    
    /// 来源
    @IBOutlet weak var sourseLabel: UILabel!
    
    /// 认证
    @IBOutlet weak var vipIconView: UIImageView!
    
    /// 微博正文
    @IBOutlet weak var statusLabel: UILabel!
    
    /// 转发
    @IBOutlet weak var retweetedBtn: UIButton!
    
    /// 评论
    @IBOutlet weak var commentBtn: UIButton!
    
    /// 赞
    @IBOutlet weak var likeBtn: UIButton!
    
    /// 配图视图
    @IBOutlet weak var pictureView: UIView!
    
    /// 被转发微博的文字 - 原创微博没有此控件 一定要 '?'
//    @IBOutlet weak var retweededTextLabel: UILabel?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
