//
//  WBOAuthViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/13.
//  Copyright © 2017年 BJT. All rights reserved.
// OAuth授权登录页面控制器

import UIKit
import SVProgressHUD

class WBOAuthViewController: UIViewController {

    fileprivate lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        // 禁用 webView 滚动
        webView.scrollView.isScrollEnabled = false
        
        // 设置代理
        webView.delegate = self
        
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
        // 移除加载指示
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }


}


extension WBOAuthViewController:UIWebViewDelegate{
    
    // 拦截请求
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.url?.absoluteString.hasPrefix(WBAppRedirectUri) == false { // 请求的 url 不包含回调地址
            
            return true
        }
        
        // query 时 url 中 ' ? ' 后面的内容   ( client_id=)
        // https://api.weibo.com/oauth2/authorize?client_id=  (query :  client_id=)
//        print(request.url?.query)
        
        if request.url?.query?.hasPrefix("code=") == false {
            
            print("取消授权")
            back()
            return false
        }
        
        // 获取授权码
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
//        print("获取授权码--\(code)")
        // 使用授权码获取 accessToken
        WBNetworkManager.shared.loadAccessToken(code: code) { (isSuccess) in
            
            if !isSuccess {
                SVProgressHUD.showInfo(withStatus: "网络请求失败")
            }else{
                SVProgressHUD.showInfo(withStatus: "登录成功")
                // 跳转界面
            }
            
            
        }
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        // 显示加载指示
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // 移除加载指示
        SVProgressHUD.dismiss()
    }
    
    
}

