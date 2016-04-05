//
//  OneNew.h
//  OneHelper
//
//  Created by qiuxuewei on 16/3/4.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneNew : NSObject

/** 新闻类目 */
@property (nonatomic, copy) NSString *channelName;

/** 简要描述 */
@property (nonatomic, copy) NSString *desc;

/** 图片链接数组 存放的OneNewImage对象 */
@property (nonatomic, strong) NSArray *imageurls;

/** 新闻链接 */
@property (nonatomic, copy) NSString *link;

/** 时间 2016-03-04 15:06:46 */
@property (nonatomic, copy) NSString *pubDate;

/** 来源 */
@property (nonatomic, copy) NSString *source;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/**
 {
 "channelId": "5572a109b3cdc86cf39001de",
 "channelName": "国际最新",
 "comment": {
 "count": 0
 },
 "desc": "日本京都，日本大学生组织大规模游行，抗议安倍政府推行的充满争议的安全法案。",
 "imageurls": [
 {
 "height": 119,
 "url": "http://himg2.huanqiu.com/attachment2010/2015/0706/20150706030553113.jpg",
 "width": 169
 }
 ],
 "link": "http://oversea.huanqiu.com/article/2015-07/6861523.html",
 "nid": "4720054935067409143",
 "pubDate": "2015-07-06 16:11:47",
 "source": "环球网",
 "title": "美媒：安倍“不再战”誓言几分真？须拭目观其行"
 },
 */

@end
