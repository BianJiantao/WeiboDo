//
//  WBBaseViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/9.
//  Copyright © 2017年 BJT. All rights reserved.
// 基类控制器

import UIKit

class WBBaseViewController: UIViewController {

    
    /// 自定义导航条
    lazy var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth(), height: 64))
    
    /// 自定义导航条item , 以后设置导航栏内容, 统一使用navItem
    lazy var navItem = UINavigationItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    
    /// 重写 title 的 didSet
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
        view.addSubview(navBar)
        navBar.items = [navItem]
        // 设置 bar 背景渲染颜色
        navBar.barTintColor = UIColor(hex: 0xF6F6F6)
        
    }
    
}
