//
//  XWDiscoverCellContentModule.h
//  Spread
//
//  Created by 邱学伟 on 16/4/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  Cell文字主体内容模块

#import "XWDiscoverCellBaseModule.h"

@interface XWDiscoverCellContentModule : XWDiscoverCellBaseModule

/**
 *  初始化
 */
-(instancetype)initWithWidth:(CGFloat)widthTemp;

/**
 *  为模块设置数据
 */
-(void)setDataWithModel:(XWDiscoverContentModel *)model;

@end
