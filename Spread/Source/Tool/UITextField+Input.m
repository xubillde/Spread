//
//  UITextField+Input.m
//  OneHelper
//
//  Created by qiuxuewei on 16/1/30.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "UITextField+Input.h"

@implementation UITextField (Input)

-(instancetype)initTextFieldWithImage:(UIImage *)image withPlaceholderText:(NSString *)placeholderText{
    self = [super init];
    if (self) {
        //字体大小
        self.font = [UIFont systemFontOfSize:15];
        //提示文：
        self.placeholder = placeholderText;
        //背景
        self.background = [UIImage createImageWithColor:colorWithRGBA(243, 242, 248, 1)];
        //设置左边图片
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = image;
        searchIcon.height = 30;
        searchIcon.width = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        //输入框内文字颜色
        self.textColor = [UIColor blackColor];
        //清除按钮
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        //圆角设置
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:12.0];
        //设置矩形四个圆角半径
        [self.layer setCornerRadius:6.0];
    }
    return self;
}

//-(instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        //字体大小
//        self.font = [UIFont systemFontOfSize:15];
//        
//        //背景
//        self.background = [UIImage createImageWithColor:colorWithRGBA(243, 242, 248, 1)];
////        self.leftViewMode = UITextFieldViewodeAlways;
//        //输入框内文字颜色
//        self.textColor = [UIColor blackColor];
//        //清除按钮
//        self.clearButtonMode = UITextFieldViewModeWhileEditing;
//        //圆角设置
//        [self.layer setMasksToBounds:YES];
//        [self.layer setCornerRadius:12.0];
//        //设置矩形四个圆角半径
//        [self.layer setCornerRadius:6.0];
//        
//    }
//    return self;
//}

@end
