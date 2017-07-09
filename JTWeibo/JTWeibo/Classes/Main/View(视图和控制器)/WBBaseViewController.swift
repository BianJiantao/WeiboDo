//
//  WBBaseViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
// 基类控制器

import UIKit

class WBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }


}


// MARK: - 设置界面
extension WBBaseViewController{
    
    func setupUI(){
    
    view.backgroundColor = UIColor.random()
    
    }
    
}
