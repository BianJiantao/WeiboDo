//
//  WBHomeViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

// 定义当前文件下全局常量, cell 的重用标识符
fileprivate let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {

    fileprivate lazy var statusList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @objc fileprivate func showFriends(){
        print(#function)
        
        let vc = WBTestViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
    // 加载数据
    override func loadData() {
        
        // 用网络工具加载微博数据
        WBNetworkManager.shared.statusList { (list, isSuccess) in
            print(list)
        }
//        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token":"2.00WKSdoG6a1eKB389a618b50dvgDPB"]
//        
////        WBNetworkManager.shared.get(urlStr, parameters: params, progress: nil, success: { (_, json) in
////            print(json)
////            }) { (_, error) in
////                print("网络请求失败\(error)")
////        }
//        
//        WBNetworkManager.shared.request(URLString: urlStr, parameters: params) { (json, isSuccess) in
//            
//            print(json)
//            
//        }
        
        
        
        /// 模拟'延时'加载数据
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
            for i in 0..<15 {
                
                if self.isPullRefresh { // 上拉刷新
                    
                    self.statusList.append("上拉\(i)")
                    
                }else { // 下拉刷新
                    
                    self.statusList.insert(i.description, at: 0)
                }
                
                
            }
            // 刷新表格
            self.tableView?.reloadData()
            // 重置上拉刷新标记
            self.isPullRefresh = false
            
            // 结束刷新
            self.refreshControl?.endRefreshing()
            
        }
        
    }
    

}

// MARK: - 实现数据源方法
extension WBHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 取出 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        // 设置 cell
        cell.textLabel?.text = statusList[indexPath.row]
        
        // 返回 cell
        return cell
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
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
}
