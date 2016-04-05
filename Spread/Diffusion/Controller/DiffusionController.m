//
//  DiffusionController.m
//  OneHelper
//
//  Created by qiuxuewei on 16/3/7.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "DiffusionController.h"
#import "XWCardView.h"
#import "UIColor+FlatColors.h"
#import "ZLSwipeableView.h"
//#import "MainViewController.h"
#import "MBProgressHUD.h"
//#import "OneNew.h"
//#import "OneNewImage.h"
#import "JumpButton.h"
#import "OneDetailsController.h"
#import "SDWebImageManager.h"
#import "JokeImageData.h"

#define kBackgroundColor [UIColor colorWithRed:246 green:244 blue:247 alpha:1]


@interface DiffusionController ()<ZLSwipeableViewDataSource,ZLSwipeableViewDelegate>{
    UIView *_mainView;
    /** 新闻数组 */
    
    /** 蒙版 */
    MBProgressHUD *_MB;
    /** 卡片视图 */
//    ZLSwipeableView *_swipeableView;
    NSInteger _indexNum;
    
}

/** 喜欢 */
@property (nonatomic, strong) UILabel *likeLabel;
/** 屏蔽 */
@property (nonatomic, strong) UILabel *dislikeLabel;
/** 不同颜色 */
@property (nonatomic, strong) NSArray *colors;
/** 每个自定义视图序列 */
@property (nonatomic) NSUInteger customViewIndex;//customViewIndex
@property (nonatomic) BOOL loadCardFromXib;

//下载队列
@property (nonatomic, strong) NSOperationQueue *queue;

//存放所有下载操作的字典
@property (nonatomic, strong) NSMutableDictionary *operations;

@end

@implementation DiffusionController
-(NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:20];
    }
    return _queue;
}
#pragma mark - 初始化
-(instancetype)initWithJokeImageArr:(NSArray *)jokeImageArr{
    self = [super init];
    if (self) {
        self.jokeImageArr = jokeImageArr;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    [self.view setBackgroundColor:kBackgroundColor];
    [self addChildViews];
    
}

//内存警告
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
    
}
#pragma mark - 类内方法
//展示提醒框
-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message{
    UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *AlertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"关闭!!! ->>>>>>");
    }];
    UIAlertAction *radarAlertAction = [UIAlertAction actionWithTitle:@"雷达" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"当前一共有 %ld 个子视图!!!!!",[self.swipeableView activeViews].count);
        [self.swipeableView rewind];
//         [self.swipeableView discardAllViews];
//        [self.swipeableView loadViewsIfNeeded];
//        MainViewController *radarVC = [[MainViewController alloc] init];
//        [self.navigationController pushViewController:radarVC animated:YES];
    }];
    [AlertController addAction:AlertAction];
    [AlertController addAction:radarAlertAction];
    [self presentViewController:AlertController animated:YES completion:nil];
}
//关闭按钮
-(void)cacelBtnClick{
    NSLog(@"关闭!!!");
    [self.navigationController popViewControllerAnimated:YES];
//    UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已点击关闭" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *AlertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击关闭!!!");
//    }];
//    [AlertController addAction:AlertAction];
//    [self presentViewController:AlertController animated:YES completion:nil];
}
//更多按钮
-(void)moreBtnClick{
    NSLog(@"更多!!!");
    [self showAlertWithTitle:nil andMessage:@"您单击更多了..."];
}

//添加子控制器
-(void)addChildViews{
    //关闭(返回按钮)
    //    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    //
    //    [cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
    //    [cancelBtn setTintColor:tintColor];
    //    [self.view addSubview:cancelBtn];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(cacelBtnClick)];
//    self.title = @"趣图";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreBtnClick)];
    
    self.customViewIndex = 0;
    self.colors = self.jokeImageArr;
    _indexNum = 0;
    //自定义卡片视图
    [self customSwipeableView];
    
    //自定义喜欢不喜欢label
//    [self customLikeOrDislikeLB];
}

- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}

////下载操作-异步线程
//-(void)downloadHalfImageWithURL:(NSString *)URL imageName:(NSString *)imageName{
//    @autoreleasepool {
//        NSLog(@"卡片视图中-》》》》》当期啊线程编号：%@",[NSThread currentThread]);
//        //子线程里面的runloop默认不开启，也就意味着不会自动创建自动释放池，子线程里面autorelease的对象 就会没有池子释放。也就一位置偶棉没有办法进行释放造成内存泄露,所以需要手动创建
//        
//        //1.获取本地cache文件路径
//        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        //2.根据文件URL最后文件名作为文件名保存到本地 -> 文件名
//        NSString *imageFilePath = [cachePath stringByAppendingPathComponent:imageName];
//        
//        //如果当前文件名在cache文件夹中不存在，写入文件
//        if (![self isFileExist:imageName]) {
//            //下载图片
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
//            //初始化图片
//            UIImage *image = [UIImage imageWithData:imageData];
//            //将下载的图片保存到本地
//            //3.写入文件
//            //            [UIImagePNGRepresentation(image) writeToFile:imageFilePath atomically:YES];
//            dispatch_async(kGlobalQueue, ^{
//                
//                //或者->(此方法会减少缓存大小，但是图片会不清晰)
//                [UIImageJPEGRepresentation(image, 0.8) writeToFile:imageFilePath atomically:YES];
//                
//            });
//        }
//        // 从字典中移除下载操作 (防止operations越来越大，保证下载失败后，能重新下载)
//        [self.operations removeObjectForKey:imageName];
//
//    }
//}
//判断文件是否已经在沙盒中已经存在？
-(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在？：%@",result?@"存在":@"不存在");
    return result;
}

