//
//  CustomTabBarController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/21.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "CustomTabBarController.h"

/** 导入自控制器 */
#import "RankingController.h"
#import "ChattingController.h"
#import "PersonController.h"
#import "PublishController.h"
#import "LocusController.h"

#import "CustomTabBar.h"
//#import "DiffusionController.h"
#import "RadarController.h"

#import "XWMenuPopView.h"
#import "DiscoverMainController.h"


@interface CustomTabBarController ()<MenuPopDelegate>{
    
}

//子视图
/** 雷达视图 */
@property (nonatomic, strong) RadarController *radarVC;

/** 热度视图 */
@property (nonatomic, strong) RankingController *rankingVC;

/** 聊天视图(迭代) */
@property (nonatomic, strong) ChattingController *chattingVC;

/** 轨迹视图 */
@property (nonatomic, strong) LocusController *locusVC;

/** 个人信息视图 */
@property (nonatomic, strong) PersonController *personVC;

/** 发现页 */
@property (nonatomic, strong) DiscoverMainController *discoverMainVC;

//@property (nonatomic, strong) XWMenuPopView *menuPopView;


@end

@implementation CustomTabBarController

#pragma mark - 设计单例模式
static id _instance;
//重写allocWithZone:方法
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}
//提供类方法让外界访问唯一的实例
+(instancetype)shareInstance{
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}
//实现copyWithZone方法
-(id)copyWithZone:(struct _NSZone *)zone{
    return _instance;
}

#pragma mark - 懒加载
-(RadarController *)radarVC{
    if (_radarVC == nil) {
        _radarVC = [[RadarController alloc] init];
    }
    return _radarVC;
}
-(RankingController *)rankingVC{
    if (_rankingVC == nil) {
        _rankingVC = [[RankingController alloc] init];
    }
    return _rankingVC;
}
-(LocusController *)locusVC{
    if (_locusVC == nil) {
        _locusVC = [[LocusController alloc] init];
    }
    return _locusVC;
}
-(PersonController *)personVC{
    if (_personVC == nil) {
        _personVC = [[PersonController alloc] init];
    }
    return _personVC;
}
-(DiscoverMainController *)discoverMainVC{
    if (_discoverMainVC == nil) {
        _discoverMainVC = [[DiscoverMainController alloc] init];
    }
    return _discoverMainVC;
}
#pragma mark - 视图
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置TabbarItem选中和不选中 Attributes颜色
    [self setUpTabBarItemTextAttributes];
    
    //添加子控制器
    [self setUpChildViewControllers];
    
    //tabbar背景颜色 -> 颜色转图片
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    
    //去除tabbar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //设置导航控制器颜色
    [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:[UIColor yellowColor]] forBarMetrics:UIBarMetricsDefault];
    
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    
     self.menuPopView = [[XWMenuPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.menuPopView setMenuPopDelegate:self];
    [self.view addSubview:self.menuPopView];
    
}

/** 选择相应功能 */
-(void)XWMenuPopView:(XWMenuPopView *)MenuPopView didSelectedMenuIndex:(NSInteger)selectedIndex{
    NSLog(@"点击的是第 %ld 个按钮",selectedIndex);
    
    //根据选中的不同按钮的tag判断进入相应的界面->
    
    
    PublishController *publishVC = [[PublishController alloc] init];
    [publishVC.navigationItem setTitle:@"发布"];
    [self presentViewController:publishVC animated:YES completion:nil];
}

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    
    [self setValue:[[CustomTabBar alloc] init] forKey:@"tabBar"];
}

/**
 添加子控制器
 */
-(void)setUpChildViewControllers{
    
    //代码只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //设置顶部title
        [self.radarVC.tabBarItem setTitle:@"搜索"];
        [self.rankingVC.tabBarItem setTitle:@"寻人"];
        [self.discoverMainVC.tabBarItem setTitle:@"发现"];
        [self.personVC.tabBarItem setTitle:@"个人信息"];
        
        [self.radarVC.navigationItem setTitle:@"搜寻附近迷失的孩子"];
        [self.rankingVC.navigationItem setTitle:@"寻人热度排行"];
        [self.discoverMainVC.navigationItem setTitle:@"发现"];
        [self.personVC.navigationItem setTitle:@"个人信息"];
        
        //设置图片
        [self.radarVC.tabBarItem setImage:[UIImage imageNamed:@"home_normal"]];
        [self.rankingVC.tabBarItem setImage:[UIImage imageNamed:@"mycity_normal"]];
        [self.discoverMainVC.tabBarItem setImage:[UIImage imageNamed:@"message_normal"]];
        [self.personVC.tabBarItem setImage:[UIImage imageNamed:@"account_normal"]];
        
        //设置高亮图片
        //渲染模式 - UIImageRenderingModeAlwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
        UIImage *radarVCSelectedImage = [UIImage imageNamed:@"home_highlight"];
        radarVCSelectedImage = [radarVCSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.radarVC.tabBarItem.selectedImage = radarVCSelectedImage;
        
        UIImage *rankingVCSelectedImage = [UIImage imageNamed:@"mycity_highlight"];
        rankingVCSelectedImage = [rankingVCSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.rankingVC.tabBarItem.selectedImage = rankingVCSelectedImage;
        
        UIImage *chattingVCSelectedImage = [UIImage imageNamed:@"message_highlight"];
        chattingVCSelectedImage = [chattingVCSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.discoverMainVC.tabBarItem.selectedImage = chattingVCSelectedImage;
        
        UIImage *personVCSelectedImage = [UIImage imageNamed:@"account_highlight"];
        personVCSelectedImage = [personVCSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.personVC.tabBarItem.selectedImage = personVCSelectedImage;
        
        //使用navigation容器
        UINavigationController *radarNav = [[UINavigationController alloc] initWithRootViewController:self.radarVC];
        UINavigationController *rankingNav = [[UINavigationController alloc] initWithRootViewController:self.rankingVC];
        UINavigationController *discoverMainNav = [[UINavigationController alloc] initWithRootViewController:self.discoverMainVC];
        UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:self.personVC];
        
        self.viewControllers = @[radarNav,rankingNav,discoverMainNav,personNav];
    });
    
    
//    self setViewControllers:<#(NSArray<__kindof UIViewController *> * _Nullable)#>
//    [self addOneChildViewController:radarNav
//                          WithTitle:@"雷达"
//                          imageName:@"home_normal"
//                  selectedImageName:@"home_highlight"];
//    
//    [self addOneChildViewController:rankingNav
//                          WithTitle:@"热度"
//                          imageName:@"mycity_normal"
//                  selectedImageName:@"mycity_highlight"];
//    
//    
//    [self addOneChildViewController:chattingNav
//                          WithTitle:@"轨迹"
//                          imageName:@"message_normal"
//                  selectedImageName:@"message_highlight"];
//    
//    
//    [self addOneChildViewController:personNav
//                          WithTitle:@"个人信息"
//                          imageName:@"account_normal"
//                  selectedImageName:@"account_highlight"];
    
}

/**
 设置TabbarItem选中和不选中 Attributes颜色
 */
-(void)setUpTabBarItemTextAttributes{
    
    //普通状态文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //选中状态下
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    //设置文字属性
    //获取当前 UITabBarItem 属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

//color -> image
-(UIImage *)imageWithColor:(UIColor *)color{
    NSParameterAssert(color != nil);
    CGRect rect = CGRectMake(0, 0, 1, 1);
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
