//
//  LocationController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/22.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "LocationController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationController ()<UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>{
    //系统定位管理者
    CLLocationManager *_maneger;
    UILabel *_loctionLB;
}

//属性列表
/** 个人信息界面 */
@property (nonatomic, strong) UITableView *tableView;

/** 说明labe */
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation LocationController
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 64) style:UITableViewStylePlain];
        [_tableView setScrollEnabled:NO];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
    }
    return _tableView;
}
-(UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 104, kScreenWidth-20, 64)];
        [_textLabel setText:@"如果要关闭或开启定位，请在iPhone的\"设置\"中，找到\"扩散-\"位置\"进行更改。扩散基于位置为您提供服务，建议始终开启。"];
        [_textLabel setNumberOfLines:3];
//        [_textLabel setBackgroundColor:ColorWithRGBA(123, 87, 65,0.5)];
        [_textLabel setFont:[UIFont systemFontOfSize:14.5f]];
        [_textLabel setTextColor:[UIColor lightGrayColor]];
    }
    return _textLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:colorWithRGBA(246, 245, 242, 1)];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.textLabel];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _maneger = [[CLLocationManager alloc] init];
    [_maneger setDelegate:self];
    [_maneger startUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (![_loctionLB.text isEqualToString:@"已开启"]) {
        [_loctionLB setText:@"已开启"];
    }
}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    NSString *errorString;
    [manager stopUpdatingLocation];
    NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
            //Access denied by user
            errorString = @"Access to Location Services denied by user";
            [_loctionLB setText:@"未开启"];
            //Do something...
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"Location data unavailable";
            //Do something else...
            break;
        default:
            errorString = @"An unknown error has occurred";
            break;
    }
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
}

//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *LocationCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LocationCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LocationCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //初始化cell数据!
    [cell.textLabel setText:@"定位设置"];
    _loctionLB = cell.detailTextLabel;
//    [_loctionLB setText:@"已开启"];
    
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
