//
//  JokeImageData.h
//  OneHelper
//
//  Created by qiuxuewei on 16/3/13.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokeImageData : NSObject

/**
 
 data =         (
 {
 content = "凤仙花";
 hashId = 045353932C0FF36B1831DB2E318E8B53;
 unixtime = 1457688795;
 updatetime = "2016-03-11 17:33:15";
 url = "http://juheimg.oss-cn-hangzhou.aliyuncs.com/joke/201603/11/045353932C0FF36B1831DB2E318E8B53.gif";
 })
 
 */
/** 标题 */
@property (nonatomic, copy) NSString *content;

/** 图片链接 */
@property (nonatomic, copy) NSString *url;

/** 图片文件名 */
@property (nonatomic, copy) NSString *hashId;

/** 更新时间 "2016-03-11 17:33:15"*/
@property (nonatomic, copy) NSString *updatetime;

@end
