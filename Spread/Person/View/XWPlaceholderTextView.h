//
//  XWPlaceholderTextView.h
//  Spread
//
//  Created by 邱学伟 on 16/4/18.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  有占位文字的UITextView

#import <UIKit/UIKit.h>

@interface XWPlaceholderTextView : UITextView

/**
 *  占位文字
 * 我们将根据您反馈的意见和问题, 提升产品的体验感!
 */
@property (nonatomic, copy) NSString *placeholderStr;
/**
 *  工厂方法
 *
 *  @param frame          textView的尺寸
 *  @param placeholderStr 占位文字
 */
+(instancetype)shareWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholderStr;

/**
 *  初始化
 */
-(instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholderStr;
@end
