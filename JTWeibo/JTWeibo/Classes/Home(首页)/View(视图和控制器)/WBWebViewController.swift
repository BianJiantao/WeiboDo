//
//  WBWebViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/25.
//  Copyright © 2017年 BJT. All rights reserved.
// 点击微博文本中 url 跳转后的网页控制器

import UIKit

class WBWebViewController: WBBaseViewController {
    
    fileprivate lazy var webView = UIWebView(frame: UIScreen.main.bounds)
    var urlString: String?{
        didSet {
            guard let urlString = urlString,
                let url = URL(string: urlString) else{
                    return
            }
            webView.loadRequest(URLRequest(url: url))
        }
    }
    
}

extension WBWebViewController{
    override func setupTableView() {
        navItem.title = "网页"
        
        view.insertSubview(webView, belowSubview: navBar)
        webView.backgroundColor = UIColor.white
        webView.scrollView.contentInset.top = navBar.bounds.height
        
    }
}
