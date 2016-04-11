//
//  XWDiscoverFullStyleCell.m
//  Spread
//
//  Created by 邱学伟 on 16/4/7.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWDiscoverFullStyleCell.h"
#import "XWDiscoverCellTitleModule.h"
#import "XWDiscoverCellContentModule.h"
#import "XWDiscoverCellImageModule.h"
#import "XWDiscoverCellVideoModule.h"
#import "XWDiscoverCellShareModule.h"
#import "XWDiscoverCellCommentModule.h"

@interface XWDiscoverFullStyleCell (){
    
    XWDiscoverCellTitleModule *titleModuleView;
    XWDiscoverCellContentModule *contentModuleView;
    XWDiscoverCellImageModule *imageModuleWall;
    XWDiscoverCellVideoModule *videoModuleView;
    XWDiscoverCellShareModule *shareModuleView;
    XWDiscoverCellCommentModule *commentModuleView;
}

@end

@implementation XWDiscoverFullStyleCell

#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initTitle:width];
        [self initContent:width];
        [self initImage:width];
        [self initVideo:width];
        [self initShare:width];
        [self initComment:width];
        
        [self setModules:[NSArray arrayWithObjects:titleModuleView,contentModuleView,imageModuleWall,videoModuleView,shareModuleView,commentModuleView, nil]];
    }
    return self;
}
/**
 *  标题模块
 */
-(void)initTitle:(CGFloat)width{
    __weak __typeof(&*self) weakSelf = self;
    titleModuleView = [[XWDiscoverCellTitleModule alloc] initWithWidth:width];
    //下载头像
    titleModuleView.loadImageBlock = ^(UIImageView *beLoadImageView, NSString *beLoadImageUrlStr, NSString *placeholderImageName){
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCell:loadIamgeView:imageUrl:placeholderImageName:)]) {
            [weakSelf.delegate groupTableViewCell:weakSelf loadIamgeView:beLoadImageView imageUrl:beLoadImageUrlStr placeholderImageName:placeholderImageName];
        }
        
    };
    
    //点击头像点击方法
    titleModuleView.tapHeadBlock = ^(){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCellTapUserHead:)]) {
            [weakSelf.delegate groupTableViewCellTapUserHead:weakSelf];
        }
    };
    
    [self.contentView addSubview:titleModuleView];
}


/**
 *  文本内容主体
 */
-(void)initContent:(CGFloat)width{
    contentModuleView = [[XWDiscoverCellContentModule alloc] initWithWidth:width];
    [self.contentView addSubview:contentModuleView];
}

/**
 *  图片模块
 */
-(void)initImage:(CGFloat)width{
    __weak __typeof(&*self) weakSelf = self;
    imageModuleWall = [[XWDiscoverCellImageModule alloc] initWithWidth:width maxImageViewCount:9];
    [imageModuleWall setImageSpacing:CGSizeMake(4, 4)];
    
    //加载图片
    imageModuleWall.loadImageBlock = ^(UIImageView *beLoadImageView, NSString *beLoadImageUrlStr, NSString *placeholderImageName){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCell:loadIamgeView:imageUrl:placeholderImageName:)]) {
            [weakSelf.delegate groupTableViewCell:weakSelf loadIamgeView:beLoadImageView imageUrl:beLoadImageUrlStr placeholderImageName:placeholderImageName];
        }
    };
    
    //点击图片方法
    imageModuleWall.tapImageBlock = ^(XWDiscoverCellImageModule *tapImageWall, UIImageView *tapImageView, NSUInteger index){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCellTapImageWall:imageWall:imageView:index:)]) {
            [weakSelf.delegate groupTableViewCellTapImageWall:weakSelf imageWall:tapImageWall imageView:tapImageView index:index];
        }
    };
    
    [self.contentView addSubview:imageModuleWall];
    
}

/**
 *  视频模块
 */
-(void)initVideo:(CGFloat)width{
    __weak __typeof(*& self) weakSelf = self;
    videoModuleView = [[XWDiscoverCellVideoModule alloc] initWithWidth:width];
    
   
    //加载缩略图
    videoModuleView.loadImageBlock = ^(UIImageView *beLoadImageView, NSString *beLoadImageUrlStr, NSString *placeholderImageName){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCell:loadIamgeView:imageUrl:placeholderImageName:)]) {
            [weakSelf.delegate groupTableViewCell:weakSelf loadIamgeView:beLoadImageView imageUrl:beLoadImageUrlStr placeholderImageName:placeholderImageName];
        }
    };
    
    //播放视频
    videoModuleView.playVideoClock = ^(){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCellTapVideoPlay:)]) {
            [weakSelf.delegate groupTableViewCellTapVideoPlay:weakSelf];
        }
    };
    
    [self.contentView addSubview:videoModuleView];
    
}

