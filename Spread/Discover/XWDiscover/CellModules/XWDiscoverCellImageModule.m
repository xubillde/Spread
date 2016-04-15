//
//  XWDiscoverCellImageModule.m
//  Spread
//
//  Created by 邱学伟 on 16/4/7.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWDiscoverCellImageModule.h"

@interface XWDiscoverCellImageModule (){
    //模块内所有图片数量
    NSUInteger maxCount;
    //所有图片视图对象数组
    NSMutableArray *imageViews;
    //宽度
    CGFloat width;
    //图片数据模型
    XWDiscoverImageModel *dataSource_ImageModel;
}
@end

@implementation XWDiscoverCellImageModule

#pragma mark - init

-(instancetype)initWithWidth:(CGFloat)widthTemp maxImageViewCount:(NSUInteger)maxCountTemp{
    self = [super init];
    
    if (self) {
        width = widthTemp;
        maxCount = maxCountTemp;
        imageViews = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < maxCount; i++) {
            //每个ImagView
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            //剪裁
            [imageView setClipsToBounds:YES];
            //圆角设置,并滚动流畅 栅格化：把一固定的矢量图形或者输入文本转化为位图。
            [imageView.layer setShouldRasterize:YES];
            [imageView.layer setRasterizationScale:[UIScreen mainScreen].scale];
            [imageViews addObject:imageView];
            
            //图片点击事件
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tapGestureRecognizer];
            [imageView setUserInteractionEnabled:YES];
            [self addSubview:imageView];
        }
        
        _imageSpacing = CGSizeMake(4, 4);
        CGFloat imageWidth = (widthTemp - 24 - _imageSpacing.width*2) / 3.0f;
        _imageSize = CGSizeMake(imageWidth, imageWidth);
    }
    
    return self;
}

#pragma mark - 事件
-(void)tapImageView:(UITapGestureRecognizer *)tapGestureRecognizer{
    NSLog(@"XWDiscoverCellImageModule -> tap点击");
    UIImageView *imageView = (UIImageView *)tapGestureRecognizer.view;
    NSUInteger index = [imageViews indexOfObject:imageView];
    self.tapImageBlock(self,imageView,index);
}

#pragma mark - 样式方法
-(void)putImageView{
    //只有一张图片
    if (dataSource_ImageModel.imageUrlArr.count == 1) {
        [imageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           UIView *currentView = obj;
            if (idx == 0) {
                NSString *firstSizeStr = [dataSource_ImageModel.sizeArr firstObject];
                NSArray *firstSize = [firstSizeStr componentsSeparatedByString:@"x"];
                CGFloat imageWidth = [[firstSize firstObject] floatValue];
                CGFloat imageHeight = [[firstSize lastObject] floatValue];
                //距离屏幕左右间距各12
                CGFloat realShowWidth = width - 24;
                //实际展示宽高比例和图片宽高比例相同进而求出图片模块实际高度 a/b = A/B
                CGFloat realShowHeight = imageHeight * realShowWidth / imageWidth;
                if (realShowHeight > realShowWidth) {
                    
                    //
                    realShowHeight = realShowWidth;
                    realShowWidth = imageWidth * realShowWidth / imageHeight;
                    
                    //isnan(x)可以判断是否不是一个数字
                    if (isnan(realShowWidth)) {
                        realShowWidth = 0.0f;
                    }
                    //isinf(x)可以判断是否是无穷大
                    if (isinf(realShowWidth)) {
                        realShowWidth = 0.0f;
                    }
                    if(isnan(realShowHeight)) {
                        realShowHeight=0.0f;
                    }
                    if (isinf(realShowHeight)) {
                        realShowHeight=0.0f;
                    }
                    [currentView setFrame:CGRectMake(12, 0, realShowWidth, realShowHeight)];
                }else{
                    if(isnan(realShowWidth)) {
                        realShowWidth=0.0f;
                    }
                    if (isinf(realShowWidth)) {
                        realShowWidth=0.0f;
                    }
                    if(isnan(realShowHeight)) {
                        realShowHeight=0.0f;
                    }
                    if (isinf(realShowHeight)) {
                        realShowHeight=0.0f;
                    }
                    [currentView setFrame:CGRectMake(12, 0, realShowWidth, realShowHeight)];
                }
            }
        }];
    }else{
        //每张图片的初始坐标->
        __block CGPoint nextImageOrigin = CGPointMake(12, 0);
        [imageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *currentView = obj;
            [currentView setFrame:CGRectMake(nextImageOrigin.x, nextImageOrigin.y, _imageSize.width, _imageSize.height)];
            if (CGRectGetMaxX(currentView.frame) + _imageSpacing.width + _imageSize.width <= width) {
                //如果本行还能显示
                nextImageOrigin.x += _imageSpacing.width + _imageSize.width;
            }else{
                //换行显示
                nextImageOrigin.x = 12;
                nextImageOrigin.y += _imageSpacing.height + _imageSize.height;
                
            }
        }];
    }
}

