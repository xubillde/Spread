//
//  XWRadarIndicatorView.m
//  Spread
//
//  Created by qiuxuewei on 16/3/23.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWRadarIndicatorView.h"

@implementation XWRadarIndicatorView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
    //画布上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画扇形->
    
    UIColor *aColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    //填充颜色
    CGContextSetFillColorWithColor(context, aColor.CGColor);
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);
    //显得宽度
    CGContextSetLineWidth(context, 1);
    //以self.radius为半径,围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, self.center.x, self.center.y);
    //
    CGContextAddArc(context, self.center.x, self.center.y, self.radius, 180, -90 * M_PI / 180, 0);
    CGContextClosePath(context);
    //回执路径
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //多个小扇形构造渐变的大扇形  直角扇形
    for (int i = 0; i<=90; i++) {
        //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
        UIColor *aColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:i/500.0f];
        CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
        CGContextSetLineWidth(context, 0);//线的宽度
        //以self.radius为半径围绕圆心画指定角度扇形
        CGContextMoveToPoint(context, self.center.x, self.center.y);
        CGContextAddArc(context, self.center.x, self.center.y, self.radius,  (-180 + i) * M_PI / 180, (-180 + i - 1) * M_PI / 180, 1);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    }
}

@end
