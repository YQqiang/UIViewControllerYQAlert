//
//  UIViewControllerYQAlert.swift
//  UIViewControllerYQAlert
//
//  Created by sungrow on 2017/11/20.
//  Copyright © 2017年 yuqiangcoder. All rights reserved.
//

import UIKit
import Foundation

class AlertMaker {
    
    var titleImage: UIImage?
    var titleImageSize: CGSize = CGSize.zero
    
    var title: String = ""
    var desc: String = ""
    var attributedDesc: NSAttributedString?
    var rightActionTitle: String = NSLocalizedString("CONFIRM", comment: "")
    var leftActionTitle: String = NSLocalizedString("CANCEL", comment: "")
    
    var titleColor: UIColor = UIColor.black
    var descColor: UIColor = UIColor(colorHex: 0x363636)
    
    var rightActionTitleColor: UIColor?
    var leftActionTitleColor: UIColor?
    
    var titleFont: UIFont = UIFont.systemFont(ofSize: 16)
    var descFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    fileprivate var rightActionClosure: ((_ action: UIAlertAction) -> Void)?
    fileprivate var leftActionClosure: ((_ action: UIAlertAction) -> Void)?
    
    fileprivate var viewController: UIViewController?
    
    @discardableResult
    func show(isSingleRight: Bool = false) -> UIAlertController {
        var titleAttr = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: titleFont, NSAttributedStringKey.foregroundColor: titleColor])
        var descAttr = NSAttributedString(string: ((title.count > 0 && desc.count > 0) ? "\n" : "") + desc, attributes: [NSAttributedStringKey.font: descFont, NSAttributedStringKey.foregroundColor: descColor])
        if let _ = attributedDesc {
            let tempAttr = NSMutableAttributedString(string: ((title.count > 0  && attributedDesc!.string.count > 0) ? "\n" : ""), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 1)])
            tempAttr.append(attributedDesc!)
            descAttr = tempAttr
        }
        let alertVC = SGAlertController(title: "", message: "", preferredStyle: .alert)
        alertVC.linkRegex = linkRegex
        alertVC.passColor = passColor
        alertVC.linkColor = linkColor
        alertVC.linkClickBegin = linkClickBegin
        alertVC.linkClickEnd = linkClickEnd
        alertVC.linkUnderLineStyle = linkUnderLineStyle
        if let titleImg = titleImage {
            if titleImageSize == CGSize.zero {
                titleImageSize = titleImg.size
            }
            var count = Int(titleImageSize.height / titleImageHeight()) + 1
            if (title.count > 0 || desc.count > 0) {
                count += 1
            }
            var enterStr = ""
            for _ in 0..<count {
                enterStr += "\n"
            }
            titleAttr = NSAttributedString(string: enterStr + title, attributes: [NSAttributedStringKey.font: titleFont, NSAttributedStringKey.foregroundColor: titleColor])
            alertVC.setValue(titleAttr, forKey: "attributedTitle")
            alertVC.setValue(descAttr, forKey: "attributedMessage")
            let titleImageView = UIImageView(image: titleImg)
            alertVC.view.addSubview(titleImageView)
            titleImageView.translatesAutoresizingMaskIntoConstraints = false
            let topConstraint = NSLayoutConstraint(item: titleImageView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: alertVC.view, attribute: .top, multiplier: 1.0, constant: 16)
            let centerXConstraint = NSLayoutConstraint(item: titleImageView, attribute: .centerX, relatedBy: .equal, toItem: alertVC.view, attribute: .centerX, multiplier: 1.0, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: titleImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: titleImageSize.width)
            let heightConstraint = NSLayoutConstraint(item: titleImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: titleImageSize.height)
            alertVC.view.addConstraints([topConstraint, centerXConstraint, widthConstraint, heightConstraint])
        } else {
            alertVC.setValue(titleAttr, forKey: "attributedTitle")
            alertVC.setValue(descAttr, forKey: "attributedMessage")
        }
        alertVC.view.tintColor = rightActionTitleColor
        
        let confirmAction = SGAlertAction(title: rightActionTitle, style: .default) { (action) in
            if let closure = self.rightActionClosure {
                closure(action)
            }
        }
        if !isSingleRight {
            let cancelAction = SGAlertAction(title: leftActionTitle, style: .default) { (action) in
                if let closure = self.leftActionClosure {
                    closure(action)
                }
            }
            cancelAction.setValue(leftActionTitleColor, forKey: "titleTextColor")
            alertVC.addAction(cancelAction)
        }
        confirmAction.setValue(rightActionTitleColor, forKey: "titleTextColor")
        alertVC.addAction(confirmAction)
        self.viewController?.present(alertVC, animated: true, completion: nil)
        return alertVC
    }
    
    func showSingleRight() {
        show(isSingleRight: true)
    }
    
    func rightActionClosure(_ closure: @escaping (UIAlertAction) -> Void) -> AlertMaker {
        rightActionClosure = closure
        return self
    }
    
    func leftActionClosure(_ closure: @escaping (UIAlertAction) -> Void) -> AlertMaker {
        leftActionClosure = closure
        return self
    }
    
    fileprivate func titleImageHeight() -> CGFloat {
        return "\n".boundingRect(with: CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width), font: titleFont).height
    }
    
    
    // MARK: - 超链接
    var linkRegex: String?
    var linkClickBegin: ((SGLinkLabel, String) -> Void)?
    var linkClickEnd: ((SGLinkLabel, String) -> Void)?
    var linkColor: UIColor = UIColor(colorHex: 0x2D8EE5)
    var passColor: UIColor = UIColor.gray
    var linkUnderLineStyle: SGLinkUnderLineStyle = .none
    var ocLinkUnderLineStyle: Int = 0 {
        didSet {
            switch ocLinkUnderLineStyle {
            case 1:
                linkUnderLineStyle = .single
                break
            case 2:
                linkUnderLineStyle = .thick
                break
            case 3:
                linkUnderLineStyle = .double
                break
            default:
                linkUnderLineStyle = .none
            }
        }
    }
    
    func linkClickBegin(_ closure: @escaping (SGLinkLabel, String) -> Void) -> AlertMaker {
        linkClickBegin = closure
        return self
    }
    
    func linkClickEnd(_ closure: @escaping (SGLinkLabel, String) -> Void) -> AlertMaker {
        linkClickEnd = closure
        return self
    }
}

