//
//  UIButton+Click.h
//  OneHelper
//
//  Created by qiuxuewei on 16/1/30.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Click)

/** 主页按钮 */
-(instancetype)initButtonWithTitle:(NSString *)btnTitle withFrame:(CGRect)frame;

/** 查询按钮 */
-(instancetype)initInquireButtonWithTitle:(NSString *)btnTitle withFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andhightlightColor:(UIColor *)highlightColor;

@end
