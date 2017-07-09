//
//  WBHomeViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @objc fileprivate func showFriends(){
        print(#function)
        
        let vc = WBTestViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    
    }

}

extension WBHomeViewController{
    
    override func setupUI() {
        super.setupUI()
        
        // -> 系统自带的没有高亮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        // -> 代码多处用到,进行抽取
//        let btn:UIButton = UIButton.textButton("好友", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        // ---> 最终优化如下
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
    }
}
