//
//  SharingLinkWebController.m
//  Spread
//
//  Created by 邱学伟 on 16/4/13.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "SharingLinkWebController.h"

#import "MBProgressHUD.h"
#import <WebKit/WebKit.h>

@interface SharingLinkWebController ()<WKNavigationDelegate>{
    //蒙版
    MBProgressHUD *_MB;
}
@property (nonatomic, strong) WKWebView *WKWebView;
@end
@implementation SharingLinkWebController
#pragma mark - 懒加载
-(WKWebView *)WKWebView{
    if (_WKWebView == nil) {
        _WKWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44)];
        NSLog(@"链接：%@",self.linkStr);
        NSURL *comURL = [NSURL URLWithString:self.linkStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:comURL];
        [_WKWebView setNavigationDelegate:self];
        [_WKWebView loadRequest:request];
    }
    return _WKWebView;
}
#pragma mark - 视图加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置中间标题
    [self.navigationItem setTitle:@"分享"];
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
    NSLog(@"didFinishNavigation");
    dispatch_async(kMainQueue, ^{
        [_MB hideAnimated:YES];
    });
}
//加载失败
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    dispatch_async(kMainQueue, ^{
        [_MB hideAnimated:YES];
    });
}

@end
