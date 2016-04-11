//
//  XWDiscoverModel.h
//  Spread
//
//  Created by 邱学伟 on 16/4/6.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  cell 每条数据的模型

#import <Foundation/Foundation.h>

@class XWDiscoverTitleModel,XWDiscoverContentModel,XWDiscoverImageModel,XWDiscoverShareModel,XWDiscoverVideoModel,XWDiscoverCommentsModel;

@interface XWDiscoverModel : NSObject

//每条数据会有这几个模块或这几个模块其中几块

/** 标题模块 */
@property (nonatomic, strong) XWDiscoverTitleModel *titleModel;

/** 文本主体模块 */
@property (nonatomic, strong) XWDiscoverContentModel *contentModel;

/** 点赞评论模块 */
@property (nonatomic, strong)  XWDiscoverCommentsModel *commentsModel;

//***************************** 以上必备,以下三选一 ***********************

/** 图片模块 */
@property (nonatomic, strong) XWDiscoverImageModel *imageModel;

/** 分享模块 */
@property (nonatomic, strong) XWDiscoverShareModel *shareModel;

/** 视频模块 */
@property (nonatomic, strong) XWDiscoverVideoModel *videoModel;



+(XWDiscoverModel *)getModel;
+ (XWDiscoverModel *)getTestModel;

@end

#pragma mark - 标题模块

@interface XWDiscoverTitleModel : NSObject

/** 头像URL */
@property (nonatomic, copy) NSString *headIocnUrlStr;

/** 用户名 */
@property (nonatomic, copy) NSString *userName;

/** 发布时间 */
@property (nonatomic, copy) NSString *time;

+ (XWDiscoverTitleModel *)getTitleModelWithHeadIocnUrlStr:(NSString *)headIocnUrlStr withUserName:(NSString *)userName withTime:(NSString *)time;
+ (XWDiscoverTitleModel *)getTestModel;

@end

#pragma mark - 文本主体模块

@interface XWDiscoverContentModel : NSObject

/** 文本主体内容 */
@property (nonatomic, copy) NSString *content;

+ (XWDiscoverContentModel *)getContentModelWithContent:(NSString *)content;
+ (XWDiscoverContentModel *)getTestModel;

@end

#pragma mark - 图片模块

@interface XWDiscoverImageModel : NSObject

/** 图片URL数组 */
@property (nonatomic, strong) NSArray *imageUrlArr;

/** 宽和高的数组 例如:123x456 */
@property (nonatomic, strong) NSArray *sizeArr;

+ (XWDiscoverImageModel *)getImageModelWithImageUrlArr:(NSArray *)imageUrlArr withSizeArr:(NSArray *)sizeArr;
+ (XWDiscoverImageModel *)getTestModel;

@end

#pragma mark - 分享模块

@interface XWDiscoverShareModel : NSObject

/** 缩略图URL */
@property (nonatomic, copy) NSString *thumImageUrlStr;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 简介 */
@property (nonatomic, copy) NSString *summary;

/** 点击后跳转的地址 */
@property (nonatomic, copy) NSString *urlStr;

+ (XWDiscoverShareModel *)getShreModelWithThumImageUrlStr:(NSString *)thumImageUrlStr withTitle:(NSString *)title withSummary:(NSString *)summary withUrlStr:(NSString *)urlStr;
+ (XWDiscoverShareModel *)getTestModel;
@end

#pragma mark - 视频模块

@interface XWDiscoverVideoModel : NSObject

/** 视频名字 */
@property (nonatomic, copy) NSString *name;

/** 视频持续时间 */
@property (nonatomic, copy) NSString *duration;

/** 缩略图Url */
@property (nonatomic, copy) NSString *thumImageUrlStr;

/** 视频路径 */
@property (nonatomic, copy) NSString *videoUrlStr;

/** 视频宽 */
@property (nonatomic, assign) NSInteger width;

/** 视频高 */
@property (nonatomic, assign) NSInteger height;

+(XWDiscoverVideoModel *)getVideoModelWithName:(NSString *)name withDuration:(NSString *)duration withThumImageUrlStr:(NSString *)thumImageUrlStr withVideoUrlStr:(NSString *)videoUrlStr withWidth:(NSInteger)width withHeight:(NSInteger)height;
+ (XWDiscoverVideoModel *)getTestModel;

@end

#pragma mark - 评论点赞模块

@interface XWDiscoverCommentsModel : NSObject

/** 我是否赞了该话题 */
@property (nonatomic, assign) BOOL isPraised;

/** 点赞总数 */
@property (nonatomic, assign) NSInteger praisedCount;

/** 评论总数 */
@property (nonatomic, assign) NSInteger commentCount;

/** 我是否评论了该话题 */
@property (nonatomic, assign) BOOL isCommented;

+(XWDiscoverCommentsModel *)getCommentModelWithIsPraised:(BOOL)isPraised withPraisedCount:(NSInteger)praisedCount withCommentCount:(NSInteger)commentCount withIsCommented:(BOOL)isCommented;
+ (XWDiscoverCommentsModel *)getTestModel;

@end

