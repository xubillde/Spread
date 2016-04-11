//
//  XWDiscoverCellShareModule.h
//  Spread
//
//  Created by 邱学伟 on 16/4/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  Cell分享模块(根据数据源设置是否存在此模块)

#import "XWDiscoverCellBaseModule.h"

@interface XWDiscoverCellShareModule : XWDiscoverCellBaseModule

/**
 *  点击分享跳转造作
 */
@property (nonatomic, copy) XWDiscoverTapBlock tapShareBlock;

/**
 *  初始化
 */
-(instancetype)initWithWidth:(CGFloat)widthTemp;
/**
 *  设置模块数据
 */
-(void)setDataWithModel:(XWDiscoverShareModel *)model;

@end
