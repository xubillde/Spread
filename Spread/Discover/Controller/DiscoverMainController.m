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


@interface DiscoverMainController ()<UITableViewDataSource,UITabBarDelegate>

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
    [_listTable.header beginRefreshing];
    
}
#pragma mark - 下拉刷新
-(void)headerRereshing{
    NSLog(@"下拉刷新");
    [_dataSource removeAllObjects];
    
    //网络请求数据->
    for (int i = 0; i<10; i++) {
//        [_dataSource addObject:[]];
    }
    
    
}
//上拉刷新
-(void)loadMoreData{
    NSLog(@"上拉刷新");
    
}

#pragma mark - UITableViewDataSource UITabBarDelegate 方法->
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //初始化cell数据!
    
    
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