#pragma mark - setter

-(void)setImageSize:(CGSize)imageSize{
    _imageSize = imageSize;
}
-(void)setImageSpacing:(CGSize)imageSpacing{
    _imageSpacing = imageSpacing;
}
-(void)setDataWithModel:(XWDiscoverImageModel *)imageModel{
    dataSource_ImageModel = imageModel;
    [self refreshViewData];
}

#pragma mark - getter

-(CGFloat)height{
    //没图片
    if (dataSource_ImageModel.imageUrlArr.count == 0) {
        return 0;
    }else if (dataSource_ImageModel.imageUrlArr.count == 1){
        //1图片
        NSString *firstSizeStr = [dataSource_ImageModel.sizeArr firstObject];
        NSArray *firstSize = [firstSizeStr componentsSeparatedByString:@"x"];
        CGFloat imageWidth = [[firstSize firstObject] floatValue];
        CGFloat imageHeight = [[firstSize lastObject] floatValue];
        CGFloat showWidth = width - 24;//左右间距各12
        //实际展示宽高比例和图片宽高比例相同进而求出图片模块实际高度 a/b = A/B
        CGFloat showHeight = imageHeight * showWidth / imageWidth;
        if (showHeight > showWidth) {
            //若高度大于宽度,使宽高相等
            showHeight = showWidth;
        }
        //isnan(x)可以判断是否不是一个数字
        if (isnan(showHeight)) {
            showHeight = 0.0;
        }
        if (isinf(showHeight)) {
            showHeight = 0.0;
        }
        return showHeight;
    }else{
        //多张图片
        UIView *lastView = [imageViews objectAtIndex:dataSource_ImageModel.imageUrlArr.count - 1];
        CGFloat totalHeight = CGRectGetMaxY(lastView.frame);
        //返回的是大于或等于函数参数,并且与之最接近的整数。
        return ceil(totalHeight);
    }
}

-(UIImageView *)imageViewWithIndex:(NSInteger)index{
    UIImageView *imageView = [imageViews objectAtIndex:index];
    return imageView;
}

//根据传入cell模块计算高度->
+(CGFloat)countHeightWithModel:(XWDiscoverModel *)model width:(CGFloat)width{
    if (model.imageModel.imageUrlArr.count == 0) {
        return 0;
    }else if (model.imageModel.imageUrlArr.count == 1){
        NSString *firstSizeStr = [model.imageModel.sizeArr firstObject];
        NSArray *firstSize = [firstSizeStr componentsSeparatedByString:@"x"];
        CGFloat imageWidth = [[firstSize firstObject] floatValue];
        CGFloat imageHeight = [[firstSize lastObject] floatValue];
        CGFloat showWidth = width - 24;//左右间距各12
        CGFloat showHeight = imageHeight * showWidth / imageWidth;
        if (showHeight > showWidth) {
            showHeight = showWidth;
        }
        if(isnan(showHeight)) {
            showHeight=0.0f;
        }
        if (isinf(showHeight)) {
            showHeight=0.0f;
        }
        return showHeight;
    }else{
        CGSize imageSpacing = CGSizeMake(4, 4);
        CGFloat imageWidth = (width - 24 - imageSpacing.width * 2) / 3.0f;
        CGSize imageSize = CGSizeMake(imageWidth, imageWidth);
        __block CGPoint nextImageOrigin = CGPointMake(12, 0);
        __block CGRect nextRect;
        __block CGFloat maxHeight = 0;
        
        [model.imageModel.imageUrlArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            nextRect = CGRectMake(nextImageOrigin.x, nextImageOrigin.y, imageSize.width, imageSize.height);
            if (CGRectGetMaxX(nextRect) + imageSpacing.width + imageSize.width <= width) {
                //如果本行还能显示
                nextImageOrigin.x += imageSpacing.width + imageSize.width;
            }else {
                //换行显示
                nextImageOrigin.x = 12;
                nextImageOrigin.y += imageSpacing.height + imageSize.height;
            }
            maxHeight = CGRectGetMaxY(nextRect);
        }];
        return ceil(maxHeight);
    }
}

-(void)refreshViewData{
    if (dataSource_ImageModel) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }
    
    __weak __typeof (& *self) weakSelf = self;
    [imageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *currentView = obj;
        
        if (idx < [dataSource_ImageModel.imageUrlArr count]) {
            currentView.hidden = NO;
            NSString *imageUrl;
            
            imageUrl = [dataSource_ImageModel.imageUrlArr objectAtIndex:idx];
            
            weakSelf.loadImageBlock(currentView, imageUrl, load_default_image);
        }else{
            currentView.hidden = YES;
        }
    }];
    [self putImageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
