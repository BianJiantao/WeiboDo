//
//  WBStatusViewModel.swift
//  JTWeibo
//
//  Created by BJT on 17/7/17.
//  Copyright © 2017年 BJT. All rights reserved.
// 单条微博视图模型  (不需要 KVC 设值,  就可以不继承任何父类)

import Foundation

/**
>>>如果没有任何父类 希望在开发时调试 输出调试信息
     1.遵守 CustomStringConvertible 协议
     2.实现 description 计算型属性
>>>关于表格性能优化
     尽量少计算 所有需要的素材提前计算好
     控件上不要设置圆角半径 所有图像渲染的属性 都要注意
     不要动态创建控件 所有的控件提前创建好 在显示的时候 根据数据 隐藏/显示
     cell中控件的层次越少越好, 数量越少越好
     要测量,不要猜测
 */

class WBStatusViewModel:CustomStringConvertible {
    
    /// 微博模型
    var status:WBStatus
    
    /// 会员图标 - 存储型属性（用内存换 CPU）
    var memberIcon:UIImage?
    
    /// 认证图标  类型 : -1 没有认证 ; 0 认证用户 ; 2,3,5 企业用户; 220 达人
    var vipIcon: UIImage?
    
    /// 转发
    var retweetedStr: String?
    
    /// 评论
    var commentStr: String?
    
    /// 点赞
    var likeStr: String?
    
    /// 配图视图大小
    var pictureViewSize = CGSize()
    
    /// 如果是被转发的微博，原创微博肯定没有图
    var  picURLs: [ WBStatusPicture]? {
        // 如果有被转发的微博 返回被转发微博的配图， 如果没有，返回原创微博的配图 ,如果都没有 返回 nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    /// 行高
    var rowHeight:CGFloat = 0
    
    /// 被转发微博的正文
    var retweetedText: String?
    
    init(model:WBStatus) {
        
        self.status = model
        
        //根据计算出的会员图标0 - 6
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        
        //认证图标
        switch model.user?.verified_type ?? -1 {
        case  0:
            vipIcon = UIImage(named: "avatar_vip")
        case  2,3,5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case  220:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        default:
            break
        }
        
        //设置底部工具栏计数字符串
        retweetedStr = countString(count: model.reposts_count, defaultStr: " 转发")
        commentStr = countString(count: model.comments_count, defaultStr: " 评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: " 赞")
        
        // 计算配图视图大小
        pictureViewSize = calPicturesViewSize(count: picURLs?.count)
        
        retweetedText = "@" + (model.retweeted_status?.user?.screen_name ?? "") + ":" + (model.retweeted_status?.text ?? "")
        updateRowHeight()
    }
    
    var description: String{
        return status.yy_modelDescription()
    }
    
    /// 根据当前视图模型内容计算行高
    func updateRowHeight() {
        
        let margin:CGFloat = 12
        
        let iconHeight: CGFloat = 34
        
        let toolBarHeight: CGFloat = 35
        
        let viewSize = CGSize(width: UIScreen.screenWidth() - 2 * margin, height: CGFloat(MAXFLOAT))
        
        let originalFont = UIFont.systemFont(ofSize: 15)
        
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        
        // 计算顶部位置
        var height = 2 * margin + iconHeight + margin
        
        // 正文高度
        if let text = status.text {
            
            // 正文属性文本高度 属性文本中，自身已经包含了字体属性
//            height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
            
            /**
             预期尺寸，宽度固定，高度尽量大
             选项： 换行文本 统一使用 .usesLineFragmentOrigin
             attributes:指定字体字典
             */
           height += (text as NSString).boundingRect(with: viewSize, options:.usesLineFragmentOrigin, attributes: [NSFontAttributeName: originalFont], context: nil).height
            
            // 判断是否有转发微博
            if status.retweeted_status != nil {
                
                height += 2 * margin
                
                if let text = retweetedText {
//                    height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
                    
                height += (text as NSString).boundingRect(with: viewSize, options:.usesLineFragmentOrigin, attributes: [NSFontAttributeName: retweetedFont], context: nil).height
                    
                }
            }
            
            // 配图视图
            height += pictureViewSize.height
            
            height += margin
            
            // 底部工具栏
            height += toolBarHeight
            
            // 使用属性记录
            rowHeight = height
            
        }
    }
    
    
    /// 使用单个图像 更新配图视图的大小
    ///
    /// 新浪针对单张图片，都是缩略图，但是偶尔会有一张特别大的图
    /// - parameter image: 网络缓存的单张图像
    ///
    func updateImageSize(image: UIImage) {
        var size = image.size
        
        let maxWith: CGFloat = 300
        let minWidth: CGFloat = 40
        
        // 过宽图片处理
        if size.width >= maxWith {
            // 设置最大宽度
            size.width = maxWith
            // 等比例调整高度
            size.height = size.width * image.size.height / image.size.width
        }
        
        // 过窄处理
        if size.width < minWidth {
            // 设置最大宽度
            size.width = minWidth
            // 等比例调整高度
            size.height = size.width * image.size.height/image.size.width / 4
        }
        
        
        // 注意 尺寸需要增加顶部的 12 个点 便于布局
        size.height +=  pictureOutterMargin
        
        pictureViewSize = size
        
        // 更新行高
        updateRowHeight()
    }

    
    /// 计算指定数量的图片对应的配图的大小
    ///
    /// - parameter count: 配图数量
    ///
    /// - returns: 配图视图的大小
    private func calPicturesViewSize(count: Int?) ->CGSize {
        
        if count == 0 || count == nil{
            return CGSize()
        }
        
        /// 行数
        let row = (count! - 1)/3 + 1
        
        /// 根据行数计算行高
        let height = pictureOutterMargin + CGFloat(row) * WBStatusPictureItemWidth + CGFloat(row - 1) * pictureInnerMargin
        
        return CGSize(width: WBStatusPictureViewWidth, height: height)
        
    }
    
    
    /// 给定一个数字,返回对应的描述结果
    ///
    /// - parameter count:      数字
    /// - parameter defaultStr: 默认字符串  / 转发,评论,赞
    ///
    /// - returns: 描述结果
    /*
     如果 数量 == 0 显示默认标题
     数量 超过 10000 显示x.xx万
     如果 数量 <10000 显示实际数字
     **/
    private func countString(count:Int, defaultStr: String) ->String {
        
        if count == 0 {
            return defaultStr
        }
        
        if count < 10000 {
            return count.description
        }
        
        return String(format: "%.02f 万",  Double(count / 10000))
    }

    
}
