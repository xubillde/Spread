//
//  DiscoverMainController.m
//  Spread
//
//  Created by 邱学伟 on 16/4/5.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "DiscoverMainController.h"
#import "MJRefresh.h"
#import <UIImageView+AFNetworking.h>
//#import "JPDiscoverFullStyleTableViewCell.h"
//#import "JPDiscoverModel.h"

#import "XWDiscoverModel.h"
#import "XWDiscoverFullStyleCell.h"
//#import "<#header#>"


@interface DiscoverMainController ()<UITableViewDataSource,UITableViewDelegate,XWDiscoverTableViewCellDelegate,XWDiscoverTableViewCellDataSource>

//数据数组
@property (nonatomic, strong) NSMutableArray *dataSource;
//数据列表
@property (nonatomic, strong) UITableView *listTable;

@end

@implementation DiscoverMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //数据数组
    _dataSource = [[NSMutableArray alloc] init];
    
    //动态列表
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64) style:UITableViewStylePlain];
    [_listTable setDataSource:self];
    [_listTable setDelegate:self];
    //不显示水平滑动条
    [_listTable setShowsHorizontalScrollIndicator:NO];
    //不显示垂直滑动条
    [_listTable setShowsVerticalScrollIndicator:NO];
    //cell箭头
    [_listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_listTable];
    
    //设置刷新
    [_listTable setMj_header:[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)]];
    [_listTable setMj_footer:[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)]];
    // 马上进入刷新状态
    [_listTable.mj_header beginRefreshing];
    
}
#pragma mark - 下拉刷新
-(void)headerRereshing{
    NSLog(@"下拉刷新");
    [_dataSource removeAllObjects];
    
    //网络请求数据->
    for (int i = 0; i<10; i++) {
//        [_dataSource addObject:[XWDiscoverModel getModel]];
        [_dataSource addObject:[XWDiscoverModel getTestModel]];
    }
    [_listTable.mj_header endRefreshing];
    [_listTable reloadData];
    
}
//上拉刷新
-(void)loadMoreData{
    NSLog(@"上拉刷新");
    for (int i = 0; i < 10; i+=1) {
//        [_dataSource addObject:[XWDiscoverModel getModel]];
        [_dataSource addObject:[XWDiscoverModel getTestModel]];
    }
    [_listTable.mj_footer endRefreshing];
    [_listTable reloadData];
    
}

#pragma mark Cell-Delegate
//为imageView图片
-(void)groupTableViewCell:(XWDiscoverBaseCell *)tableViewCell loadIamgeView:(UIImageView *)imageView imageUrl:(NSString *)imageUrl placeholderImageName:(NSString *)placeholderImageName{
    if (imageUrl.length != 0) {
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:placeholderImageName]];
    }else{
        imageView.image = nil;
    }
    
}
/**
 * 点击照片墙操作!!
 */
-(void)groupTableViewCellTapImageWall:(XWDiscoverBaseCell *)tableViewCell imageWall:(XWDiscoverCellImageModule *)imageWall imageView:(UIImageView *)imageView index:(NSUInteger)index{
    NSLog(@"点击照片墙,哈哈哈.这是第%ld张照片",index);
}
/**
 *  点击头像加载操作
 */
-(void)groupTableViewCellTapUserHead:(XWDiscoverBaseCell *)tableViewCell{
    NSLog(@"点击头像加载操作,哈哈哈");
}
/**
 *  点赞操作
 */
-(void)groupTableViewCellTapPraiseButton:(XWDiscoverBaseCell *)tableViewCell{
    NSLog(@"点赞操作,哈哈哈");
    
    NSIndexPath *indexPath = [_listTable indexPathForCell:tableViewCell];
    XWDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    BOOL willBePraised = YES;
    if (cellModel.commentsModel.isPraised) {
        //如果之前点赞过此动态...取消赞!
        willBePraised = NO;
    }else{
        //赞
        willBePraised = YES;
    }
    
    //willBePraised->当前真实的点赞情况
    if (willBePraised) {
        cellModel.commentsModel.isPraised  =YES;
        cellModel.commentsModel.praisedCount++;
    }else{
        cellModel.commentsModel.isPraised  =NO;
        cellModel.commentsModel.praisedCount--;
    }
    
    //刷新当前cell
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [_listTable reloadRowsAtIndexPaths:indexPaths withRowAnimation:NO];
}
/**
 *  评论操作
 */
-(void)groupTableViewCellTapCommentButton:(XWDiscoverBaseCell *)tableViewCell{
    NSLog(@"评论操作,哈哈哈");
}
/**
 *  点击分享操作
 */
-(void)groupTableViewCellTapShareContent:(XWDiscoverBaseCell *)tableViewCell{
     NSLog(@"点击分享操作,哈哈哈");
}
/**
 *  点击视频播放操作
 */
-(void)groupTableViewCellTapVideoPlay:(XWDiscoverBaseCell *)tableViewCell{
    NSLog(@"点击视频播放操作,哈哈哈");
}

#pragma mark Cell-datasource

/** 顶部数据 */
-(XWDiscoverTitleModel *)titleDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableviewCell indexPath:(NSIndexPath *)indexPath{
    XWDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.titleModel;
}

/** 内容数据 */
-(XWDiscoverContentModel *)contentDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableViewCell indexPath:(NSIndexPath *)indexPath{
    XWDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.contentModel;
}

/** 图片数据 */
-(XWDiscoverImageModel *)imageDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableVeiwCell indexPath:(NSIndexPath *)indexPath{
    XWDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.imageModel;
}

/** 分享数据 */
-(XWDiscoverShareModel *)shareDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableVeiwCell indexPath:(NSIndexPath *)indexPath{
    XWDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.shareModel;
}

/** 视频数据 */
-(XWDiscoverVideoModel *)videoDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableVeiwCell indexPath:(NSIndexPath *)indexPath{
    XWDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.videoModel;
}

/** 点赞评论数据 */
-(XWDiscoverCommentsModel *)commentsDataForGroupTableViewCell:(XWDiscoverBaseCell *)tableVeiwCell indexPath:(NSIndexPath *)indexPath{
    XWDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.commentsModel;
}

#pragma mark - UITableViewDataSource UITableViewDelegate 方法->
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //根据模型确定不同高度
    XWDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    CGFloat totalHeight = [XWDiscoverFullStyleCell countHeightWithGroupCellModel:cellModel width:CGRectGetWidth(self.view.frame)];
    return totalHeight;
}
//数据个数->
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"XWDiscoverFullStyleCell";
    XWDiscoverFullStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XWDiscoverFullStyleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID width:CGRectGetWidth(self.view.frame)];
        [cell setBackgroundColor:ColorWithRGB(242, 242, 242)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setDataSource:self];
        [cell setDelegate:self];
    }
    //初始化cell数据!
    [cell loadDataSourceWithIndexPath:indexPath];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
