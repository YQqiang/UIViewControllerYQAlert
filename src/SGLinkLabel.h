//
//  SGLinkLabel.h
//  UIViewControllerYQAlert
//
//  Created by sungrow on 2018/2/27.
//  Copyright © 2018年 yuqiangcoder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@class SGLinkLabel;
@protocol SGLinkLabelDelegate <NSObject>

@optional

//手指离开当前超链接文本响应的协议方法
- (void)toucheEndSGLinkLabel:(SGLinkLabel *)sgLinkLabel withContext:(NSString *)context;
//手指接触当前超链接文本响应的协议方法
- (void)toucheBenginSGLinkLabel:(SGLinkLabel *)sgLinkLabel withContext:(NSString *)context;

/*
 - (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
 {
 //需要添加链接字符串的正则表达式：@用户、http://、#话题#
 NSString *regex1 = @"@\\w+";
 NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
 NSString *regex3 = @"#\\w+#";
 NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
 return regex;
 }
 */
//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithSGLinkLabel:(SGLinkLabel *)sgLinkLabel;
//设置当前链接文本的颜色
- (UIColor *)linkColorWithSGLinkLabel:(SGLinkLabel *)sgLinkLabel;
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithSGLinkLabel:(SGLinkLabel *)sgLinkLabel;
// 超链接下划线样式
- (CTUnderlineStyle)linkUnderlineStyleWithSGLinkLabel:(SGLinkLabel *)sgLinkLabel;
//文本对齐方式
- (CTTextAlignment)alignmentStyleWithSGLinkLabel:(SGLinkLabel *)sgLinkLabel;

/*
 注意：
 默认表达式@"<image url = '[a-zA-Z0-9_\\.@%&\\S]*'>" //[ffff]
 可以通过代理方法修改正则表达式，不过本地图片地址的左右（＊＊＊一定要用单引号引起来）
 */
//检索文本中图片的正则表达式的字符串
- (NSString *)imagesOfRegexStringWithSGLinkLabel:(SGLinkLabel *)sgLinkLabel;
@end



@interface SGLinkLabel : UILabel

@property(nonatomic,assign)id<SGLinkLabelDelegate> sgLinkLabelDelegate;//代理对象
@property(nonatomic,assign)CGFloat linespace;//行间距   default = 0.0f
@property(nonatomic,assign)CGFloat mutiHeight;//行高(倍数) default = 1.0f
@property(nonatomic,assign)CGFloat textHeight;


//计算文本内容的高度
+ (float)getTextHeight:(float)fontSize
                 width:(float)width
                  text:(NSString *)text
             linespace:(CGFloat)linespace;
@end
