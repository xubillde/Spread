//
//  CustomTabBar.m
//  Spread
//
//  Created by qiuxuewei on 16/3/21.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "CustomTabBar.h"

//发布按钮
#import "CustomTabBarButton.h"

#define kButtonNumber 5

@interface CustomTabBar ()
/** 发布按钮 */
@property (nonatomic, strong) CustomTabBarButton *pulishButton;

@end

@implementation CustomTabBar
//初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];

    if (self) {
        CustomTabBarButton *publishBtn = [CustomTabBarButton shareCustomTabBarButton];
        [self addSubview:publishBtn];
        self.pulishButton = publishBtn;
    }
    return self;
}
//布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    
    CGFloat buttonW = barWidth / kButtonNumber;
    CGFloat buttonH = barHeight - 2;
    CGFloat buttonY = 1;
    
    NSInteger buttonIndex = 0;
    
    self.pulishButton.center = CGPointMake(barWidth * 0.5, barHeight * 0.3);
    
    for (UIView *view in self.subviews) {
        
        NSString *viewClass = NSStringFromClass([view class]);
        NSLog(@"NSStringFromClass([view class]) -> %@",viewClass);
        
        if ([viewClass isEqualToString:@"UITabBarButton"]){
            
            CGFloat buttonX = buttonIndex * buttonW;
            
            //右边两个按钮
            if (buttonIndex >= 2) {
                buttonX += buttonW;
            }
            [view setFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
            buttonIndex++;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
