
//
//  XWAlertViewController.m
//  Spread
//
//  Created by 邱学伟 on 16/3/28.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWAlertViewController.h"

//定义枚举类型
typedef enum {
    ENUMStyle_ActionSheet=0, //UIAlertControllerStyleActionSheet
    ENUMStyle_Alert          //UIAlertControllerStyleAlert
} ENUM_AlertControllerStyle;


@interface XWAlertViewController (){
    //AlertControllerTitle
    NSString *_AlertControllerTitle;
    //AlertMessage
    NSString *_AlertMessage;
    // 提醒类型(UIAlertControllerStyle)-> UIAlertControllerStyleActionSheet = 0, UIAlertControllerStyleAlert
    ENUM_AlertControllerStyle _AlertControllerStyle;
}

/** 提醒信息 */
//@property (nonatomic, copy) NSString *alertMessage;


//提醒控制器
@property (nonatomic, strong) UIAlertController *myAlertController;

//提醒事件
@property (nonatomic, strong) UIAlertAction *OKAlertAction;

//取消事件
@property (nonatomic, strong) UIAlertAction *CancelAlertAction;

@end

@implementation XWAlertViewController

-(instancetype)initWithAlertControllerTitle:(NSString *)alertControllerTitle withAlertMessage:(NSString *)alertMessage withAlertControllerStyle:(ENUM_AlertControllerStyle)alertControllerStyle{
    self = [super init];
    if (self) {
        //UIAlertController->
        _AlertControllerTitle = alertControllerTitle;
        _AlertMessage = alertMessage;
        _AlertControllerStyle = alertControllerStyle;
        
        //
        
        [self privateInit];
    }
    return self;
}
-(void)privateInit{
    if (_AlertMessage.length == 0) {
        _AlertMessage = @"提醒用户的消息";
    }
    
    //UIAlertController->
    UIAlertControllerStyle alertControllerStyle;
    alertControllerStyle = ((_AlertControllerStyle == ENUMStyle_ActionSheet)?UIAlertControllerStyleActionSheet:UIAlertControllerStyleAlert);
    
    self.myAlertController = [UIAlertController alertControllerWithTitle:_AlertControllerTitle message:_AlertMessage preferredStyle:alertControllerStyle];
    
    //UIAlertAction ->OK
    UIAlertAction *OKAlertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
    }];
    [self.myAlertController addAction:OKAlertAction];
    
    //UIAlertAction ->取消
    UIAlertAction *CancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [self.myAlertController addAction:CancelAlertAction];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/** 展示提醒框 */
-(void)show{
//    [self getCurrentVC] presentViewController:self.my animated:<#(BOOL)#> completion:<#^(void)completion#>
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
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
