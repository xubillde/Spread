//
//  XWRadarView.h
//  Spread
//
//  Created by qiuxuewei on 16/3/23.
//  Copyright © 2016年 邱学伟. All rights reserved.
// 雷达视图

#import <UIKit/UIKit.h>
@class XWRadarIndicatorView;
@class XWRadarPointView;
@class XWRadarView;

//@protocol XWRadarViewDataSource;
//@protocol XWRadarViewDelegate;
/** 数据源 */
@protocol XWRadarViewDataSource <NSObject>

@optional
/** 雷达视图圈数 */
-(NSInteger)numberOfSectionInRadarView:(XWRadarView *)xwRadarView;

/** 雷达视图上标记点的数量 */
-(NSInteger)numberOfPointsInRadarView:(XWRadarView *)radarView;

/** 自定义标记点视图 */
-(XWRadarPointView *)radarView:(XWRadarView *)radarView viewForIndex:(NSUInteger)index;



@end


/** 代理 */
@protocol XWRadarViewDelegate <NSObject>

@optional
/** 点击事件 */
- (void)radarView:(XWRadarView *)radarView didSelectItemAtIndex:(NSUInteger)index;

@end

@interface XWRadarView : UIView

/** 半径 */
@property (nonatomic, assign) CGFloat radius;
/** 中间个人头像的半径 */
@property (nonatomic, assign) CGFloat imgradius;

/** 背景视图 */
@property (nonatomic, strong) UIView *bcakgroundView;
/** 背景图片 */
@property (nonatomic, strong) UIImage *backgroundImage;
/** 背景图片 */
@property (nonatomic, strong) UIImage *PersonImage;

/** 提示标签*/
@property (nonatomic, strong) UILabel *textLabel;
/** 提示文字*/
@property (nonatomic, strong) NSString *labelText;
/** 目标点视图*/
@property (nonatomic, strong) UIView *pointsView;
/** 指针*/
@property (nonatomic, strong) XWRadarIndicatorView *indicatorView;

/** 数据源*/
@property (nonatomic, assign) id <XWRadarViewDataSource> dataSource;
/** 委托*/
@property (nonatomic, assign) id <XWRadarViewDelegate> delegate;

/** 扫描*/
-(void)scan;
/** 停止*/
-(void)stop;
/** 显示目标*/
-(void)show;
/** 隐藏目标*/
-(void)hide;


@end
