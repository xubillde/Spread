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
 *  返回icon
 */
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;


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
@property (nonatomic, strong) UITextField *registerCodeFD;
@property (nonatomic, strong) UIButton *sentCodeBtn;
@property (nonatomic, strong) UIButton *registerMainBtn;
//@property (nonatomic, strong) UIButton *sent;


@end

@implementation LoginAndRegisterController
//注册主体视图
-(UIView *)registerMianView{
    if (_registerMianView == nil) {
        _registerMianView = [[UIView alloc] init];
//        [_registerMianView setFrame:_mainView.bounds];
        [_registerMianView setBackgroundColor:ColorWithRGB(242, 242, 242)];
        [_registerMianView setUserInteractionEnabled:YES];

        
        
        _registerNumFD = [[UITextField alloc] initWithFrame:CGRectMake(27, 2, kScreenWidth-54, 48)];
        [_registerNumFD setPlaceholder:@"手机号"];
        [_registerNumFD setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_registerNumFD setBorderStyle:UITextBorderStyleNone];
        [_registerNumFD setUserInteractionEnabled:YES];
        [_registerNumFD setKeyboardType:UIKeyboardTypePhonePad];
        [_registerMianView addSubview:_registerNumFD];
        
        
        CALayer *registerNumFDLineLayer = [[CALayer alloc] init];
        [registerNumFDLineLayer setFrame:CGRectMake(27, CGRectGetMaxY(_registerNumFD.frame)-1, CGRectGetWidth(_registerNumFD.frame), 1)];
        [registerNumFDLineLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_registerMianView.layer addSublayer:registerNumFDLineLayer];
        
        
        _registerPasswordFD = [[UITextField alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(_registerNumFD.frame) + 4, kScreenWidth-54, 48)];
        [_registerPasswordFD setPlaceholder:@"密码"];
        [_registerPasswordFD setSecureTextEntry:YES];
        [_registerPasswordFD setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_registerPasswordFD setKeyboardType:UIKeyboardTypeASCIICapable];
        [_registerPasswordFD setBorderStyle:UITextBorderStyleNone];
        [_registerPasswordFD setUserInteractionEnabled:YES];
        [_registerMianView addSubview:_registerPasswordFD];
        
        
        CALayer *registerPasswordFDLineLayer = [[CALayer alloc] init];
        [registerPasswordFDLineLayer setFrame:CGRectMake(27, CGRectGetMaxY(_registerPasswordFD.frame)-1, CGRectGetWidth(_registerPasswordFD.frame), 1)];
        [registerPasswordFDLineLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_registerMianView.layer addSublayer:registerPasswordFDLineLayer];
        
        //验证码
        _registerCodeFD = [[UITextField alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(_registerPasswordFD.frame), kScreenWidth-54, 48)];
        [_registerCodeFD setPlaceholder:@"验证码"];
        [_registerCodeFD setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_registerCodeFD setKeyboardType:UIKeyboardTypeNumberPad];
        [_registerCodeFD setBorderStyle:UITextBorderStyleNone];
        [_registerCodeFD setUserInteractionEnabled:YES];
        [_registerMianView addSubview:_registerCodeFD];
        
        //底部画线
        CALayer *registerCodeLineFDLayer = [[CALayer alloc] init];
        [registerCodeLineFDLayer setFrame:CGRectMake(27, CGRectGetMaxY(_registerCodeFD.frame)-1, CGRectGetWidth(_registerCodeFD.frame), 1)];
        [registerCodeLineFDLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_registerMianView.layer addSublayer:registerCodeLineFDLayer];
        
        
        //发送验证码按钮
        _sentCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 27 - 4 - 94, CGRectGetMinY(_registerCodeFD.frame) + 4, 94, 40)];
        [_sentCodeBtn setBackgroundColor:colorWithRGBA(0, 191, 191, 0.9)];
        [_sentCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sentCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        //设置圆角
        [_sentCodeBtn.layer setCornerRadius:3.0f];
        [_sentCodeBtn.layer setShouldRasterize:YES];
        [_sentCodeBtn.layer setRasterizationScale:[UIScreen mainScreen].scale];
        //发送事件
        [_sentCodeBtn addTarget:self action:@selector(sentCodeMethod) forControlEvents:UIControlEventTouchUpInside];
        [_registerMianView addSubview:_sentCodeBtn];
        
        //重新设置验证码输入框宽度
        [_registerCodeFD setWidth:_registerCodeFD.frame.size.width - CGRectGetWidth(_sentCodeBtn.frame) - 4];
        
        
        //注册
        _loginMainBtn = [[UIButton alloc] initInquireButtonWithTitle:@"注册" withFrame:CGRectMake(27, CGRectGetMaxY(_registerCodeFD.frame)+8,kScreenWidth-54 , 44) andBackgroundColor:colorWithRGBA(255, 255, 0, 0.7) andhightlightColor:colorWithRGBA(255, 255, 0, 1)];
        [_loginMainBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_registerMianView addSubview:_loginMainBtn];
        
        //用户协议
        UIButton *userAgreementBtn = [[UIButton alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(_loginMainBtn.frame) + 5, kScreenWidth - 54, 22)];
        [userAgreementBtn setTitle:@"注册即同意扩散用户协议" forState:UIControlStateNormal];
        [userAgreementBtn.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [userAgreementBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [userAgreementBtn addTarget:self action:@selector(userAgreenmentClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerMianView addSubview:userAgreementBtn];

        
    }
    return _registerMianView;
}
//登录主体视图
-(UIView *)loginMianView{
    if (_loginMianView == nil) {
        _loginMianView = [[UIView alloc] init];
//        [_loginMianView setFrame:_mainView.bounds];
        [_loginMianView setBackgroundColor:ColorWithRGB(242, 242, 242)];
        [_loginMianView setUserInteractionEnabled:YES];
        
        _loginNumFD = [[UITextField alloc] initWithFrame:CGRectMake(27, 2, kScreenWidth-54, 48)];
        [_loginNumFD setPlaceholder:@"手机号"];
        [_loginNumFD setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_loginNumFD setBorderStyle:UITextBorderStyleNone];
        [_loginNumFD setUserInteractionEnabled:YES];
        [_loginNumFD setKeyboardType:UIKeyboardTypePhonePad];
        [_loginMianView addSubview:_loginNumFD];
        
        
        CALayer *loginNumFDLineLayer = [[CALayer alloc] init];
        [loginNumFDLineLayer setFrame:CGRectMake(27, CGRectGetMaxY(_loginNumFD.frame), CGRectGetWidth(_loginNumFD.frame), 1)];
        [loginNumFDLineLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_loginMianView.layer addSublayer:loginNumFDLineLayer];
        
        
        _loginPasswordFD = [[UITextField alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(_loginNumFD.frame) + 4, kScreenWidth-54, 48)];
        [_loginPasswordFD setPlaceholder:@"密码"];
        [_loginPasswordFD setSecureTextEntry:YES];
        [_loginPasswordFD setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_loginPasswordFD setKeyboardType:UIKeyboardTypeASCIICapable];
        [_loginPasswordFD setBorderStyle:UITextBorderStyleNone];
        [_loginPasswordFD setUserInteractionEnabled:YES];
        [_loginMianView addSubview:_loginPasswordFD];
        
        
        CALayer *loginPasswordFDLineLayer = [[CALayer alloc] init];
        [loginPasswordFDLineLayer setFrame:CGRectMake(27, CGRectGetMaxY(_loginPasswordFD.frame), CGRectGetWidth(_loginPasswordFD.frame), 1)];
        [loginPasswordFDLineLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_loginMianView.layer addSublayer:loginPasswordFDLineLayer];
        
        
        //忘记密码
        _forgetPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(_loginPasswordFD.frame)+4, 64, 44)];
        [_forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPasswordBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_forgetPasswordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginMianView addSubview:_forgetPasswordBtn];
        
        //登录
        _loginMainBtn = [[UIButton alloc] initInquireButtonWithTitle:@"登录" withFrame:CGRectMake(27, CGRectGetMaxY(_forgetPasswordBtn.frame)+2,kScreenWidth-54 , 44) andBackgroundColor:colorWithRGBA(255, 255, 0, 0.7) andhightlightColor:colorWithRGBA(255, 255, 0, 1)];
        [_loginMainBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_loginMianView addSubview:_loginMainBtn];
        
        
        //微信登录
        _wechatLoginBtn = [[UIButton alloc] initInquireButtonWithTitle:@"微信登录" withFrame:CGRectMake(27, CGRectGetMaxY(_loginMainBtn.frame)+4,kScreenWidth-54 , 44) andBackgroundColor:colorWithRGBA(25, 205, 34, 0.8) andhightlightColor:colorWithRGBA(25, 205, 34, 0.8)];
        [_wechatLoginBtn addTarget:self action:@selector(wechatLoginClick) forControlEvents:UIControlEventTouchUpInside];
        [self.loginMianView addSubview:_wechatLoginBtn];
       
        
    }
    return _loginMianView;
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
    
    [self loadViewIfNeeded];
}