//自定义卡片视图
-(void)customSwipeableView{
    
    if (self.swipeableView == nil) {
        NSLog(@"移除之前视图上有几个子视图啊: %ld",self.view.subviews.count);
        [self.swipeableView removeFromSuperview];
        NSLog(@"现在视图上有几个子视图啊: %ld",self.view.subviews.count);
    }
    
    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
    self.swipeableView = swipeableView;
    [self.view addSubview:self.swipeableView];
    
    // Required Data Source
    self.swipeableView.dataSource = self;
    
    // Optional Delegate
    self.swipeableView.delegate = self;
    
    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *metrics = @{};
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-50-[swipeableView]-50-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-120-[swipeableView]-100-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
    //移动手势
    //    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    //    [_mainView addGestureRecognizer:pan];
    
}

-(void)customLikeOrDislikeLB{
    //自定义label
    /** 上滑扩散 */
    UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 74, kScreenWidth, 44)];
    _likeLabel = likeLabel;
    [likeLabel setText:@"上滑扩散..."];
    [likeLabel setTextColor:[UIColor grayColor]];
    [likeLabel setTextAlignment:NSTextAlignmentCenter];
    
    UIButton *likeBtn = [[UIButton alloc] initWithFrame:likeLabel.frame];
    [likeBtn setBackgroundColor:[UIColor clearColor]];
    [likeBtn addTarget:self action:@selector(handleUplike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeLabel];
    [self.view addSubview:likeBtn];
    
    /** 下滑屏蔽 */
    UILabel *dislikeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 590, kScreenWidth, 44)];
    _dislikeLabel = dislikeLabel;
    [dislikeLabel setText:@"下滑屏蔽..."];
    [dislikeLabel setTextColor:[UIColor grayColor]];
    [dislikeLabel setTextAlignment:NSTextAlignmentCenter];
    
    UIButton *dislikeBtn = [[UIButton alloc] initWithFrame:dislikeLabel.frame];
    [dislikeBtn setBackgroundColor:[UIColor clearColor]];
    [dislikeBtn addTarget:self action:@selector(handleDownDislike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dislikeLabel];
    [self.view addSubview:dislikeBtn];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex");
    self.loadCardFromXib = buttonIndex == 1;
    self.customViewIndex = 0;
    [self.swipeableView discardAllViews];
    [self.swipeableView loadViewsIfNeeded];
}

#pragma mark - 上滑下滑
#define kSwipeTimeInterval 0.6F
- (void)handleUplike{
    [self.swipeableView swipeTopViewToUp];
    [_likeLabel setTextColor:[UIColor clearColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kSwipeTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_likeLabel setTextColor:[UIColor grayColor]];
    });
}

- (void)handleDownDislike{
    [self.swipeableView swipeTopViewToDown];
    [_dislikeLabel setTextColor:[UIColor clearColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kSwipeTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_dislikeLabel setTextColor:[UIColor grayColor]];
    });
}
#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    if (self.customViewIndex >= self.colors.count) {
        self.customViewIndex = 0;
    }
    NSLog(@"这是一块不一样的View视图...当前indexpath :%ld",self.customViewIndex);
    XWCardView *mainCardView = [[XWCardView alloc] initWithFrame:swipeableView.bounds];
    [mainCardView setBackgroundColor:[UIColor whiteColor]];
    [self customCardView:mainCardView withIndex:self.customViewIndex];
    
    self.customViewIndex++;
    
    if (self.loadCardFromXib) {
        UIView *contentView =
        [[NSBundle mainBundle] loadNibNamed:@"CardContentView" owner:self options:nil][0];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [mainCardView addSubview:contentView];

        NSDictionary *metrics =
        @{ @"height" : @(mainCardView.bounds.size.height),
           @"width" : @(mainCardView.bounds.size.width) };
        NSDictionary *views = NSDictionaryOfVariableBindings(contentView);
        [mainCardView addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[contentView(width)]"
                              options:0
                              metrics:metrics
                              views:views]];
        [mainCardView addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[contentView(height)]"
                              options:0
                              metrics:metrics
                              views:views]];
    }
    return mainCardView;
}

