//
//  XWAnnotationView.m
//  Spread
//
//  Created by 邱学伟 on 16/3/25.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWAnnotationView.h"

@interface XWAnnotationView (){
    //背景视图
    UIImageView *_backgroundImgView;
    //头像图片视图
    UIImageView *_iconImageView;
    //文本Label
    UILabel *_titleLabel;
}


@end

@implementation XWAnnotationView
-(instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        //背景视图
        _backgroundImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        CGFloat width = 50;
        CGFloat height = 50;
        [_backgroundImgView setFrame:CGRectMake(_backgroundImgView.frame.origin.x - 25, _backgroundImgView.frame.origin.y - 25, width, height)];
        [_backgroundImgView setImage:[UIImage imageNamed:@"Speach"]];
        [self addSubview:_backgroundImgView];
        
        //头像视图
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_backgroundImgView.frame.origin.x + 2, _backgroundImgView.frame.origin.y + 4, _backgroundImgView.frame.size.width - 4, _backgroundImgView.frame.size.height - 18.5)];
        if (_annoImage) {
            [_iconImageView setImage:_annoImage];

        }else{
//            [_iconImageView setImage:[UIImage imageNamed:@"baby"]];
        }
        [self addSubview:_iconImageView];
//        [_iconImageView setBackgroundColor:colorWithRGBA(156, 98, 211, 0.6)];
    }
    return self;
}
//创建子视图
- (void)_createSubviews{
    _backgroundImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _backgroundImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_backgroundImgView];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor brownColor];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [_backgroundImgView addSubview:_titleLabel];
}
#pragma mark -SET
-(void)setAnnoImage:(UIImage *)annoImage{
    if (_annoImage != annoImage) {
        _annoImage = annoImage;
        [_iconImageView setImage:_annoImage];
    }
}
//-(void)setImg:(UIImage *)img{
//    if (_img != img) {
//        _img = img;
//        CGFloat width = img.size.width / 2.0;
//        CGFloat height = img.size.height / 2.0;
//        _backgroundImgView.width = width;
//        _backgroundImgView.height = height;
//        _backgroundImgView.image = img;
//        
//        _titleLabel.frame = CGRectMake(30, 20, width - 40, height - 40);
//    }
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
