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
#import "JPDiscoverFullStyleTableViewCell.h"
#import "JPDiscoverModel.h"


@interface DiscoverMainController ()<UITableViewDataSource,UITableViewDelegate,JPDiscoverTableViewCellDataSource,JPDiscoverTableViewCellDelegate>

//数据数组
@property (nonatomic, strong) NSMutableArray *dataSource;
//数据列表
@property (nonatomic, strong) UITableView *listTable;

@end

@implementation DiscoverMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = [[NSMutableArray alloc] init];
    
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
        [_dataSource addObject:[JPDiscoverModel getTestModel]];
    }
    [_listTable.mj_header endRefreshing];
    [_listTable reloadData];
    
}
//上拉刷新
-(void)loadMoreData{
    NSLog(@"上拉刷新");
    for (int i = 0; i < 10; i+=1) {
        [_dataSource addObject:[JPDiscoverModel getTestModel]];
    }
    [_listTable.mj_footer endRefreshing];
    [_listTable reloadData];
    
}

//#pragma mark - UITableViewDataSource UITableViewDelegate 方法->
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//
////初始化cell
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    //初始化cell数据!
//    
//    
//    return cell;
//}


#pragma mark Cell-Delegate

- (void)groupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell loadImageView:(UIImageView *)imageView imageUrl:(NSString *)imageUrl placeholderImage:(NSString *)placeholderImageName {
    if (imageUrl.length != 0) {
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:placeholderImageName]];
    }else {
        imageView.image = nil;
    }
}

- (void)groupTableViewCellTapPraiseButton:(JPDiscoverBaseTableViewCell *)tableViewCell {
    NSIndexPath *indexPath = [_listTable indexPathForCell:tableViewCell];
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    BOOL willBePraised = YES;
    if (cellModel.commentsModel.isPraised) {
        //取消赞
        willBePraised = NO;
    }else {
        //赞
        willBePraised = YES;
    }
    if (willBePraised) {
        cellModel.commentsModel.isPraised = YES;
        cellModel.commentsModel.praiseCount++;
    }else {
        cellModel.commentsModel.isPraised = NO;
        cellModel.commentsModel.praiseCount--;
    }
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [_listTable reloadRowsAtIndexPaths:indexPaths withRowAnimation:NO];
}

#pragma mark Cell-datasource

- (JPDiscoverTitleModel *)titleDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.titleModel;
}

- (JPDiscoverContentModel *)contentDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.contentModel;
}

- (JPDiscoverImageModel *)imageDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.imageModel;
}

- (JPDiscoverShareModel *)shareDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.shareModel;
}

- (JPDiscoverVideoModel *)videoDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.videoModel;
}

- (JPDiscoverCommentsModel *)commentsDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.commentsModel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    CGFloat totalHeight = [JPDiscoverFullStyleTableViewCell countHeightWithGroupCellModel:cellModel width:CGRectGetWidth(self.view.frame)];
    return totalHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"JPDiscoverFullStyleTableViewCell";
    JPDiscoverFullStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[JPDiscoverFullStyleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID width:CGRectGetWidth(self.view.frame)];
        [cell setBackgroundColor:UIColorRGB(242, 242, 242)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.dataSource = self;
        cell.delegate = self;
    }
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
