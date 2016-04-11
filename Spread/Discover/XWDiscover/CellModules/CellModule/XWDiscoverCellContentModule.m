//
//  XWDiscoverCellContentModule.m
//  Spread
//
//  Created by 邱学伟 on 16/4/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  Cell文字主体内容模块

#import "XWDiscoverCellContentModule.h"

@interface XWDiscoverCellContentModule (){
    //内容label
    UILabel *contentLB;
    //
    UILabel *showMoreLB;
    CGFloat width;
    //数据模型
    XWDiscoverContentModel *dataSourceModel;
}

@end

@implementation XWDiscoverCellContentModule

#pragma mark - 初始化
-(instancetype)initWithWidth:(CGFloat)widthTemp{
    self = [super init];
    if (self) {
        width = widthTemp;
        /**
         *  内容label
         */
        contentLB = [[UILabel alloc] init];
        [contentLB setFrame:CGRectMake(15, 0, width - 30, 116.94921875)];
        [contentLB setBackgroundColor:[UIColor clearColor]];
        [contentLB setTextColor:ColorFromRGBA(0x4e5257, 1)];
        [contentLB setFont:[UIFont systemFontOfSize:14.0f]];
        [contentLB setNumberOfLines:0];
        [self addSubview:contentLB];
    }
    return self;
}

#pragma mark - setter
-(void)setDataWithModel:(XWDiscoverContentModel *)model{
    dataSourceModel = model;
    [self refreshViewData];
}

#pragma mark - 刷新模块数据
-(void)refreshViewData{
    NSDictionary *attributes = @{
                                 NSFontAttributeName:contentLB.font
                                 };
    CGRect rect = [dataSourceModel.content boundingRectWithSize:CGSizeMake(width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    CGFloat totalHeight = rect.size.height;
    [contentLB setFrame:CGRectMake(CGRectGetMinX(contentLB.frame), CGRectGetMinY(contentLB.frame), CGRectGetWidth(contentLB.frame), totalHeight)];
    [contentLB setText:dataSourceModel.content];
}

#pragma mark - getter
/**
 *  总高度
 */
-(CGFloat)height{
    NSDictionary *attributes = @{
                                 NSFontAttributeName:contentLB.font
                                 };
    CGRect rect = [dataSourceModel.content boundingRectWithSize:CGSizeMake(width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    CGFloat totalHeight = rect.size.height;
    //设计文本距离下边距为10像素
    totalHeight += 10;
    return totalHeight;
}

+(CGFloat)countHeightWithModel:(XWDiscoverModel *)model width:(CGFloat)width{
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f]
                                 };
    CGRect rect = [model.contentModel.content boundingRectWithSize:CGSizeMake(width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    CGFloat totalHeight = rect.size.height;
    return totalHeight;
}

@end
