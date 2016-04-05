//
//  RadarController.m
//  OneHelper
//
//  Created by qiuxuewei on 16/3/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "RadarController.h"
#import "XWRadarView.h"
#import "MBProgressHUD.h"
#import "DiffusionController.h"
#import "JokeImageData.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "XWAnnotationView.h"
#import "LocusController.h"

@interface RadarController ()<XWRadarViewDataSource,XWRadarViewDelegate,MAMapViewDelegate,UIGestureRecognizerDelegate>{
    //蒙版
    MBProgressHUD *_MB;
    //当前圆的半径
    CGFloat _radius;
    //找到小孩提示框
    UIAlertController *_haveFoundAC;
    //模拟孩子头像数组
    NSMutableArray *iconImageArrM;
}
/** 扫描到的点数组 */
@property (nonatomic, strong) NSArray *pointsArray;
/** 背景地图 */
@property (nonatomic, strong) MAMapView *mapView;

/** 在地图上画的可行驶范围的圆 */
@property (nonatomic, strong) MACircle *circle;
@property (nonatomic, strong) NSMutableArray *annoArr;

@end

@implementation RadarController
#pragma mark - 懒加载
-(NSMutableArray *)annoArr{
    if (_annoArr == nil) {
        _annoArr = [[NSMutableArray alloc] init];
    }
    return _annoArr;
}
-(MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] init];
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        //显示定位
        [_mapView setShowsUserLocation:YES];
        //追踪用户位置的更新
        [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
        [_mapView setDelegate:self];
        //设置设定定位的最小更新距离
        [_mapView setDistanceFilter:10.f];
        //设定定位精度
        _mapView.desiredAccuracy = kCLLocationAccuracyBest;

//        [_mapView setZoomLevel:15.1 animated:YES];
        
    }
    return _mapView;
}

#pragma mark - 系统视图
- (void)viewDidLoad {
    [super viewDidLoad];
    //配置KEY
    [MAMapServices sharedServices].apiKey = @"29742273d0d933f9946742088a0a9d69";
    //模拟数据
    _radius = 10;
    iconImageArrM = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        NSString *iconName = [NSString stringWithFormat:@"qq%d",i];
        [iconImageArrM addObject:[UIImage imageNamed:iconName]];
    }
    [self creatChildViews];
}
//创建子视图
-(void)creatChildViews{
    //RightItemBtn
    [self creatRightItemBtn];
    //MAP
    [self creatMapView];
    //雷达扫描视图
    [self creatRadarView];
    //text按钮
    [self creatButton];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_radarView scan];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //离开界面添加重新搜索按钮
}
#pragma mark - 类内方法
//创建右侧itemBtn
-(void)creatRightItemBtn{
    //自定义BarButtonItem
    UIButton *cleanUpAllAnnoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanUpAllAnnoBtn setBackgroundImage:[UIImage imageNamed:@"cleanUP"] forState:UIControlStateNormal];
    [cleanUpAllAnnoBtn setFrame:CGRectMake(0, 0, 32, 32)];
    [cleanUpAllAnnoBtn addTarget:self action:@selector(cleanUpAllAnno) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *locationBarBtnCustom = [[UIBarButtonItem alloc] initWithCustomView:cleanUpAllAnnoBtn];
    self.navigationItem.rightBarButtonItem = locationBarBtnCustom;

}
//创建地图
-(void)creatMapView{
    [self.view addSubview:self.mapView];
}
//添加雷达视图
-(void)creatRadarView{
    //雷达视图
    XWRadarView *radarView = [[XWRadarView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth, kScreenHeight)];
    radarView.dataSource = self;
    radarView.delegate = self;
    radarView.radius = 180;
    radarView.imgradius=38;
    radarView.backgroundColor =  [UIColor clearColor];
    //    radarView.PersonImage=[UIImage imageNamed:@"dogIcon"];
    radarView.labelText = @"正在搜索附近目标...";
    [self.view addSubview:radarView];
    _radarView = radarView;
    [_radarView scan];
}

//按钮
-(void)creatButton{
    //进入搜索轨迹界面
    UIButton *LocusBtn = [[UIButton alloc] initWithFrame:CGRectMake(24, 64, 64, 64)];
//    [LocusBtn setBackgroundColor:colorWithRGBA(237, 237, 75, 0.7)];
    [LocusBtn setImage:[UIImage imageNamed:@"search_128px"] forState:UIControlStateNormal];
    [LocusBtn addTarget:self action:@selector(LocusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LocusBtn];
    
    //开始定位
    UIButton *beginFoundBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 84, kScreenHeight - 194, 64, 64)];
