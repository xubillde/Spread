//
//  OneNewImage.h
//  OneHelper
//
//  Created by qiuxuewei on 16/3/4.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneNewImage : NSObject

/** 路径 */
@property (nonatomic, copy) NSString *url;

/** 宽度 */
@property (nonatomic, copy) NSString *width;

/** 高度 */
@property (nonatomic, copy) NSString *height;

/**
 height = 263;
 url = "http://www.chinanews.com/ga/2016/03-04/U600P4T8D7783973F107DT20160304132937.jpg";
 width = 500;
 */

@end
