//
//  UIView+CurrentController.m
//  Spread
//
//  Created by 邱学伟 on 16/3/29.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "UIView+CurrentController.h"

@implementation UIView (CurrentController)

/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil); 
    return nil;
}

@end
