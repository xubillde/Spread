//
//  XWDiscoverCellBaseModule.h
//  Spread
//
//  Created by 邱学伟 on 16/4/7.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  cell 的基础模块

#import <UIKit/UIKit.h>
#import "XWDiscoverModel.h"

//默认头像占位
#define load_default_head @"load_default_head"
//默认图片占位
#define load_default_image @"load_default_image"
//
#define ColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface XWDiscoverCellBaseModule : UIView

/** 定义图片下载block */
typedef void(^XWDiscoverBeLoadImageBlock) (UIImageView *beLoadIamgeView, NSString *beLoadIamgeUrlStr, NSString *placeholderImageName);

/** 点击方法Block */
typedef void(^XWDiscoverTapBlock) ();

/** 模块高度 */
@property (nonatomic, assign, readonly) CGFloat height;

/** 加载图片的block */
@property (nonatomic, copy) XWDiscoverBeLoadImageBlock  loadImageBlock;

/** 获取当前模块高度 */
+(CGFloat)countHeightWithModel:(XWDiscoverModel *)model width:(CGFloat)width;

@end
