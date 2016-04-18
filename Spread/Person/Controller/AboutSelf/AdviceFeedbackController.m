//
//  AdviceFeedbackController.m
//  Spread
//
//  Created by 邱学伟 on 16/4/18.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "AdviceFeedbackController.h"
#import "XWPlaceholderTextView.h"
#import "MBProgressHUD.h"
#import "LCCoolHUD.h"

@interface AdviceFeedbackController ()<UITextViewDelegate>{
    CGFloat _keyBoardHeight;
}

@property (nonatomic, strong) XWPlaceholderTextView *placholderTextView;

@end

@implementation AdviceFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatChildViews];
}

-(void)creatChildViews{
    //输入文本
    self.placholderTextView = [XWPlaceholderTextView shareWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) withPlaceholder:@"我们会根据您反馈的意见和问题,提升产品的用户体验!您的声音很重要!"];
    [_placholderTextView setDelegate:self];
    [self.view addSubview:self.placholderTextView];
    
//    //自定义BarButtonItem
//    UIButton *cleanUpAllAnnoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cleanUpAllAnnoBtn setBackgroundImage:[UIImage imageNamed:@"cleanUP"] forState:UIControlStateNormal];
//    [cleanUpAllAnnoBtn setFrame:CGRectMake(0, 0, 32, 32)];
//    [cleanUpAllAnnoBtn addTarget:self action:@selector(cleanUpAllPolyline) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *locationBarBtnCustom = [[UIBarButtonItem alloc] initWithCustomView:cleanUpAllAnnoBtn];
//    self.navigationItem.rightBarButtonItem = locationBarBtnCustom;

    //提交按钮
//    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [submitBtn setFrame:CGRectMake(0, 0, 32, 32)];
////    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
//    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [submitBtn setBackgroundImage:[UIImage imageNamed:@"cleanUP"] forState:UIControlStateNormal];
    
    UIBarButtonItem *commitBtn = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitAdviceFeedback)];
    [commitBtn setTintColor:[UIColor lightGrayColor]];
    [self.navigationItem setRightBarButtonItem:commitBtn];
}

- (void)keyboardDidShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    _keyBoardHeight = keyboardSize.height;
    
//    [self changeViewYByShow];
}

-(void)commitAdviceFeedback{
   
    if (self.placholderTextView.text.length == 0) {
        //如果用户没有填写内容
        [LCCoolHUD showFailureOblong:@"请填写反馈内容" inView:self.view zoom:YES shadow:NO];
    }else{
        NSLog(@"提交");
    }
    
}



#pragma mark - 点击屏幕取消输入
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
