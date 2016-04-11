//
//  XWDiscoverCellCommentModule.h
//  Spread
//
//  Created by 邱学伟 on 16/4/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  Cell点赞评论模块

#import "XWDiscoverCellBaseModule.h"

@interface XWDiscoverCellCommentModule : XWDiscoverCellBaseModule
/**
 *  点赞点击方法
 */
@property (nonatomic, copy) XWDiscoverTapBlock tapPraiseBlock;
/**
 *  评论点击方法
 */
@property (nonatomic, copy) XWDiscoverTapBlock tapCommentBlock;
/**
 *  初始化
 */
-(instancetype)initWithWidth:(CGFloat)widthTemp;
/**
 *  模块赋值
 */
-(void)setDataWithModel:(XWDiscoverCommentsModel *)model;

@end
