//
//  UIViewControllerYQAlert.swift
//  UIViewControllerYQAlert
//
//  Created by sungrow on 2017/11/20.
//  Copyright © 2017年 yuqiangcoder. All rights reserved.
//

import UIKit

class AlertMaker {
    
    var titleImage: UIImage?
    var titleImageSize: CGSize = CGSize.zero
    
    var title: String = ""
    var desc: String = ""
    var confirmTitle: String = NSLocalizedString("CONFIRM", comment: "")
    var cancelTitle: String = NSLocalizedString("CANCEL", comment: "")
    
    var titleColor: UIColor = UIColor.black
    var descColor: UIColor = UIColor(colorHex: 0x363636)
    
    var confirmTitleColor: UIColor?
    var cancelTitleColor: UIColor?
    
    var titleFont: UIFont = UIFont.systemFont(ofSize: 16)
    var descFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    fileprivate var confirmClosure: ((_ action: UIAlertAction) -> Void)?
    fileprivate var cancelClosure: ((_ action: UIAlertAction) -> Void)?
    
    fileprivate var viewController: UIViewController?
    
    func show(isSingleConfirm: Bool = false) {
        var titleAttr = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: titleFont, NSAttributedStringKey.foregroundColor: titleColor])
        let descAttr = NSAttributedString(string: "\n" + desc, attributes: [NSAttributedStringKey.font: descFont, NSAttributedStringKey.foregroundColor: descColor])
        
        let alertVC = UIAlertController(title: "", message: "", preferredStyle: .alert)
        if let titleImg = titleImage {
            if titleImageSize == CGSize.zero {
                titleImageSize = titleImg.size
            }
            var count = Int(titleImageSize.height / titleImageHeight()) + 1
            if title.characters.count > 0 {
                count += 1
            }
            var enterStr = ""
            for _ in 0..<count {
                enterStr += "\n"
            }
            titleAttr = NSAttributedString(string: enterStr + title, attributes: [NSAttributedStringKey.font: titleFont, NSAttributedStringKey.foregroundColor: titleColor])
            let titleImageView = UIImageView(image: titleImg)
            alertVC.view.addSubview(titleImageView)
            titleImageView.translatesAutoresizingMaskIntoConstraints = false
            let topConstraint = NSLayoutConstraint(item: titleImageView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: alertVC.view, attribute: .top, multiplier: 1.0, constant: 16)
            let centerXConstraint = NSLayoutConstraint(item: titleImageView, attribute: .centerX, relatedBy: .equal, toItem: alertVC.view, attribute: .centerX, multiplier: 1.0, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: titleImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: titleImageSize.width)
            let heightConstraint = NSLayoutConstraint(item: titleImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: titleImageSize.height)
            alertVC.view.addConstraints([topConstraint, centerXConstraint, widthConstraint, heightConstraint])
        }
        alertVC.setValue(titleAttr, forKey: "attributedTitle")
        alertVC.setValue(descAttr, forKey: "attributedMessage")
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            if let closure = self.confirmClosure {
                closure(action)
            }
        }
        confirmAction.setValue(confirmTitleColor, forKey: "titleTextColor")
        alertVC.addAction(confirmAction)
        
        if !isSingleConfirm {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .default) { (action) in
                if let closure = self.cancelClosure {
                    closure(action)
                }
            }
            cancelAction.setValue(cancelTitleColor, forKey: "titleTextColor")
            alertVC.addAction(cancelAction)
        }
        self.viewController?.present(alertVC, animated: true, completion: nil)
    }
    
    func showSingleConfirm() {
        show(isSingleConfirm: true)
    }
    
    func confirmClosure(_ closure: @escaping (UIAlertAction) -> Void) -> AlertMaker {
        confirmClosure = closure
        return self
    }
    
    func cancelClosure(_ closure: @escaping (UIAlertAction) -> Void) -> AlertMaker {
        cancelClosure = closure
        return self
    }
    
    fileprivate func titleImageHeight() -> CGFloat {
        return "\n".boundingRect(with: CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width), font: titleFont).height
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
