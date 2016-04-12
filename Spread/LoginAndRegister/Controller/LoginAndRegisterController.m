//
//  LoginAndRegisterController.m
//  Spread
//
//  Created by 邱学伟 on 16/4/11.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "LoginAndRegisterController.h"

@interface LoginAndRegisterController ()

/**
 *  背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *loginBGImageView;
/**
 * 登陆按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/**
 *  注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
/**
 *  登录标示view
 */
@property (weak, nonatomic) IBOutlet UIView *LoginView;
/**
 *  注册标示view
 */
@property (weak, nonatomic) IBOutlet UIView *RegisterView;
/**
 *  主体视图
 */
@property (weak, nonatomic) IBOutlet UIView *mainView;

/**
 *  登录主体
 */
@property (nonatomic, strong) UIView *loginMianView;
@property (nonatomic, strong) UITextField *loginNumFD;
@property (nonatomic, strong) UITextField *loginPasswordFD;
@property (nonatomic, strong) UIButton *forgetPasswordBtn;
@property (nonatomic, strong) UIButton *loginMainBtn;
@property (nonatomic, strong) UIButton *wechatLoginBtn;


/**
 *  注册主体
 */
@property (nonatomic, strong) UIView *registerMianView;
@property (nonatomic, strong) UITextField *registerNumFD;
@property (nonatomic, strong) UITextField *registerPasswordFD;
@property (nonatomic, strong) UITextView *registerCodeFD;
@property (nonatomic, strong) UIButton *sentCodeBtn;
@property (nonatomic, strong) UIButton *registerMainBtn;


@end

