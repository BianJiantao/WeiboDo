//
//  WBBaseViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
// 基类控制器

import UIKit

class WBBaseViewController: UIViewController {

    // 访客视图信息字典
    var visitorViewInfo:[String:String]?
    
    // 表格视图
    var tableView:UITableView?
    // 下拉刷新控件
    var refreshControl:UIRefreshControl?
    // 是否上拉刷新
    var isPullupRefresh:Bool = false
    
    
    /// 自定义导航条
    lazy var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth(), height: 64))
    
    /// 自定义导航条item , 以后设置导航栏内容, 统一使用navItem
    lazy var navItem = UINavigationItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        WBNetworkManager.shared.userLogon ? loadData() : ()
        
        // 监听登录成功的通知
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name(rawValue: WBUserLoginSuccessNotification), object: nil)
        
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /// 加载数据,交由子类实现
    func loadData(){
        // 如果子类没有实现该方法, 默认关闭刷新控件
        refreshControl?.endRefreshing()
    }
    
    /// 重写 title 的 didSet , 设置导航条 title
    override var title: String?{
        didSet{
            
            navItem.title = title
        }
    }

}
// MARK: - 监听方法
extension WBBaseViewController {
    
    /// 通知监听方法,登录成功
    @objc fileprivate func loginSuccess(){
        
        // 重置导航栏按钮
        navItem.leftBarButtonItem = nil
        navItem.rightBarButtonItem = nil
        
        // 清空 view, 就会重新加载 view , 调用 loadView,viewDidLoad方法,从而刷新界面.监听通知会再执行一次,因此,需要注销监听
        view = nil
        
        // 注销监听 , 避免重复注册
        NotificationCenter.default.removeObserver(self)
        
        
    }
    
    
    /// 按钮点击监听方法
    @objc func loginButtonClick(){
        print(#function)
        // 登录
        // 发出用户登录通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
        
    }
    @objc func registerButtonClick(){
        // 注册
        print(#function)
    }
}

// MARK: - 设置界面
extension WBBaseViewController{
    
    fileprivate func setupUI(){
    
        view.backgroundColor = UIColor.random()
        // 禁止自动调整ScrollView内容缩进
        automaticallyAdjustsScrollViewInsets = false
        setupNavBar()
        WBNetworkManager.shared.userLogon ? setupTableView() : setupVisitorView()
    }
    
    
    /// 设置表格视图
     func setupTableView(){
        
        tableView = UITableView(frame: view.bounds, style: .plain)
//        view.addSubview(tableView!) // 要修改代码顺序  setupNavBar , setupTableView , 用 insert
        view.insertSubview(tableView!, belowSubview: navBar)
        // 设置数据源/代理
        tableView?.dataSource = self
        tableView?.delegate = self
        // 设置表格视图缩进, top 缩进导航条的高度, bottom 缩进 tabbar 的高度(默认是49)
        tableView?.contentInset = UIEdgeInsets(top: navBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                               right: 0)
        // 设置 TableView 滚动指示器的缩进
        tableView?.scrollIndicatorInsets = tableView!.contentInset
            
        // 设置下拉刷新
        // 实例化刷新控件
        refreshControl = UIRefreshControl()
        // 添加到视图
        tableView?.addSubview(refreshControl!)
        // 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        
    }
    
    /// 设置访客视图
    private func setupVisitorView(){
        
        let visitorView = WBVisitorView(frame: view.bounds)
        view.insertSubview(visitorView, belowSubview: navBar)
        // 设置访客视图的界面配置信息
        visitorView.visitorInfo = visitorViewInfo
        // 监听访客视图按钮点击
        visitorView.loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        // 设置访客视图导航栏按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerButtonClick))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginButtonClick))
    }
    
    
    /// 设置导航条
    private func setupNavBar(){
    
        view.addSubview(navBar)
        // 将自定义的 navItem 设置给自定义的 navBar
        navBar.items = [navItem]
        // 设置 bar 背景渲染颜色
        navBar.barTintColor = UIColor(hex: 0xF6F6F6)
        // 设置 bar title 文字的颜色
        navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        // 设置导航条按钮文字颜色
        navBar.tintColor = UIColor.orange

    }
    
}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension WBBaseViewController : UITableViewDataSource,UITableViewDelegate {
    // 基类只是准备这些方法,具体内容由子类实现
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 将要显示的第几行
        let row = indexPath.row
        // 最后一个section的行数
        let section = tableView.numberOfSections - 1
        let count = tableView.numberOfRows(inSection: section)
        
        if row < 0 || section < 0 {
            return
        }
        
        if row == count-1 , !isPullupRefresh { // 将要显示的行是最后一个section的最后一行,且没有在上拉刷新
            print("上拉刷新")
            isPullupRefresh = true
            
            loadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    
    
}

