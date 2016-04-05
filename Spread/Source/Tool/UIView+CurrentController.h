//
//  UIView+CurrentController.h
//  Spread
//
//  Created by 邱学伟 on 16/3/29.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CurrentController)

/** 当前View的控制器对象 */
@property (nonatomic, strong) UIViewController *currentViewController;

/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController;

@end