@implementation LoginAndRegisterController
//注册主体视图
-(UIView *)registerMianView{
    if (_registerMianView == nil) {
        _registerMianView = [[UIView alloc] init];
        [_registerMianView setBackgroundColor:ColorWithRGB(242, 242, 242)];
        [_registerMianView setUserInteractionEnabled:YES];

        
        
        _registerNumFD = [[UITextField alloc] initWithFrame:CGRectMake(27, 6, kScreenWidth-54, 48)];
        [_registerNumFD setPlaceholder:@"手机号"];
        [_registerNumFD setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_registerNumFD setBorderStyle:UITextBorderStyleNone];
        [_registerNumFD setUserInteractionEnabled:YES];
        [_registerNumFD setKeyboardType:UIKeyboardTypePhonePad];
        [_registerMianView addSubview:_registerNumFD];
        
        
        CALayer *loginNumFDLineLayer = [[CALayer alloc] init];
        [loginNumFDLineLayer setFrame:CGRectMake(27, CGRectGetMaxY(_registerNumFD.frame), CGRectGetWidth(_registerNumFD.frame), 1)];
        [loginNumFDLineLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_registerMianView.layer addSublayer:loginNumFDLineLayer];
        
        
        _registerNumFD = [[UITextField alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(_registerNumFD.frame) + 4, kScreenWidth-54, 48)];
        [_registerNumFD setPlaceholder:@"密码"];
        [_registerNumFD setSecureTextEntry:YES];
        [_registerNumFD setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_registerNumFD setKeyboardType:UIKeyboardTypeASCIICapable];
        [_registerNumFD setBorderStyle:UITextBorderStyleNone];
        [_registerNumFD setUserInteractionEnabled:YES];
        [_registerMianView addSubview:_registerNumFD];
        
        
        CALayer *loginPasswordFDLineLayer = [[CALayer alloc] init];
        [loginPasswordFDLineLayer setFrame:CGRectMake(27, CGRectGetMaxY(_registerNumFD.frame), CGRectGetWidth(_registerNumFD.frame), 1)];
        [loginPasswordFDLineLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_registerMianView.layer addSublayer:loginPasswordFDLineLayer];
        
        
        //登录
        _registerMainBtn = [[UIButton alloc] initInquireButtonWithTitle:@"注册" withFrame:CGRectMake(27, CGRectGetMaxY(_registerNumFD.frame)+10,kScreenWidth-54 , 44) andBackgroundColor:colorWithRGBA(123, 123, 54, 0.8) andhightlightColor:colorWithRGBA(123, 123, 54, 0.6)];
        [_registerMianView addSubview:_registerMainBtn];

        
    }
    return _registerMianView;
}
//登录主体视图
-(UIView *)loginMianView{
    if (_registerMianView == nil) {
        _registerMianView = [[UIView alloc] init];
        [_registerMianView setBackgroundColor:ColorWithRGB(242, 242, 242)];
        [_registerMianView setUserInteractionEnabled:YES];
        
        _loginNumFD = [[UITextField alloc] initWithFrame:CGRectMake(27, 6, kScreenWidth-54, 48)];
        [_loginNumFD setPlaceholder:@"手机号"];
        [_loginNumFD setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_loginNumFD setBorderStyle:UITextBorderStyleNone];
        [_loginNumFD setUserInteractionEnabled:YES];
        [_loginNumFD setKeyboardType:UIKeyboardTypePhonePad];
        [_registerMianView addSubview:_loginNumFD];
        
        
        CALayer *loginNumFDLineLayer = [[CALayer alloc] init];
        [loginNumFDLineLayer setFrame:CGRectMake(27, CGRectGetMaxY(_loginNumFD.frame), CGRectGetWidth(_loginNumFD.frame), 1)];
        [loginNumFDLineLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_registerMianView.layer addSublayer:loginNumFDLineLayer];
        
        
        _loginPasswordFD = [[UITextField alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(_loginNumFD.frame) + 4, kScreenWidth-54, 48)];
        [_loginPasswordFD setPlaceholder:@"密码"];
        [_loginPasswordFD setSecureTextEntry:YES];
        [_loginPasswordFD setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_loginPasswordFD setKeyboardType:UIKeyboardTypeASCIICapable];
        [_loginPasswordFD setBorderStyle:UITextBorderStyleNone];
        [_loginPasswordFD setUserInteractionEnabled:YES];
        [_registerMianView addSubview:_loginPasswordFD];
        
        
        CALayer *loginPasswordFDLineLayer = [[CALayer alloc] init];
        [loginPasswordFDLineLayer setFrame:CGRectMake(27, CGRectGetMaxY(_loginPasswordFD.frame), CGRectGetWidth(_loginPasswordFD.frame), 1)];
        [loginPasswordFDLineLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_registerMianView.layer addSublayer:loginPasswordFDLineLayer];
        
        
        //忘记密码
        _forgetPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(_loginPasswordFD.frame)+4, 64, 44)];
        [_forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPasswordBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_forgetPasswordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerMianView addSubview:_forgetPasswordBtn];
        
        //登录
        _registerMainBtn = [[UIButton alloc] initInquireButtonWithTitle:@"登录" withFrame:CGRectMake(27, CGRectGetMaxY(_forgetPasswordBtn.frame)+2,kScreenWidth-54 , 44) andBackgroundColor:colorWithRGBA(123, 123, 54, 0.8) andhightlightColor:colorWithRGBA(123, 123, 54, 0.6)];
        [_registerMianView addSubview:_registerMainBtn];
        
        
        //微信登录
        _wechatLoginBtn = [[UIButton alloc] initInquireButtonWithTitle:@"微信登录" withFrame:CGRectMake(27, CGRectGetMaxY(_registerMainBtn.frame)+4,kScreenWidth-54 , 44) andBackgroundColor:colorWithRGBA(25, 205, 34, 0.8) andhightlightColor:colorWithRGBA(25, 205, 34, 0.8)];
        [_wechatLoginBtn addTarget:self action:@selector(wechatLoginClick) forControlEvents:UIControlEventTouchUpInside];
        [self.loginMianView addSubview:_wechatLoginBtn];
       
        
    }
    return _registerMianView;
}

//


-(void)wechatLoginClick{
    NSLog(@"wechatLoginClick");
}

/**
 *  登录点击按钮
 */
- (IBAction)loginBtnClick:(UIButton *)sender {
    NSLog(@"login...");
    [_LoginView setBackgroundColor:[UIColor yellowColor]];
    [_RegisterView setBackgroundColor:[UIColor clearColor]];
    
    //主体视图更改样式
    [self.registerMianView removeFromSuperview];
    [self.mainView addSubview:self.loginMianView];
}

/**
*  注册点击按钮
*/
- (IBAction)registerBtnClick:(UIButton *)sender {
    NSLog(@"register...");
    [_LoginView setBackgroundColor:[UIColor clearColor]];
    [_RegisterView setBackgroundColor:[UIColor yellowColor]];
    
    [self.loginMianView removeFromSuperview];
    [self.mainView addSubview:self.registerMianView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mainView setUserInteractionEnabled:YES];
    [self.mainView addSubview:self.loginMianView];
}

-(void)viewDidLayoutSubviews{
    [self.loginMianView setFrame:self.mainView.bounds];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
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
