//
//  XWDiscoverCellVideoModule.m
//  Spread
//
//  Created by 邱学伟 on 16/4/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWDiscoverCellVideoModule.h"

@interface XWDiscoverCellVideoModule (){
    //视频缩略图
    UIImageView *thumImageView;
    //数据
    XWDiscoverVideoModel *dataSourceModel;
    //类内参数
    CGFloat width;
    //播放图标
    UILabel *playIconLB;
}

@end

@implementation XWDiscoverCellVideoModule
#pragma mark - init

-(instancetype)initWithWidth:(CGFloat)widthTemp{
    self = [super init];
    if (self) {
        width = widthTemp;
        
        thumImageView = [[UIImageView alloc] init];
        [thumImageView setBackgroundColor:[UIColor clearColor]];
        [thumImageView setContentMode:UIViewContentModeScaleAspectFill];
        [thumImageView setClipsToBounds:YES];
        //layer被渲染成一个bitmap，并缓存起来，等下次使用时不会再重新去渲染了。
        [thumImageView.layer setShouldRasterize:YES];
        [thumImageView.layer setRasterizationScale:[UIScreen mainScreen].scale];
        
        [thumImageView setUserInteractionEnabled:YES];
        [self addSubview:thumImageView];
        
        playIconLB = [[UILabel alloc] init];
        [playIconLB setBackgroundColor:[UIColor clearColor]];
        [playIconLB setUserInteractionEnabled:YES];
        [playIconLB setFont:[UIFont fontWithName:@"icomoon" size:35.0f]];
        [playIconLB setTextAlignment:NSTextAlignmentCenter];
        [playIconLB setTextColor:[UIColor whiteColor]];
        [playIconLB setText:@"\U0000E650"];
        [thumImageView addSubview:playIconLB];
        
        /**
         *  点击播放
         */
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayVideo:)];
        [thumImageView addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}
#pragma mark - 点击播放->
-(void)tapPlayVideo:(UITapGestureRecognizer *)tapGestureReconizer{
    NSLog(@"点击播放block _->传递");
    self.playVideoClock();
}
#pragma mark - setter
-(void)setDataWithModel:(XWDiscoverVideoModel *)model{
    dataSourceModel = model;
    [self refreshViewData];
}
#pragma mark - getter
-(CGFloat)height{
    //左右间距12
    CGFloat showWidth = width - 24;
    CGFloat showHeight = dataSourceModel.height * showWidth / dataSourceModel.width;
    if (showHeight > showWidth) {
        showHeight = showWidth;
    }
    if(isnan(showWidth)) {
        showWidth=0.0f;
    }
    if (isinf(showWidth)) {
        showWidth=0.0f;
    }
    if(isnan(showHeight)) {
        showHeight=0.0f;
    }
    if (isinf(showHeight)) {
        showHeight=0.0f;
    }
    return showHeight;
}

+ (CGFloat)countHeightWithModel:(XWDiscoverModel *)model width:(CGFloat)width{
    CGFloat showWidth = width - 24;//左右间距各12
    CGFloat showHeight = model.videoModel.height * showWidth / model.videoModel.width;
    if (showHeight > showWidth) {
        showHeight = showWidth;
    }
    if(isnan(showWidth)) {
        showWidth=0.0f;
    }
    if (isinf(showWidth)) {
        showWidth=0.0f;
    }
    if(isnan(showHeight)) {
        showHeight=0.0f;
    }
    if (isinf(showHeight)) {
        showHeight=0.0f;
    }
    return showHeight;
}
#pragma mark - 设置数据
-(void)refreshViewData{
    if (dataSourceModel) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }
    
    //设置缩略图
    self.loadImageBlock(thumImageView, dataSourceModel.thumImageUrlStr, load_default_image);
    [self putImageView];
}
#pragma mark - 样式方法
//设置缩略图实际尺寸
-(void)putImageView{
    //左右间距12
    CGFloat showWidth = width - 24;
    CGFloat showHeight = dataSourceModel.height * showWidth / dataSourceModel.width;
    if (showHeight > showWidth) {
        showHeight = showWidth;
        showWidth = dataSourceModel.width * showWidth / dataSourceModel.height;
    }
    if(isnan(showWidth)) {
        showWidth=0.0f;
    }
    if (isinf(showWidth)) {
        showWidth=0.0f;
    }
    if(isnan(showHeight)) {
        showHeight=0.0f;
    }
    if (isinf(showHeight)) {
        showHeight=0.0f;
    }
    [thumImageView setFrame:CGRectMake(12, 0, showWidth, showHeight)];
    [playIconLB setFrame:CGRectMake((CGRectGetWidth(thumImageView.frame) - 40) * 0.5, (CGRectGetHeight(thumImageView.frame) - 40) * 0.5, 40, 40)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
