//
//  XWAnnotationView.h
//  Spread
//
//  Created by 邱学伟 on 16/3/25.
//  Copyright © 2016年 邱学伟. All rights reserved.
// 自定义地图标注

#import <MAMapKit/MAMapKit.h>

@interface XWAnnotationView : MAAnnotationView

/** 标注图片 */
@property (nonatomic, strong) UIImage *annoImage;

/** 标注文字 */
@property (nonatomic, copy) NSString *annoStr;

/** 背景图片 */
@property (nonatomic, strong) UIImageView *backgroundImageView;


@end
