//
//  LocationSetUpController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/22.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "LocationSetUpController.h"
#import "LocationController.h"

@interface LocationSetUpController ()<UITableViewDataSource, UITableViewDelegate>{
    
}

//属性列表
/** 个人信息界面 */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LocationSetUpController
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 64) style:UITableViewStylePlain];
        [_tableView setScrollEnabled:NO];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:colorWithRGBA(246, 245, 242, 1)];
    [self.view addSubview:self.tableView];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态。
    // 加上此句，返回时直接就是非选中状态。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LocationController *locationVC = [[LocationController alloc] init];
    [locationVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:locationVC animated:YES];
    
}

//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *PersonInfoCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonInfoCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonInfoCell];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    //初始化cell数据!
    [cell.textLabel setText:@"定位设置"];
    [cell.imageView setImage:[UIImage imageNamed:@"location_64"]];
    
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
