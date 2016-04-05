//
//  BaseViewController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/21.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ColorWithRGBA(234, 213, 230, 1)];
//    self.
    
    //背景图片
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle]resourcePath] ,@"huaban.png"];
    UIImage *bgImage = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [imageView setImage:bgImage];
    //    imageView.backgroundColor = [UIColor redColor] ;
    [self.view addSubview:imageView];
    
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
