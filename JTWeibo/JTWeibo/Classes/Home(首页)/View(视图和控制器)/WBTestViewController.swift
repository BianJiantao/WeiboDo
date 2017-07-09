//
//  WBTestViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
// 测试用控制器

import UIKit

class WBTestViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
        
    }

    @objc fileprivate func showNext(){
        
        let vc = WBTestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension WBTestViewController{
    
    override func setupUI() {
        super.setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(showNext))
        
    }
}
