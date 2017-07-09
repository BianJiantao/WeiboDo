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
        // -> 系统自带的没有高亮
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(showNext))
        // -> 代码多处用到,进行抽取
//        let btn:UIButton = UIButton.textButton("下一个", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showNext), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        // ---> 最终优化如下
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
        
    }
}