extension AlertMaker {
    /// 倒计时弹框 （ X 秒后， 确定按钮可用）
    ///
    /// - Parameter second: 待倒计时的数值
    func showCountdown(_ second: Int) {
        var count = second
        let alertVC = show()
        let action = alertVC.actions.last
        let actionTitle = rightActionTitle + "(" + "\(count)" + ")"
        action?.setValue(actionTitle, forKey: "title")
        alertVC.actions.last?.isEnabled = false
        let _ = Timer.yq_scheduledTimerWithTimeInterval(TimeInterval(1), repeats: true) {[weak self] (timer) in
            guard let strongSelf = self else {
                timer.invalidate()
                return
            }
            count -= 1
            var title = strongSelf.rightActionTitle + "(" + "\(count)" + ")"
            if count <= 0 {
                title = strongSelf.rightActionTitle
                action?.isEnabled = true
                timer.invalidate()
            }
            action?.setValue(title, forKey: "title")
        }
    }
}

struct AlertManager {
    private let viewController: UIViewController
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension AlertManager {
    func makeAlert(_ closure: ((AlertMaker) -> Void)) -> AlertMaker {
        let maker = AlertMaker()
        maker.viewController = viewController
        closure(maker)
        return maker
    }
}

extension UIViewController {
    var yq: AlertManager {
        return AlertManager(viewController: self)
    }
}

// MARK: - ------------------------辅助函数----------------------------------------
extension UIColor {
    
    convenience init(colorHex: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(Double((colorHex & 0xFF0000) >> 16))/255.0, green: CGFloat(Double((colorHex & 0xFF00) >> 8))/255.0, blue: CGFloat(Double(colorHex & 0xFF))/255.0, alpha: alpha)
    }
    
    class func colorWith(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(Double((hex & 0xFF0000) >> 16))/255.0, green: CGFloat(Double((hex & 0xFF00) >> 8))/255.0, blue: CGFloat(Double(hex & 0xFF))/255.0, alpha: alpha)
    }
    
    class func colorWith(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
}

extension String {
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedStringKey.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        
        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing && spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }
        
        return size
    }
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }
        
        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }
        
        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight*CGFloat(lines) + currentLineSpacing*CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }
        
        return size
    }
}

extension Timer {
    @objc open class func yq_scheduledTimerWithTimeInterval(_ inerval: TimeInterval, repeats: Bool, block:@escaping ((Timer) -> Void)) -> Timer {
        return Timer.scheduledTimer(timeInterval: inerval, target: self, selector: #selector(yq_blockInvoke(_:)), userInfo: block, repeats: repeats)
    }
    
