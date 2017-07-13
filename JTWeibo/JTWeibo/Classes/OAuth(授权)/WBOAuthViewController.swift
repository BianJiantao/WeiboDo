//
//  WBOAuthViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/13.
//  Copyright © 2017年 BJT. All rights reserved.
// OAuth授权登录页面控制器

import UIKit

class WBOAuthViewController: UIViewController {

    fileprivate lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        
        navigationItem.title = "登录微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(back), isBack: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // OAuth2 授权页面 url
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBAppRedirectUri)"
        guard let url = URL(string: urlStr) else{
            return
        }
        
        let request = URLRequest(url: url)
        // 发送请求,加载授权页面
        webView.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - 监听方法
    @objc fileprivate func back(){
        dismiss(animated: true, completion: nil)
    }


}
