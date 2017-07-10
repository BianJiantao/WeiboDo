//
//  WBBaseViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
// 基类控制器

import UIKit

class WBBaseViewController: UIViewController {

    // 登录标识符
    var userLogon = false
    // 表格视图
    var tableView:UITableView?
    // 下拉刷新控件
    var refreshControl:UIRefreshControl?
    var isPullRefresh:Bool = false
    
    
    /// 自定义导航条
    lazy var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth(), height: 64))
    
    /// 自定义导航条item , 以后设置导航栏内容, 统一使用navItem
    lazy var navItem = UINavigationItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
        
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


// MARK: - 设置界面
extension WBBaseViewController{
    
    func setupUI(){
    
        view.backgroundColor = UIColor.random()
        // 禁止自动调整ScrollView内容缩进
        automaticallyAdjustsScrollViewInsets = false
        setupNavBar()
        userLogon ? setupTableView() : setupVisitorView()
    }
    
    
    /// 设置表格视图
    private func setupTableView(){
        
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
        
        if row == count-1 , !isPullRefresh { // 将要显示的行是最后一个section的最后一行,且没有在上拉刷新
            print("上拉刷新")
            isPullRefresh = true
            
            loadData()
        }
        
    }
    
    
}

