//
//  XWDiscoverCellTitleModule.h
//  Spread
//
//  Created by 邱学伟 on 16/4/7.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  cell顶部模块(头像+昵称+发布时间)

#import "XWDiscoverCellBaseModule.h"

@interface XWDiscoverCellTitleModule : XWDiscoverCellBaseModule

/**
 *  点击头像block
 */
@property (nonatomic, copy) XWDiscoverTapBlock tapHeadBlock;
/**
 *  初始化
 */
-(instancetype)initWithWidth:(CGFloat)widthTemp;
/**
 *  设置数据模型
 */
-(void)setDataWithModel:(XWDiscoverTitleModel *)model;

@end
