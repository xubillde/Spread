//
//  PublishController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/21.
//  Copyright © 2016年 邱学伟. All rights reserved.
// 发布

#import "PublishController.h"

@interface PublishController ()<UITextFieldDelegate>

@end

@implementation PublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置输入框
    [self setUpNickNameFD];
    //设置头像
    [self setUpIcon];
    //设置按钮圆角
    [self customViewLaout];
    
}
-(void)setUpNickNameFD{
    [self.nickNameFD setDelegate:self];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nickNameFD resignFirstResponder];
    return YES;
}
-(void)setUpIcon{
    //设置用户头像
    NSString *iconImageStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"iconImageStr"];
    if (iconImageStr.length == 0) {
        return;
    }
    NSData *iconData = [[NSData alloc] initWithBase64EncodedString:iconImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *iconImage = [UIImage imageWithData:iconData];
    [self.iconImageView setImage:iconImage];
    
}
//设置按钮圆角
-(void)customViewLaout{
    //按钮
    //阴影 Shadow
    self.SpreadBtn.layer.shadowColor = [UIColor blackColor].CGColor; //黑
    self.SpreadBtn.layer.shadowOpacity = 0.33;//阴影的不透明度
    self.SpreadBtn.layer.shadowOffset = CGSizeMake(0, 1.5);//阴影的偏移
    self.SpreadBtn.layer.shadowRadius = 4.0;//阴影半径
    self.SpreadBtn.layer.shouldRasterize = YES; //圆角缓存
    self.SpreadBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;//提高流畅度.
    //圆角
    self.SpreadBtn.layer.cornerRadius = 6.0f;
}

#pragma mark - 类内方法
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//扩散
- (IBAction)SpreadBtnClick:(UIButton *)sender {
    UIAlertController *spreadAlertC = [UIAlertController alertControllerWithTitle:nil message:@"扩散成功,祝你好运..." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *AlertActionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [spreadAlertC addAction:AlertActionOK];
    [self presentViewController:spreadAlertC animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nickNameFD resignFirstResponder];
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
