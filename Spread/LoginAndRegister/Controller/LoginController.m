//
//  LoginController.m
//  Spread
//
//  Created by 邱学伟 on 16/4/19.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "LoginController.h"
//#import "<#header#>"

@interface LoginController ()

@property (weak, nonatomic) IBOutlet UIView *textViewBGView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

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
    
    //登录按钮圆角
    [_loginBtn.layer setCornerRadius:6.0];
    _loginBtn.layer.shouldRasterize = YES;
    _loginBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    
}

//添加点击事件
-(void)creatClickMethod{
    //注册
    
    //选择国家代码
    
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
