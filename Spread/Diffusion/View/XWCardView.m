//
//  XWCardView.m
//  Spread
//
//  Created by qiuxuewei on 16/3/22.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWCardView.h"

@implementation XWCardView

//初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUpSelfView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSelfView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpSelfView];
    }
    return self;
}

//设置圆角视图样式
-(void)setUpSelfView{
    //阴影 Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor; //黑
    self.layer.shadowOpacity = 0.33;//阴影的不透明度
    self.layer.shadowOffset = CGSizeMake(0, 1.5);//阴影的偏移
    self.layer.shadowRadius = 4.0;//阴影半径
    self.layer.shouldRasterize = YES; //圆角缓存
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;//提高流畅度
    //圆角
    self.layer.cornerRadius = 10.0f;
}

@end
