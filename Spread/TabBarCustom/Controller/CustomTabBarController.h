//
//  CustomTabBarController.h
//  Spread
//
//  Created by qiuxuewei on 16/3/21.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWMenuPopView;
@interface CustomTabBarController : UITabBarController

@property (nonatomic, strong) XWMenuPopView *menuPopView;

/** 提供类方法让外界访问唯一的实例 */
+(instancetype)shareInstance;

@end
