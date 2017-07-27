//
//  WBComposeViewController.swift
//  JTWeibo
//
//  Created by BJT on 17/7/23.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

class WBComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.random()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", target:  self, action: #selector(close))
        
    }

    
    @objc private func close(){
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