#pragma mark - 类内方法
//自定义卡片视图
-(void)customCardView:(XWCardView *)mainCardView withIndex:(NSInteger)index{
    
    JokeImageData *jokeImageData = [self.jokeImageArr objectAtIndex:index];
    
#pragma mark - 顶部View 包括:昵称+头像+性别+发布时间
    //顶部View 包括:昵称+头像+性别+发布时间
    UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainCardView.bounds.size.width, 64)];
    [mainCardView addSubview:userInfoView];
    
    //头像
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 56, 56)];
    [iconImageView setImage:[UIImage imageNamed:@"dogIcon"]];
    [userInfoView addSubview:iconImageView];
    
    //昵称
    UILabel *userNameLB = [[UILabel alloc] initWithFrame:CGRectMake(64, 10, 64, 44)];
    [userNameLB setFont:[UIFont systemFontOfSize:14.0f]];
    [userNameLB setAdjustsFontSizeToFitWidth:YES];
    [userNameLB setText:@"用户昵称"];
    [userInfoView addSubview:userNameLB];
    
    //发布时间   "2016-03-11 17:33:15"
    UILabel *pubTimeLB = [[UILabel alloc] initWithFrame:CGRectMake((mainCardView.bounds.size.width - 4 - 80), 10, 80, 44)];
//    [pubTimeLB setBackgroundColor:colorWithRGBA(201, 15, 143, 0.5)];
    [pubTimeLB setAdjustsFontSizeToFitWidth:YES];
    [pubTimeLB setText:@"03-07 12:11"];
    [pubTimeLB setText:[self getDateStr:jokeImageData.updatetime]];
    [userInfoView addSubview:pubTimeLB];
    
    //添加个人信息视图
    [mainCardView addSubview:userInfoView];
    
#pragma mark - 卡片图片
    //照片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 69, mainCardView.bounds.size.width - 8, mainCardView.bounds.size.height - 5 - 69)];
//    NSError *error;
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:jokeImageData.url] options:NSDataReadingMappedIfSafe error:&error]];
//    [imageView setImage:image];
    //从沙盒中获取图片
//    NSString *image
    //1.获取本地cache文件路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //2.根据文件URL最后文件名作为文件名保存到本地 -> 文件名
    NSString *imageFilePath = [cachePath stringByAppendingPathComponent:jokeImageData.hashId];
    //3.获取文件保存的数据
    NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath];
    
    [imageView setImage:[UIImage imageWithData:imageData]];
    [mainCardView addSubview:imageView];
    
    //照片中文字
    UILabel *textLB = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.size.height - 64, imageView.frame.size.width, 64)];
    [textLB setNumberOfLines:2];
//    [textLB setText:@"今天心情不错,又解决了一个难题!fighting man!"];
    [textLB setText:jokeImageData.content];
    [textLB setTextColor:[UIColor whiteColor]];
    [textLB setTextAlignment:NSTextAlignmentCenter];
    [imageView addSubview:textLB];
    
//#pragma mark - 跳转按钮
//    //跳转按钮
//    JumpButton *jumpBtn = [[JumpButton alloc] initWithFrame:imageView.frame];
//    jumpBtn.indexNum = index;
//    [jumpBtn addTarget:self action:@selector(jumpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [mainCardView addSubview:jumpBtn];
//    
}

#pragma mark - 截取时间字符串  "2016-03-11 17:33:15"
-(NSString *)getDateStr:(NSString *)date{
    if (date.length < 11) {
        return nil;
    }
    return [date substringWithRange:NSMakeRange(5, 11)];
}

-(void)jumpBtnClick:(JumpButton *)jumpBtn{
    NSLog(@"点击btn的indexpath :%ld",jumpBtn.indexNum);
    OneDetailsController *oneDetails = [[OneDetailsController alloc] init];
    [oneDetails setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:oneDetails animated:YES];
}
#pragma mark - ZLSwipeableViewDelegate
- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);
}

//取消滑动
- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
    [_dislikeLabel setTextColor:[UIColor grayColor]];
    [_likeLabel setTextColor:[UIColor grayColor]];
}

//开始点按滑动的坐标
- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    //    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

//当前滑动的坐标...
- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    //    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y,
    //          translation.x, translation.y);
    
    if (translation.y < 0) {
        [_dislikeLabel setTextColor:[UIColor grayColor]];
        _likeLabel.textColor = [UIColor clearColor];
    }
    if (translation.y > 0) {
        [_likeLabel setTextColor:[UIColor grayColor]];
        _dislikeLabel.textColor = [UIColor clearColor];
    }
}

//结束滑动
- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    //    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
    [_dislikeLabel setTextColor:[UIColor grayColor]];
    [_likeLabel setTextColor:[UIColor grayColor]];
}




//移动手势
-(void)panGesture:(UIPanGestureRecognizer *)gesture
{
    //translationInView这个函数是得到触点在屏幕上与开始触摸点的位移值
    CGPoint distance = [gesture translationInView:self.view];
    //设置视图的中心位置
    gesture.view.center = CGPointMake(self.view.center.x+0, self.view.center.y+distance.y);
    //重置视图的偏移量
    NSLog(@"偏移的Y: %f",distance.y);
    if (distance.y >= 3) {
        NSLog(@"感兴趣");
        [self handleUplike];
    }else if (distance.y <= -3){
        NSLog(@"屏蔽");
        [self handleDownDislike];
    }else{
        [gesture setTranslation:CGPointZero inView:self.view];
    }
    NSLog(@"移动了");
}
#pragma mark - 渐变


@end
