//
//  XWDiscoverCellImageModule.h
//  Spread
//
//  Created by 邱学伟 on 16/4/7.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  图片模块

#import "XWDiscoverCellBaseModule.h"

@interface XWDiscoverCellImageModule : XWDiscoverCellBaseModule

/** 定义点击图片block */
typedef void(^XWDiscoverTapImageBlock) (XWDiscoverCellImageModule *tapIamgeModule, UIImageView *tapIamgeView, NSUInteger index);

/** 定义点击图片block */
@property (nonatomic, copy) XWDiscoverTapImageBlock tapImageBlock;

/** imageView显示的尺寸 */
@property (nonatomic, assign) CGSize imageSize;

/** 定义内相邻图片间距 */
@property (nonatomic, assign) CGSize imageSpacing;

/** 初始化 */
-(instancetype)initWithWidth:(CGFloat)widthTemp maxImageViewCount:(NSUInteger)maxCountTemp;

/** 传入数据模型初始化图片模块 */
-(void)setDataWithModel:(XWDiscoverImageModel *)imageModel;

/** 获取图像 */
-(UIImageView *)imageViewWithIndex:(NSInteger)index;

@end
