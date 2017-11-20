# UIViewControllerYQAlert

## 介绍
在开发过程中, 难免会使用到弹出框; 系统的弹出框感觉不太能满足要求, 第三方的弹出框又不如系统的简洁.
该项目是基于系统的弹出框`UIAlertController`扩展出来可以简单修改样式的`Alert`, 并且以链式调用使用弹出框.

## 功能
- 自定义按钮文字颜色
- 自定义标题文字和描述文字颜色和字体
- 支持在标题顶部增加logo图片
- 支持单个按钮的弹出框
- 优雅的调用方式

## 要求
- Xcode 9.0
- Swift 4.0

## 安装
直接把`UIViewControllerYQAlert.swift`文件拖入项目中

## Demo
可直接下载项目运行Demo查看效果

## 使用
> `yq`是对`UIViewController`的扩展, 因此在`ViewController`中显示弹出框时,可直接使用`yq.makeAlert`方式

#### 1. 基本用法
```Swift
yq.makeAlert { (make) in
    make.title = "标题"
    make.desc = "弹出框描述文字弹出框描述文字弹出框描述文字弹出框描述文字弹出框描述文字"
}.show()
```

#### 2. 更改按钮颜色
```swift
yq.makeAlert { (make) in
    make.title = "提示"
    make.desc = "自定义按钮颜色"
    make.cancelTitleColor = UIColor(colorHex: 0xF47920)
    make.confirmTitleColor = UIColor(colorHex: 0xF47920)
}.show()
```

#### 3. 更改按钮文字
```swift
yq.makeAlert { (make) in
	make.title = "提示"
	make.desc = "自定义按钮文字内容"
	make.cancelTitleColor = UIColor(colorHex: 0xF47920)
	make.confirmTitleColor = UIColor(colorHex: 0xF47920)
	make.cancelTitle = "好吧,暂不更换 😌"
	make.confirmTitle = "我知道了,继续更换 🤣"
}.show()
```

#### 4. 自定义标题和描述文字
```swift
yq.makeAlert { (make) in
    make.title = "警告"
    make.titleFont = UIFont.systemFont(ofSize: 22)
    make.titleColor = UIColor.red
    make.desc = "正在执行非常危险的操作"
    make.descFont = UIFont.systemFont(ofSize: 18)
    make.descColor = UIColor.darkGray
}.show()
```

#### 5. 自定义顶部图片
```swift
yq.makeAlert { (make) in
    make.desc = "抱歉, 操作失败"
    make.titleImage = UIImage(named: "fail")
    make.cancelTitleColor = UIColor(colorHex: 0xF47920)
    make.confirmTitleColor = UIColor(colorHex: 0xF47920)
}.show()
```

#### 6. 按钮点击事件回调
```swift
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
```

#### 7. 一个操作按钮的弹出框
```swift
yq.makeAlert { (make) in
    make.title = "提示"
    make.desc = "只有一个操作按钮的弹出框"
    make.confirmTitleColor = UIColor(colorHex: 0xF47920)
}.confirmClosure({ (action) in
    print("\(String(describing: action.title))")
}).showSingleConfirm()
```

#### 8. 综合使用
```swift
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
```

## 联系我：
- 博客: http://yuqiangcoder.com/
- 邮箱: yuqiang.coder@gmail.com


