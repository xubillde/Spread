//
//  OneDetailsController.m
//  OneHelper
//
//  Created by qiuxuewei on 16/3/11.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "OneDetailsController.h"

@interface OneDetailsController ()

@end

@implementation OneDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customViews];
}

#pragma mark - 类内方法
//自定义界面
-(void)customViews{
    [self.heheBtn setBackgroundImage:[UIImage imageNamed:@"hehe"] forState:UIControlStateNormal];
    [self.memeBtn setBackgroundImage:[UIImage imageNamed:@"meme"] forState:UIControlStateNormal];
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
