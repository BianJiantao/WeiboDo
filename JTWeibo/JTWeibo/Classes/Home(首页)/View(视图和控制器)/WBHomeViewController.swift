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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
    }
}
