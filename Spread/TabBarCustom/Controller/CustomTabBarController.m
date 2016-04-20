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
#import "XWPublishController.h"

#import "CustomTabBar.h"
//#import "DiffusionController.h"
#import "RadarController.h"

#import "XWMenuPopView.h"
#import "DiscoverMainController.h"

//发布照片
#import "PublishController.h"
#import "UzysAssetsPickerController.h"

@interface CustomTabBarController ()<MenuPopDelegate,UzysAssetsPickerControllerDelegate>{
    
}

//子视图
/** 发现页 */
@property (nonatomic, strong) DiscoverMainController *discoverMainVC;

/** 新闻视图 */
@property (nonatomic, strong) RankingController *rankingVC;

/** 雷达视图 */
@property (nonatomic, strong) RadarController *radarVC;

/** 个人信息视图 */
@property (nonatomic, strong) PersonController *personVC;


////子视图
///** 聊天视图(迭代) */
//@property (nonatomic, strong) ChattingController *chattingVC;
//
///** 轨迹视图 */
//@property (nonatomic, strong) LocusController *locusVC;

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
//寻觅
-(RadarController *)radarVC{
    if (_radarVC == nil) {
        _radarVC = [[RadarController alloc] init];
    }
    return _radarVC;
}
//天下事
-(RankingController *)rankingVC{
    if (_rankingVC == nil) {
        _rankingVC = [[RankingController alloc] init];
    }
    return _rankingVC;
}
//个人信息
-(PersonController *)personVC{
    if (_personVC == nil) {
        _personVC = [[PersonController alloc] init];
    }
    return _personVC;
}
//发现
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
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbarBg"]];
    
    //去除tabbar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //设置导航控制器颜色
    [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:ColorWithRGB(255, 209, 0)] forBarMetrics:UIBarMetricsDefault];
    
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
    
    if (selectedIndex == 1) {
        //发布照片
        UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
        picker.delegate = self;
        [picker setMaximumNumberOfSelectionVideo:0];
        [picker setMaximumNumberOfSelectionPhoto:9];
        [self presentViewController:picker animated:YES completion:nil];
    }
    
    
    XWPublishController *publishVC = [[XWPublishController alloc] init];
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
        [self.discoverMainVC.tabBarItem setTitle:@"发现"];
        [self.rankingVC.tabBarItem setTitle:@"天下事"];
        [self.radarVC.tabBarItem setTitle:@"寻人"];
        [self.personVC.tabBarItem setTitle:@"个人信息"];
        
        [self.discoverMainVC.navigationItem setTitle:@"发现"];
        [self.rankingVC.navigationItem setTitle:@"天下事"];
        [self.radarVC.navigationItem setTitle:@"寻人"];
        [self.personVC.navigationItem setTitle:@"个人信息"];
        
        //设置图片
        [self.discoverMainVC.tabBarItem setImage:[UIImage imageNamed:@"1"]];
        [self.rankingVC.tabBarItem setImage:[UIImage imageNamed:@"2"]];
        [self.radarVC.tabBarItem setImage:[UIImage imageNamed:@"search"]];
        [self.personVC.tabBarItem setImage:[UIImage imageNamed:@"55"]];
        
        //设置高亮图片
        //渲染模式 - UIImageRenderingModeAlwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
        UIImage *discoverVCSelectedImage = [UIImage imageNamed:@"11"];
        discoverVCSelectedImage = [discoverVCSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.discoverMainVC.tabBarItem.selectedImage = discoverVCSelectedImage;
        
        
        UIImage *rankingVCSelectedImage = [UIImage imageNamed:@"22"];
        rankingVCSelectedImage = [rankingVCSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.rankingVC.tabBarItem.selectedImage = rankingVCSelectedImage;
        
        UIImage *radarVCSelectedImage = [UIImage imageNamed:@"33"];
        radarVCSelectedImage = [radarVCSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.radarVC.tabBarItem.selectedImage = radarVCSelectedImage;
        
        UIImage *personVCSelectedImage = [UIImage imageNamed:@"4"];
        personVCSelectedImage = [personVCSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.personVC.tabBarItem.selectedImage = personVCSelectedImage;
        
        
        
//        UIImage *chattingVCSelectedImage = [UIImage imageNamed:@"message_highlight"];
//        chattingVCSelectedImage = [chattingVCSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        self.discoverMainVC.tabBarItem.selectedImage = chattingVCSelectedImage;
        
        //使用navigation容器
        //发现
        UINavigationController *discoverMainNav = [[UINavigationController alloc] initWithRootViewController:self.discoverMainVC];
        //天下事
        UINavigationController *rankingNav = [[UINavigationController alloc] initWithRootViewController:self.rankingVC];
        //寻觅
        UINavigationController *radarNav = [[UINavigationController alloc] initWithRootViewController:self.radarVC];
        //个人信息
        UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:self.personVC];
        
        self.viewControllers = @[discoverMainNav,rankingNav,radarNav,personNav];
    });
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


#pragma mark - 发布照片相关

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    NSLog(@"didFinishPickingAssets->>>assets.count:%ld",assets.count);
//    self.imageView.backgroundColor = [UIColor clearColor];
//    DLog(@"assets %@",assets);
//    if(assets.count ==1)
//    {
//        self.labelDescription.text = [NSString stringWithFormat:@"%ld asset selected",(unsigned long)assets.count];
//    }
//    else
//    {
//        self.labelDescription.text = [NSString stringWithFormat:@"%ld assets selected",(unsigned long)assets.count];
//    }
//    __weak typeof(self) weakSelf = self;
//    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
//    {
//        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            ALAsset *representation = obj;
//            
//            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
//                                               scale:representation.defaultRepresentation.scale
//                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
//            weakSelf.imageView.image = img;
//            *stop = YES;
//        }];
//        
//        
//    }
//    else //Video
//    {
//        ALAsset *alAsset = assets[0];
//        
//        UIImage *img = [UIImage imageWithCGImage:alAsset.defaultRepresentation.fullResolutionImage
//                                           scale:alAsset.defaultRepresentation.scale
//                                     orientation:(UIImageOrientation)alAsset.defaultRepresentation.orientation];
//        weakSelf.imageView.image = img;
//        
//        
//        
//        ALAssetRepresentation *representation = alAsset.defaultRepresentation;
//        NSURL *movieURL = representation.url;
//        NSURL *uploadURL = [NSURL fileURLWithPath:[[NSTemporaryDirectory() stringByAppendingPathComponent:@"test"] stringByAppendingString:@".mp4"]];
//        AVAsset *asset      = [AVURLAsset URLAssetWithURL:movieURL options:nil];
//        AVAssetExportSession *session =
//        [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
//        
//        session.outputFileType  = AVFileTypeQuickTimeMovie;
//        session.outputURL       = uploadURL;
//        
//        [session exportAsynchronouslyWithCompletionHandler:^{
//            
//            if (session.status == AVAssetExportSessionStatusCompleted)
//            {
//                DLog(@"output Video URL %@",uploadURL);
//            }
//            
//        }];
//        
//    }
    
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedStringFromTable(@"Exceed Maximum Number Of Selection", @"UzysAssetsPickerController", nil)
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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
