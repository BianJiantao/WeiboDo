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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target:  self, action: #selector(autoFill))
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
    

    
    // MARK: - 监听方法
    // 自动填充用户名密码 -- webView 的注入 
    @objc fileprivate func autoFill(){
        
        let js = "document.getElementById('userId').value = '2314373794@qq.com';" + "document.getElementById('passwd').value = 'test13579';"
        //让webView 执行js
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
    // 返回按钮点击
    @objc fileprivate func back(){
        dismiss(animated: true, completion: nil)
    }


}
