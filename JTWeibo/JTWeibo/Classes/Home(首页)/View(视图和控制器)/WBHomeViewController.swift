//
//  WBHomeViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

// 定义当前文件下全局常量, cell 的重用标识符

//原创微博可重用 cell
private let originalCellID = "originalCellID"
//转发微博的可重用 cell
private let retweetedCellID = "retweetedCellID"

class WBHomeViewController: WBBaseViewController {

    // 微博列表视图模型,管理微博数据
    fileprivate lazy var listViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @objc fileprivate func showFriends(){
        print(#function)
        
        let vc = WBTestViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
    /// 标题按钮点击
    @objc fileprivate func titleBtnClick(btn:UIButton){
        
        btn.isSelected = !btn.isSelected
        
    }
    
    
    /// 加载数据
    override func loadData() {
        
        
        refreshControl?.beginRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { // 模拟网速慢
            
            self.listViewModel.loadStatus(pullupRefresh: self.isPullupRefresh) { (isSuccess,shouldRefresh) in
                
                if shouldRefresh { // 需要刷新微博表格数据
                    // 刷新表格
                    self.tableView?.reloadData()
                }
                
                // FIXME:下拉刷新,清除 tabbarItem 和 app 的 badgeValue
                
                // 重置上拉刷新标记
                self.isPullupRefresh = false
                
                // 结束刷新
                self.refreshControl?.endRefreshing()
            }
            
        }
        
    }
    

}

// MARK: - 实现数据源方法
extension WBHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = listViewModel.statusList[indexPath.row]
        let cellID = viewModel.status.retweeted_status == nil ? originalCellID : retweetedCellID
        // 取出 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WBStatusCell
        // 设置 cell
        cell.viewModel = viewModel
        cell.delegate = self
        
        // 返回 cell
        return cell
    }
    
    /// 父类必须实现代理方法 子类才能重写 Swift 3.0 如此 2.0 不需要
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let viewModel = listViewModel.statusList[indexPath.row]
        
        return viewModel.rowHeight
        
    }
    
}



// MARK: - 设置界面
extension WBHomeViewController{
    
    override func setupTableView() {

        super.setupTableView()
        
        // -> 系统自带的没有高亮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        // -> 代码多处用到,进行抽取
//        let btn:UIButton = UIButton.textButton("好友", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        // ---> 最终优化如下
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        // 注册原型 cell
        tableView?.register(UINib(nibName: "WBStatusNormalCell", bundle: nil), forCellReuseIdentifier: originalCellID)
        tableView?.register(UINib(nibName: "WBStatusRetweedCell", bundle: nil), forCellReuseIdentifier: retweetedCellID)
        
        
        // 设置行高
//        tableView?.rowHeight = UITableViewAutomaticDimension
//        tableView?.estimatedRowHeight = 450
        
//        tableView?.rowHeight = 450
        
        tableView?.separatorStyle = .none
        // 设置导航栏标题
        setupNavTitle()
        
    }
    
    
    /// 设置导航栏标题按钮
    private func setupNavTitle(){
        
        let title = WBNetworkManager.shared.account.screen_name
        
        let titleBtn = WBTitleButton(title:title)
        navItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(titleBtnClick(btn:)), for: .touchUpInside)
        
    }
    
    
}


extension WBHomeViewController:WBStatusCellDelegate{
    func statusCellDidTapURLString(cell: WBStatusCell, urlString: String) {
        let vc = WBWebViewController()
        vc.urlString = urlString
        navigationController?.pushViewController(vc, animated: true)
    }
}
