//
//  UIButton+Click.m
//  OneHelper
//
//  Created by qiuxuewei on 16/1/30.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "UIButton+Click.h"

@implementation UIButton (Click)

-(instancetype)initButtonWithTitle:(NSString *)btnTitle withFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.frame = frame;
        //设置背景颜色和背景高亮颜色
        UIImage *buttonImage = [UIImage createImageWithColor:colorWithRGBA(213, 212, 216, 0.8)];
        UIImage *buttonImageHighlight = [UIImage createImageWithColor:colorWithRGBA(213, 212, 216, 1)];
        [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
        //圆角设置
        [self.layer setMasksToBounds:YES];
//        [self.layer setCornerRadius:12.0];
        //设置矩形四个圆角半径
        [self.layer setCornerRadius:6.0];
        //设置标题文字
        [self setTitle:btnTitle forState:UIControlStateNormal];
        //标题文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

//查询按钮
-(instancetype)initInquireButtonWithTitle:(NSString *)btnTitle withFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andhightlightColor:(UIColor *)highlightColor{
    self = [super init];
    if (self) {
        self.frame = frame;
        //设置背景颜色和背景高亮颜色
        UIImage *buttonImage = [UIImage createImageWithColor:backgroundColor];
        UIImage *buttonImageHighlight = [UIImage createImageWithColor:highlightColor];
        [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
        //圆角设置
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:12.0];
        //设置矩形四个圆角半径
        [self.layer setCornerRadius:6.0];
        //设置标题文字
        [self setTitle:btnTitle forState:UIControlStateNormal];
        //标题文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

                                
                                
                    

@end
