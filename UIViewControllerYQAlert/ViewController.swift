//
//  ViewController.swift
//  UIViewControllerYQAlert
//
//  Created by sungrow on 2017/11/20.
//  Copyright © 2017年 yuqiangcoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - ShowAlert
extension ViewController {
    @IBAction func showAlert(_ sender: UIButton, forEvent event: UIEvent) {
        yq.makeAlert { (make) in
            make.title = "弹出框标题"
            make.desc = "弹出框描述文字弹出框描述文字弹出框描述文字弹出框描述文字弹出框描述文字弹出框描述文字"
        }.show()
    }
}

