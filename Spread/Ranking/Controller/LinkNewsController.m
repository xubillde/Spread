//
//  LinkNewsController.m
//  OneHelper
//
//  Created by qiuxuewei on 16/3/6.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "LinkNewsController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"

@interface LinkNewsController ()<WKNavigationDelegate>{
    //蒙版
    MBProgressHUD *_MB;
}
//网页视图
@property (nonatomic, strong) WKWebView *WKWebView;
@end

@implementation LinkNewsController
#pragma mark - 懒加载
-(WKWebView *)WKWebView{
    if (_WKWebView == nil) {
        _WKWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        NSLog(@"网页链接-->link:%@",self.link);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.link]];
        [_WKWebView setNavigationDelegate:self];
        [_WKWebView loadRequest:request];
    }
    return _WKWebView;
}
#pragma mark - 视图加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.WKWebView];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_MB) {
        [_MB hideAnimated:YES];
    }
}

#pragma mark - WKNavigationDelegate
//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didStartProvisionalNavigation");
    dispatch_async(kMainQueue, ^{
        _MB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_MB setMode:MBProgressHUDModeIndeterminate];
        [_MB.label setText:@"loading..."];
    });
}
//加载成功
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"didFinishNavigation__");
    dispatch_async(kMainQueue, ^{
        [_MB hideAnimated:YES];
    });
}
//加载失败
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"");
    dispatch_async(kMainQueue, ^{
        [_MB hideAnimated:YES];
    });
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