    @objc private class func yq_blockInvoke(_ timer: Timer) {
        if let block = timer.userInfo as? ((Timer) -> Void) {
            block(timer)
        }
    }
}

private class SGAlertAction: UIAlertAction {
    open override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}

enum SGLinkUnderLineStyle: Int {
    case none = 0
    case single = 1
    case thick = 2
    case double = 3
}

private class SGAlertController: UIAlertController {
    
    var linkRegex: String?
    var linkClickBegin: ((SGLinkLabel, String) -> Void)?
    var linkClickEnd: ((SGLinkLabel, String) -> Void)?
    var linkColor: UIColor = UIColor.blue
    var passColor: UIColor = UIColor.blue
    var linkUnderLineStyle: SGLinkUnderLineStyle = .none
    
    fileprivate lazy var messageLabel: SGLinkLabel = {
        let label = SGLinkLabel()
        label.sgLinkLabelDelegate = self
        label.numberOfLines = 0
        self.view.addSubview(label)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if linkRegex != nil {
            findSubV(view)
        }
    }
    
    override func viewWillLayoutSubviews() {
        if linkRegex == nil {
            setDescLabelNumofRow(view)
        }
        super.viewWillLayoutSubviews()
    }
    
    fileprivate func setDescLabelNumofRow(_ superV: UIView) {
        superV.subviews.forEach { (subV) in
            let messageAttr = value(forKey: "attributedMessage") as? NSAttributedString
            if let lbl = subV as? UILabel, lbl.text == messageAttr?.string  {
                lbl.sizeToFit()
                let textWidth = messageAttr?.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], context: nil).size.width ?? 0
                let lblWidth = lbl.frame.width
                if textWidth > lblWidth {
                    lbl.textAlignment = .left
                } else {
                    lbl.textAlignment = .center
                }
                view.layoutIfNeeded()
                return
            } else {
                setDescLabelNumofRow(subV)
            }
        }
    }
    
    fileprivate func findSubV(_ superV: UIView) {
        superV.subviews.forEach { (subV) in
            let messageAttr = value(forKey: "attributedMessage") as? NSAttributedString
            if let lbl = subV as? UILabel, lbl.text == messageAttr?.string  {
                lbl.isHidden = true
                messageLabel.text = lbl.text
                messageLabel.isHidden = !lbl.isHidden
                messageLabel.font = lbl.font
                messageLabel.textColor = lbl.textColor
                
                messageLabel.translatesAutoresizingMaskIntoConstraints = false
                messageLabel.topAnchor.constraint(equalTo: lbl.topAnchor).isActive = true
                messageLabel.bottomAnchor.constraint(equalTo: lbl.bottomAnchor).isActive = true
                messageLabel.leftAnchor.constraint(equalTo: lbl.leftAnchor).isActive = true
                messageLabel.rightAnchor.constraint(equalTo: lbl.rightAnchor).isActive = true
            } else {
                findSubV(subV)
            }
        }
    }
    
    open override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}

extension SGAlertController: SGLinkLabelDelegate {
    
    func contentsOfRegexString(with sgLinkLabel: SGLinkLabel!) -> String! {
        return linkRegex ?? ""
    }
    
    func passColor(with sgLinkLabel: SGLinkLabel!) -> UIColor! {
        return passColor
    }
    
    func linkColor(with sgLinkLabel: SGLinkLabel!) -> UIColor! {
        return linkColor
    }
    
    func linkUnderlineStyle(with sgLinkLabel: SGLinkLabel!) -> CTUnderlineStyle {
        return CTUnderlineStyle.init(rawValue: Int32(linkUnderLineStyle.rawValue))
    }
    
    func alignmentStyle(with sgLinkLabel: SGLinkLabel!) -> CTTextAlignment {
        let textWidth = messageLabel.text?.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), font: messageLabel.font).width ?? 0
        let lblWidth = messageLabel.frame.width
        if textWidth > lblWidth {
            return CTTextAlignment.left
        }
        return CTTextAlignment.center
    }
    
    func toucheBenginSGLinkLabel(_ sgLinkLabel: SGLinkLabel!, withContext context: String!) {
        if let closure = linkClickBegin {
            closure(sgLinkLabel, context)
        }
    }
    
    func toucheEnd(_ sgLinkLabel: SGLinkLabel!, withContext context: String!) {
        if let closure = linkClickEnd {
            closure(sgLinkLabel, context)
        }
    }
}

