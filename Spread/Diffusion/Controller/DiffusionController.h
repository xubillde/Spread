//
//  DiffusionController.h
//  OneHelper
//
//  Created by qiuxuewei on 16/3/7.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "BaseViewController.h"
@class ZLSwipeableView;

@interface DiffusionController : BaseViewController

@property (nonatomic, strong) ZLSwipeableView *swipeableView;

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;

/** 模拟数据 */
@property (nonatomic, strong) NSArray *jokeImageArr;

/** 初始化 */
-(instancetype)initWithJokeImageArr:(NSArray *)jokeImageArr;

@end




