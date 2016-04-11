//
//  XWDiscoverCellVideoModule.h
//  Spread
//
//  Created by 邱学伟 on 16/4/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  cell 视频模块

#import "XWDiscoverCellBaseModule.h"

@interface XWDiscoverCellVideoModule : XWDiscoverCellBaseModule

/**
 *  点击播放方法
 */
@property (nonatomic, copy) XWDiscoverTapBlock playVideoClock;
/**
 *  初始化
 */
-(instancetype)initWithWidth:(CGFloat)width;
/**
 *  模块赋值
 */
-(void)setDataWithModel:(XWDiscoverVideoModel *)model;
@end
