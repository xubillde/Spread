//
//  AboutSelfController.m
//  Spread
//
//  Created by 邱学伟 on 16/3/28.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "AboutSelfController.h"
#import "AdviceFeedbackController.h"

@interface AboutSelfController ()<UITableViewDataSource,UITableViewDelegate>

/** 功能选项表格 */
@property (strong, nonatomic) UITableView *AboutTable;

@end

@implementation AboutSelfController
#pragma mark - 懒加载
-(UITableView *)AboutTable{
    if (_AboutTable == nil) {
        _AboutTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, kScreenWidth, 128) style:UITableViewStylePlain];
        [_AboutTable setDataSource:self];
        [_AboutTable setDelegate:self];
        [_AboutTable setScrollEnabled:NO];
    }
    return _AboutTable;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:colorWithRGBA(246, 245, 242, 1)];

    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self creatSubViews];
}
#pragma mark - 类内
-(void)creatSubViews{
    [self.navigationItem setTitle:@"关于"];
    
    //
    [self.view addSubview:self.AboutTable];
    
    
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //初始化cell数据!
    if (indexPath.row == 0) {
        [cell.textLabel setText:@"用户协议"];
    }else{
        [cell.textLabel setText:@"意见反馈"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击cell");
    if (indexPath.row == 1) {
        AdviceFeedbackController *adviceFeedbackVC = [[AdviceFeedbackController alloc] init];
        [adviceFeedbackVC.navigationItem setTitle:@"意见反馈"];
        [adviceFeedbackVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:adviceFeedbackVC animated:YES];
    }
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
