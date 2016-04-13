//
//  XWDiscoverBaseCell.h
//  Spread
//
//  Created by 邱学伟 on 16/4/6.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  基础tableviewCell样式

#import <UIKit/UIKit.h>
#import "XWDiscoverModel.h"
#import "XWDiscoverCellBaseModule.h"
#import "XWDiscoverCellImageModule.h"

@class XWDiscoverBaseCell;


/** 数据源协议 */
@protocol XWDiscoverTableViewCellDataSource <NSObject>

@required
/** 顶部数据 */
-(XWDiscoverTitleModel *)titleDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableviewCell indexPath:(NSIndexPath *)indexPath;

/** 内容数据 */
-(XWDiscoverContentModel *)contentDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableViewCell indexPath:(NSIndexPath *)indexPath;

/** 图片数据 */
-(XWDiscoverImageModel *)imageDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableVeiwCell indexPath:(NSIndexPath *)indexPath;

/** 分享数据 */
-(XWDiscoverShareModel *)shareDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableVeiwCell indexPath:(NSIndexPath *)indexPath;

/** 视频数据 */
-(XWDiscoverVideoModel *)videoDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableVeiwCell indexPath:(NSIndexPath *)indexPath;

/** 点赞评论数据 */
-(XWDiscoverCommentsModel *)commentsDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableVeiwCell indexPath:(NSIndexPath *)indexPath;
@end

/** 代理 */
@protocol XWDiscoverTableViewCellDelegate <NSObject>

@optional
/**
 *  点击操作加载图片
 */
-(void)groupTableViewCell:(XWDiscoverBaseCell *)tableViewCell loadIamgeView:(UIImageView *)imageView imageUrl:(NSString *)imageUrl placeholderImageName:(NSString *)placeholderImageName;
/**
 *
 */
-(void)groupTableViewCellTapImageWall:(XWDiscoverBaseCell *)tableViewCell imageWall:(XWDiscoverCellImageModule *)imageWall imageView:(UIImageView *)imageView index:(NSUInteger)index;
/**
 *  点击头像加载操作
 */
-(void)groupTableViewCellTapUserHead:(XWDiscoverBaseCell *)tableViewCell;
/**
 *  点赞操作
 */
-(void)groupTableViewCellTapPraiseButton:(XWDiscoverBaseCell *)tableViewCell;
/**
 *  评论操作
 */
-(void)groupTableViewCellTapCommentButton:(XWDiscoverBaseCell *)tableViewCell;
/**
 *  点击分享操作
 */
-(void)groupTableViewCellTapShareContent:(XWDiscoverBaseCell *)tableViewCell;
/**
 *  点击视频播放操作
 */
-(void)groupTableViewCellTapVideoPlay:(XWDiscoverBaseCell *)tableViewCell;


@end


@interface XWDiscoverBaseCell : UITableViewCell

/** 模块数组 */
@property (nonatomic, strong) NSArray *modules;

/** 当前indexpath */
@property (nonatomic, strong) NSIndexPath *indexPath;

/** 数据源 */
@property (nonatomic, weak) id<XWDiscoverTableViewCellDataSource> dataSource;

/** 代理方法 */
@property (nonatomic, weak) id<XWDiscoverTableViewCellDelegate> delegate;

/** 创建cell */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width;

/** 加载数据 */
-(void)loadDataSourceWithIndexPath:(NSIndexPath *)indexPath;

/** 计算对应内容显示的高度 */
+(CGFloat)countHeightWithGroupCellModel:(XWDiscoverModel *)model width:(CGFloat)width;

-(XWDiscoverModel *)getCurrentModel;
@end
