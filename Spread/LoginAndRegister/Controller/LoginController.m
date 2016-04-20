//
//  LoginController.m
//  Spread
//
//  Created by 邱学伟 on 16/4/19.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "LoginController.h"
#import "XWCountryCodeController.h"

@interface LoginController ()
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


//输入框背景视图
@property (weak, nonatomic) IBOutlet UIView *textViewBGView;

//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

//国家代码输入框
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLB;

//前往国家代码箭头
@property (weak, nonatomic) IBOutlet UIImageView *countryCodeArrow;



@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self creatSubviews];
    
}

/**
 *  创建子视图
 */
-(void)creatSubviews{
    
    //添加点击事件
    [self creatClickMethod];
    
    
    //输入框背景视图
    [_textViewBGView.layer setCornerRadius:6.0];
    _textViewBGView.layer.rasterizationScale = [UIScreen mainScreen].scale;//提高流畅度
    _textViewBGView.layer.shouldRasterize = YES; //圆角缓存
    
    [_countryCodeLB setAdjustsFontSizeToFitWidth:YES];
    
    //登录按钮圆角
    [_loginBtn.layer setCornerRadius:6.0];
    _loginBtn.layer.shouldRasterize = YES;
    _loginBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    
}

//添加点击事件
-(void)creatClickMethod{
    //注册
}

//取消点击事件
- (IBAction)cancelClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//注册
- (IBAction)registerClick:(UIButton *)sender {
    NSLog(@"注册");
}

- (IBAction)shooseCountryCodeClick:(UIButton *)sender {
    NSLog(@"选择国家");
    XWCountryCodeController *CountryCodeVC = [[XWCountryCodeController alloc] init];
    //block
    [CountryCodeVC toReturnCountryCode:^(NSString *countryCodeStr) {
        //在此处实现最终选择后的界面处理
        [self.countryCodeLB setText:countryCodeStr];
    }];
    [self presentViewController:CountryCodeVC animated:YES completion:nil];
//    [self.navigationController pushViewController:CountryCodeVC animated:YES];
}
//选择国家
-(void)chooseContryCodeTapMethod{
    NSLog(@"选择国家");
    XWCountryCodeController *CountryCodeVC = [[XWCountryCodeController alloc] init];
    //block
    [CountryCodeVC toReturnCountryCode:^(NSString *countryCodeStr) {
        //在此处实现最终选择后的界面处理
        [self.countryCodeLB setText:countryCodeStr];
    }];
    [self presentViewController:CountryCodeVC animated:YES completion:nil];
}

//忘记密码点击事件
- (IBAction)forgetPasswordClick:(UIButton *)sender {
    NSLog(@"忘记密码");
    
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
