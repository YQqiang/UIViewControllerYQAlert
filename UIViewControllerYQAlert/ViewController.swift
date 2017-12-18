//
//  ViewController.swift
//  UIViewControllerYQAlert
//
//  Created by sungrow on 2017/11/20.
//  Copyright © 2017年 yuqiangcoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
}

// MARK: - ShowAlert
extension ViewController {
    /// 基本使用
    @IBAction func showAlert(_ sender: UIButton, forEvent event: UIEvent) {
        yq.makeAlert { (make) in
            make.title = "标题"
            make.desc = "弹出框描述文字弹出框描述文字弹出框描述文字弹出框描述文字弹出框描述文字"
        }.show()
    }
    
    /// 更改按钮颜色
    @IBAction func showAlertChangeColor(_ sender: UIButton) {
        yq.makeAlert { (make) in
            make.title = "提示"
            make.desc = "自定义按钮颜色"
            make.cancelTitleColor = UIColor(colorHex: 0xF47920)
            make.confirmTitleColor = UIColor(colorHex: 0xF47920)
        }.show()
    }
    
    /// 更改按钮文字
    @IBAction func showAlertChangeButtonTitle(_ sender: UIButton) {
        yq.makeAlert { (make) in
            make.title = "提示"
            make.desc = "自定义按钮文字内容"
            make.cancelTitleColor = UIColor(colorHex: 0xF47920)
            make.confirmTitleColor = UIColor(colorHex: 0xF47920)
            make.cancelTitle = "好吧,暂不更换 😌"
            make.confirmTitle = "我知道了,继续更换 🤣"
        }.show()
    }
    
    /// 自定义标题和描述文字
    @IBAction func showAlertChangeTitleAndDesc(_ sender: UIButton) {
        yq.makeAlert { (make) in
            make.title = "警告"
            make.titleFont = UIFont.systemFont(ofSize: 22)
            make.titleColor = UIColor.red
            make.desc = "正在执行非常危险的操作"
            make.descFont = UIFont.systemFont(ofSize: 18)
            make.descColor = UIColor.darkGray
        }.show()
    }
    
    /// 自定义顶部图片
    @IBAction func showAlertTitleImage(_ sender: UIButton) {
        yq.makeAlert { (make) in
            make.desc = "抱歉, 操作失败"
            make.titleImage = UIImage(named: "fail")
            make.cancelTitleColor = UIColor(colorHex: 0xF47920)
            make.confirmTitleColor = UIColor(colorHex: 0xF47920)
        }.show()
    }
    
    /// 按钮点击事件回调
    @IBAction func showAlertAction(_ sender: UIButton) {
        yq.makeAlert { (make) in
            make.title = "提示"
            make.desc = "耶!!! 操作成功!"
            make.titleImage = UIImage(named: "success")
            make.cancelTitleColor = UIColor(colorHex: 0xF47920)
            make.confirmTitleColor = UIColor(colorHex: 0xF47920)
        }.confirmClosure({ (action) in
            print("\(String(describing: action.title))")
        }).cancelClosure({ (action) in
            print("\(String(describing: action.title))")
        }).show()
    }
    
    /// 一个操作按钮的弹出框
    @IBAction func showAlertOneButton(_ sender: UIButton) {
        yq.makeAlert { (make) in
            make.title = "提示"
            make.desc = "只有一个操作按钮的弹出框"
            make.confirmTitleColor = UIColor(colorHex: 0xF47920)
        }.confirmClosure({ (action) in
            print("\(String(describing: action.title))")
        }).showSingleConfirm()
    }
    
    /// 富文本描述文字
    @IBAction func showAttributeDescAlert(_ sender: UIButton) {
        yq.makeAlert { (make) in
            make.title = "富文本"
            let descAttri = NSMutableAttributedString()
            descAttri.append(NSAttributedString(string: "使用富文本描述文字属性名称", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
            descAttri.append(NSAttributedString(string: "\"attributedDesc\"", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.red]))
            descAttri.append(NSAttributedString(string: "设置描述文字", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
            make.attributedDesc = descAttri
            
        }.showSingleConfirm()
    }
    
    /// 综合使用
    @IBAction func showAlertComprehensive(_ sender: UIButton) {
        yq.makeAlert { (make) in
            make.title = "提示"
            make.desc = "自定义按钮文字内容"
            make.titleImage = UIImage(named: "fail")
            make.cancelTitleColor = UIColor(colorHex: 0xF47920)
            make.confirmTitleColor = UIColor.gray
            make.cancelTitle = "好吧,暂不更换 😌"
            make.confirmTitle = "我知道了,继续更换 🤣"
        }.confirmClosure({ (action) in
            print("\(String(describing: action.title))")
        }).cancelClosure({ (action) in
            print("\(String(describing: action.title))")
        }).show()
    }
}

