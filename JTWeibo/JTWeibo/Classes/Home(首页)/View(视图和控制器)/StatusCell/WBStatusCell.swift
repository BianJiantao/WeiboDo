//
//  WBStatusCell.swift
//  JTWeibo
//
//  Created by BJT on 17/7/16.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

@objc protocol WBStatusCellDelegate: NSObjectProtocol {
    /// 微博cell 选中URL 字符串
    @objc optional func statusCellDidTapURLString(cell:WBStatusCell,urlString:String)
}
class WBStatusCell: UITableViewCell {
    
    weak var delegate: WBStatusCellDelegate?
    //微博视图模型
    var viewModel:WBStatusViewModel?{
        didSet {
            // 昵称
            nameLabel.text = viewModel?.status.user?.screen_name
            // 会员图标
            memberIconView.image = viewModel?.memberIcon
            // 认证图标
            vipIconView.image = viewModel?.vipIcon
            // 头像
            iconView.jt_setImage(urlStr: viewModel?.status.user?.profile_image_url,
                                 placeholderImage: UIImage(named: "avatar_default_big"),
                                 isAvatar: true)
            // 转发
            retweetedBtn.setTitle(viewModel?.retweetedStr, for: .normal)
            // 评论
            commentBtn.setTitle(viewModel?.commentStr, for: .normal)
            // 赞
            likeBtn.setTitle(viewModel?.likeStr, for: .normal)
            
            pictureView.viewModel = viewModel
            
            // 转发微博 属性文本
            retweetedTextLabel?.attributedText = viewModel?.retweededAttrText
            // 微博 属性文本
            statusLabel?.attributedText = viewModel?.statusAttrText
            
            sourceLabel.text = viewModel?.status.source
            timeLabel.text = viewModel?.status.createdDate?.dateDescription
            
        }
    }

    
    
    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    
    /// 会员图标
    @IBOutlet weak var memberIconView: UIImageView!
    
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    
    /// 来源
    @IBOutlet weak var sourceLabel: UILabel!
    
    /// 认证
    @IBOutlet weak var vipIconView: UIImageView!
    
    /// 微博正文
    @IBOutlet weak var statusLabel: WBLabel!
    
    /// 转发
    @IBOutlet weak var retweetedBtn: UIButton!
    
    /// 评论
    @IBOutlet weak var commentBtn: UIButton!
    
    /// 赞
    @IBOutlet weak var likeBtn: UIButton!
    
    /// 配图视图
    @IBOutlet weak var pictureView: WBStatusPicturesView!
    
    /// 被转发微博的文字 - 原创微博没有此控件 一定要 '?'
    @IBOutlet weak var retweetedTextLabel: WBLabel?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //离屏渲染 - 异步绘制  耗电
        self.layer.drawsAsynchronously = true
        
        //栅格化 - 异步绘制之后 ，会生成一张独立的图片 cell 在屏幕上滚动的时候，本质上滚动的是这张图片
        //cell 优化，要尽量减少图层的数量，想当于只有一层
        //停止滚动之后，可以接受监听
        self.layer.shouldRasterize = true
        
        //使用 “栅格化” 必须指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        
        // MARK: - 设置微博文本代理
        statusLabel.delegate = self
        retweetedTextLabel?.delegate = self
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - WBLabelDelegate
extension WBStatusCell:WBLabelDelegate{
    func labelDidSelectedLinkText(label: WBLabel, text: String) {
        
        //判断是否是url
        if !text.hasPrefix("http://") {
            return
        }
        
        //插入？ 如果代理没有实现协议方法，就什么都不做
        //插入！ 代理没有实现协议方法，仍然强制执行 会崩溃
        delegate?.statusCellDidTapURLString?(cell: self, urlString: text)
    }
}