/**
 *  分享模块
 */
-(void)initShare:(CGFloat)width{
    __weak __typeof(&*self) weakSelf = self;
    
    shareModuleView = [[XWDiscoverCellShareModule alloc] initWithWidth:width];
    
    //加载预览图片
    shareModuleView.loadImageBlock = ^(UIImageView *beLoadImageView, NSString *beLoadImageUrlStr, NSString *placeholderImageName){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCell:loadIamgeView:imageUrl:placeholderImageName:)]) {
            [weakSelf.delegate groupTableViewCell:weakSelf loadIamgeView:beLoadImageView imageUrl:beLoadImageUrlStr placeholderImageName:placeholderImageName];
        }
    };
    
    //点击分享跳转
    shareModuleView.tapShareBlock = ^(){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCellTapShareContent:)]) {
            [weakSelf.delegate groupTableViewCellTapShareContent:weakSelf];
        }
    };
    
    [self.contentView addSubview:shareModuleView];
}

/**
 *  点赞评论模块
 */
-(void)initComment:(CGFloat)width{
    __weak __typeof(&*self) weakSelf = self;
    
    commentModuleView = [[XWDiscoverCellCommentModule alloc] initWithWidth:width];
    
    //点赞
    commentModuleView.tapPraiseBlock = ^(){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCellTapPraiseButton:)]) {
            [weakSelf.delegate groupTableViewCellTapPraiseButton:weakSelf];
        }
    };
    
    //评论
    commentModuleView.tapCommentBlock = ^(){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCellTapCommentButton:)]) {
            [weakSelf.delegate groupTableViewCellTapCommentButton:weakSelf];
        }
    };
    
    [self.contentView addSubview:commentModuleView];
}

#pragma mark - 数据源
/**
 *  模块赋值
 *
 *  @param indexPath <#indexPath description#>
 */
-(void)loadDataSourceWithIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    
    //标题栏
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleDataForGroupTableViewCell:indexPath:)]) {
        XWDiscoverTitleModel *titleModel = [self.dataSource titleDataForGroupTableViewCell:self indexPath:self.indexPath];
        [titleModuleView setDataWithModel:titleModel];
    }
    
    //文本主体
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(contentDataForGroupTableViewCell:indexPath:)]) {
        XWDiscoverContentModel *contentModel = [self.dataSource contentDataForGroupTableViewCell:self indexPath:self.indexPath];
        [contentModuleView setDataWithModel:contentModel];
    }
    
    //图片
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(imageDataForGroupTableViewCell:indexPath:)]) {
        XWDiscoverImageModel *imageModel = [self.dataSource imageDataForGroupTableViewCell:self indexPath:self.indexPath];
        [imageModuleWall setDataWithModel:imageModel];
    }
    
    //分享
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(shareDataForGroupTableViewCell:indexPath:)]) {
        XWDiscoverShareModel *shareModel = [self.dataSource shareDataForGroupTableViewCell:self indexPath:self.indexPath];
        [shareModuleView setDataWithModel:shareModel];
    }
    
    //视频
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(videoDataForGroupTableViewCell:indexPath:)]) {
        XWDiscoverVideoModel *videoModel = [self.dataSource videoDataForGroupTableViewCell:self indexPath:self.indexPath];
        [videoModuleView setDataWithModel:videoModel];
    }
    
    //评论
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(commentsDataForGroupTableViewCell:indexPath:)]) {
        XWDiscoverCommentsModel *commentModel = [self.dataSource commentsDataForGroupTableViewCell:self indexPath:self.indexPath];
        [commentModuleView setDataWithModel:commentModel];
        
    }
}

/**
 *  计算cell高度
 */
+(CGFloat)countHeightWithGroupCellModel:(XWDiscoverModel *)model width:(CGFloat)width{
    CGFloat totalHeight = 0.0f;
    totalHeight += [XWDiscoverCellTitleModule countHeightWithModel:model width:width];
    totalHeight += [XWDiscoverCellContentModule countHeightWithModel:model width:width];
    totalHeight += [XWDiscoverCellImageModule countHeightWithModel:model width:width];
    totalHeight += [XWDiscoverCellVideoModule countHeightWithModel:model width:width];
    totalHeight += [XWDiscoverCellShareModule countHeightWithModel:model width:width];
    totalHeight += [XWDiscoverCellCommentModule countHeightWithModel:model width:width];
    //cell之间的间距
    totalHeight += 10;
    return totalHeight;
}

@end
