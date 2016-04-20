//
//  CustomTabBarButton.m
//  Spread
//
//  Created by qiuxuewei on 16/3/21.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "CustomTabBarButton.h"
#import "XWMenuPopView.h"
#import "AppDelegate.h"
#import "CustomTabBarController.h"


@interface CustomTabBarButton ()

@end

@implementation CustomTabBarButton
//上下结构的 button
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 控件大小,间距大小
    CGFloat const imageViewEdge   = self.bounds.size.width * 0.6;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdge;
    CGFloat const verticalMargin  = verticalMarginT * 0.5;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerY_OfImageView  = verticalMargin + imageViewEdge * 0.5;
    CGFloat const centerY_OfTitleLabel = imageViewEdge  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdge, imageViewEdge);
    self.imageView.center = CGPointMake(centerOfView, centerY_OfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerY_OfTitleLabel);
    
}


//初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //取消点击效果
        [self setAdjustsImageWhenDisabled:NO];
    }
    return self;
}

//初始化方法
+(instancetype)shareCustomTabBarButton{
    CustomTabBarButton *button = [[CustomTabBarButton alloc] init];
    [button setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    //可以自定义
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:8.0];
    //UIButton大小能够自适应titlelabel内的字体或图片
    [button sizeToFit];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
//点击方法
-(void)clickPublish{
    NSLog(@"点击方法");
    
    //展示弹出菜单->
    CustomTabBarController *tabBarController = (CustomTabBarController *)self.window.rootViewController;
    XWMenuPopView *showMenuPopView = tabBarController.menuPopView;
    [tabBarController.view bringSubviewToFront:showMenuPopView];
    [showMenuPopView showMenu];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
