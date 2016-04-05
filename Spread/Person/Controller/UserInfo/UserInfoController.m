//
//  UserInfoController.m
//  Spread
//
//  Created by 邱学伟 on 16/3/29.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "UserInfoController.h"

@interface UserInfoController ()<UITableViewDataSource,UITableViewDelegate>{
    
}

//用户个人信息展示表格
@property (nonatomic, strong) UITableView *userInfoTable;

@end

@implementation UserInfoController
#pragma mark - 懒加载
-(UITableView *)userInfoTable{
    if (_userInfoTable == nil) {
        _userInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        [_userInfoTable setDataSource:self];
        [_userInfoTable setDelegate:self];
    }
    return _userInfoTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource + UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    //初始化cell数据!
    if (indexPath.row == 0) {
        [cell.textLabel setText:@"头像"];
        
    }
    
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