//    [addAnnotationBtn setFrame:CGRectMake(200, 200, 64, 64)];
//    [addAnnotationBtn setBackgroundColor:colorWithRGBA(123, 88, 156, 0.8)];
    [beginFoundBtn setImage:[UIImage imageNamed:@"iconHH"] forState:UIControlStateNormal];
    [beginFoundBtn addTarget:self action:@selector(addAnnotation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginFoundBtn];
    
    //结束扫描和定位->
    UIButton *stopFoundBtn = [[UIButton alloc] initWithFrame:CGRectMake(24, kScreenHeight - 194, 64, 64)];
    //    [addAnnotationBtn setFrame:CGRectMake(200, 200, 64, 64)];
    //    [addAnnotationBtn setBackgroundColor:colorWithRGBA(123, 88, 156, 0.8)];
    [stopFoundBtn setImage:[UIImage imageNamed:@"orange_stop"] forState:UIControlStateNormal];
    [stopFoundBtn addTarget:self action:@selector(stopFoundBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopFoundBtn];
}
//开始扫描
-(void)addAnnotation{
    NSLog(@"addAnnotation");
    [_radarView scan];
    //定位
    [_mapView setShowsUserLocation:YES];
}
//结束扫描
-(void)stopFoundBtnClick{
    [_radarView stop];
    //停止定位
    [_mapView setShowsUserLocation:NO];
}
//清除所有标注
-(void)cleanUpAllAnno{
    if (_annoArr.count != 0) {
        [_mapView removeAnnotations:_annoArr];
    }
}
//进入轨迹搜索界面
-(void)LocusBtnClick{
    LocusController *locusVC = [[LocusController alloc] init];
    [locusVC.navigationItem setTitle:@"搜寻丢失孩子的轨迹"];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    [locusVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:locusVC animated:YES];
}
#pragma mark - XHRadarViewDataSource
- (NSInteger)numberOfSectionsInRadarView:(XWRadarView *)radarView {
    return 4;
}
- (NSInteger)numberOfPointsInRadarView:(XWRadarView *)radarView {
    return 3;
}

#pragma mark - XHRadarViewDelegate
- (void)radarView:(XWRadarView *)radarView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"didSelectItemAtIndex:%lu", (unsigned long)index);
}

#pragma mark - MAMapAPI
//自定义标注
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"XWAnnotationReuseIndetifier";
        XWAnnotationView *annotationView = (XWAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[XWAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        //设置大头针头像
#warning iconText
        NSInteger i = (NSInteger)arc4random_uniform(10);
        NSLog(@"随机第 %ld 张照片...",i);
        annotationView.annoImage = [iconImageArrM objectAtIndex:i];//[UIImage imageNamed:@"baby"];
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

#pragma mark - 类内方法
//传入半径画圆
-(void)printCircleWithRadius:(CGFloat)radius{
    //在当前位置画圆
    _circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(self.mapView.userLocation.location.coordinate.latitude, self.mapView.userLocation.location.coordinate.longitude) radius:radius];
    //根据半径判断缩放级别
    [_mapView setZoomLevel:19.0f animated:YES];
    //在地图上添加圆
    [_mapView addOverlay: _circle];
}

//画圆
-(void)printCirle{
    if (_circle) {
        //已经存在圆先移除,先移除当前圆
        [_mapView removeOverlay:_circle];
    }
    //在当前位置画圆
    [self printCircleWithRadius:_radius];
    
}

#pragma mark - 代理
-(void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"定位失败: %@",error);
}

//定位
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //实时画圆
        [self printCirle];
        //实时将用户位置设为地图中心
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude) animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //测试->
            if (YES) {
                //提醒用户发现目标
                _haveFoundAC = [UIAlertController alertControllerWithTitle:@"提示" message:@"在周围发现丢失的小孩 " preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *haveFoundAA = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    //添加自定义annotation标注
                    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
                    pointAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude); //双井:116.461816,39.893506  //蒲安里:116.418954,39.862433 //刘家窑南里:116.418042,39.859171
                    [_mapView addAnnotation:pointAnnotation];
                    [self.annoArr addObject:pointAnnotation];
                    
                }];
                [_haveFoundAC addAction:haveFoundAA];
                [self presentViewController:_haveFoundAC animated:YES completion:nil];
                //两秒后弹窗自动消失
                //                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            }
        });
        
    }
}
//弹窗自动消失
-(void) performDismiss:(NSTimer *)timer
{
    [_haveFoundAC dismissViewControllerAnimated:YES completion:nil];
}

//画圆
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
        //圆边框的宽度
        circleView.lineWidth = 1.f;
        circleView.strokeColor = colorWithRGBA(0, 130, 251, 1.0f);
        circleView.fillColor = colorWithRGBA(0, 130, 251, 0.3f);
        return circleView;
    }
    return nil;
}

#pragma mark - 测试
-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"当前缩放比例(zoomlevel): %.2f",self.mapView.zoomLevel);
}

@end