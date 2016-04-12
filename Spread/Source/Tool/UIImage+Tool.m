//
//  UIImage+Tool.m
//  OneHelper
//
//  Created by qiuxuewei on 16/1/30.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

//UIColor -> UIImage
+(instancetype)createImageWithColor: (UIColor*)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
