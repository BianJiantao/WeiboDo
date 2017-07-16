//
//  WBNewFeatureView.swift
//  JTWeibo
//
//  Created by BJT on 17/7/15.
//  Copyright © 2017年 BJT. All rights reserved.
//  版本更新,新特性

import UIKit
/// 新特性图片个数
fileprivate let newFeatureCount = 4
class WBNewFeatureView: UIView {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var enterBtn: UIButton!
    
    
    @IBAction func enterBtnAction(_ sender: UIButton) {
        removeFromSuperview()
    }
    
    class func newFeatureView()-> WBNewFeatureView{
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBNewFeatureView
        //从xib 加载的视图 默认 600* 600
        v.frame  = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        let rect = UIScreen.main.bounds
        for i in 0..<newFeatureCount {
            let imageName = "new_feature_\(i+1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            //设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            scrollView.addSubview(iv)
        }
        
        //设置 scrollView 的属性
        scrollView.contentSize = CGSize(width: CGFloat(newFeatureCount + 1) * rect.width, height: rect.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self;
    }

}

// MARK: - UIScrollViewDelegate
extension WBNewFeatureView :UIScrollViewDelegate {
    
    // 滑动结束减速的时候调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 滚动到最后一屏，让视图删除
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        // 倒数第二页显示按钮
        enterBtn.isHidden = (page != newFeatureCount - 1)
        
        // 判断是否最后一页
        if page == newFeatureCount {
            removeFromSuperview()
        }
        
    }
    
    // 只要滑动就调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        enterBtn.isHidden = true
        
        //计算当前偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        pageControl.currentPage = page
        
        // 最后一页,分页隐藏
        pageControl.isHidden = (page == newFeatureCount)
        
        
    }
    
    
}