/**
*  注册点击按钮
*/
- (IBAction)registerBtnClick:(UIButton *)sender {
    NSLog(@"register...");
    [_LoginView setBackgroundColor:[UIColor clearColor]];
    [_RegisterView setBackgroundColor:[UIColor yellowColor]];
    
//    self.mainView = self.registerMianView;
    [self.loginMianView removeFromSuperview];
    [self.mainView addSubview:self.registerMianView];
    
    [self loadViewIfNeeded];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mainView setUserInteractionEnabled:YES];
    [self.mainView addSubview:self.loginMianView];
//    self.
    
    //返回按钮增加点击方法
    UITapGestureRecognizer *tapBackImageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackClick)];
    [self.backImageView setUserInteractionEnabled:YES];
    [self.backImageView addGestureRecognizer:tapBackImageRecognizer];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.loginMianView setFrame:self.mainView.bounds];
    [self.registerMianView setFrame:self.mainView.bounds];
}

-(void)loadViewIfNeeded{
    [super loadViewIfNeeded];
    
//    [self.loginMianView setFrame:self.mainView.bounds];
//    [self.registerMianView setFrame:self.mainView.bounds];
}

#pragma mark - 类内
-(void)tapBackClick{
    NSLog(@"返回点击！");
}

-(void)userAgreenmentClick{
    NSLog(@"用户协议");
    
}

//发送验证码
-(void)sentCodeMethod{
    NSLog(@"发送验证码。。");
    //计时器发送验证码
    [self sentPhoneCodeTimeMethod];
    //调用发送验证码接口-》
    
}

//计时器发送验证码
-(void)sentPhoneCodeTimeMethod{
    //倒计时时间 - 60秒
    __block NSInteger timeOut = 59;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -》dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式-》
            dispatch_async(dispatch_get_main_queue(), ^{
                [_sentCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                [_sentCodeBtn setUserInteractionEnabled:YES];
            });
        }else{
            //开始计时
            //剩余秒数 seconds
            NSInteger seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.1ld",seconds];
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                [_sentCodeBtn setTitle:[NSString stringWithFormat:@"%@S后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                //计时器件不允许点击
                [_sentCodeBtn setUserInteractionEnabled:NO];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
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
