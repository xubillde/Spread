//
//  LocusController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/22.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  29742273d0d933f9946742088a0a9d69

#import "LocusController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#import "XWAnnotationView.h"

#import "SearchPersonController.h"

@interface LocusController ()<MAMapViewDelegate,SearchPersonDelegate>{
    //地图上的轨迹
    MAPolyline *_commonPolyline;
    //画两边端点 ->起点
    MACircle *_circleStart;
    //终点
    MACircle *_circleEnd;
   
}

//属性列表
/** 地图视图 */
@property (nonatomic, strong) MAMapView *mapView;

/** 搜索按钮 */
@property (nonatomic, strong) UIButton *searchPersonBtn;

/** 轨迹数组 */
@property (nonatomic, strong) NSMutableArray *OverlayArr;

@end

@implementation LocusController
#pragma mark - 懒加载
-(NSMutableArray *)OverlayArr{
    if (_OverlayArr == nil) {
        _OverlayArr = [[NSMutableArray alloc] init];
    }
    return _OverlayArr;
}
-(NSString *)nickName{
    if (_nickName == nil) {
        _nickName = [[NSString alloc] init];
    }
    return _nickName;
}
-(MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] init];
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        //显示定位
        [_mapView setShowsUserLocation:YES];
        [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
        _mapView.delegate = self;
//        _mapView.showsLabel = NO;

    }
    return _mapView;
}
-(UIButton *)searchPersonBtn{
    if (_searchPersonBtn == nil) {
        _searchPersonBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 455, 64, 64)];
//        [_searchPersonBtn setBounds:CGRectMake(0, 0, 64, 64)];
        [_searchPersonBtn setImage:[UIImage imageNamed:@"Search_People_512px"] forState:UIControlStateNormal];
        [_searchPersonBtn addTarget:self action:@selector(searchPersonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_searchPersonBtn setBackgroundColor:colorWithRGBA(212, 208, 207, 0.5)];
    }
    return _searchPersonBtn;
}


#pragma mark - 视图
-(void)viewDidLoad{
    [super viewDidLoad];
    //配置KEY
    [MAMapServices sharedServices].apiKey = @"29742273d0d933f9946742088a0a9d69";
    [self addChildViews];
}
-(void)addChildViews{
    //添加地图视图
    [self.view addSubview:self.mapView];
    //自定义右侧Item按钮
    [self creatRightItemBtn];
    //添加搜索按钮
    [self.view addSubview:self.searchPersonBtn];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    [_mapView setZoomLevel:16.1 animated:YES];
}
#pragma mark - 类内方法
//创建右侧itemBtn
-(void)creatRightItemBtn{
    //自定义BarButtonItem
    UIButton *cleanUpAllAnnoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanUpAllAnnoBtn setBackgroundImage:[UIImage imageNamed:@"cleanUP"] forState:UIControlStateNormal];
    [cleanUpAllAnnoBtn setFrame:CGRectMake(0, 0, 32, 32)];
    [cleanUpAllAnnoBtn addTarget:self action:@selector(cleanUpAllPolyline) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *locationBarBtnCustom = [[UIBarButtonItem alloc] initWithCustomView:cleanUpAllAnnoBtn];
    self.navigationItem.rightBarButtonItem = locationBarBtnCustom;
    
}
//清除轨迹信息
-(void)cleanUpAllPolyline{
    if (_OverlayArr.count != 0) {
        [_mapView removeOverlays:_OverlayArr];
        [self.navigationItem setTitle:@"寻找迷失孩子的轨迹"];
    }
}
-(void)searchPersonClick:(UIButton *)searchPersonBtn{
    NSLog(@"searchPersonClick...");
//    [self makeLocusWithLocation:[self simulateData]];
    
    SearchPersonController *searchVC = [[SearchPersonController alloc] init];
//    searchVC.delegate = self;
    __weak typeof(self) weakSelf = self;
    [searchVC passLocationWithLocationArr:^(NSDictionary *locationDict) {
         NSArray *locationArr = [locationDict objectForKey:@"locationArr"];
        [weakSelf makeLocusWithLocation:locationArr];
        NSString *nickName = [locationDict objectForKey:@"nickName"];
        [weakSelf.navigationItem setTitle:[NSString stringWithFormat:@"%@的轨迹",nickName]];
    }];
    [self presentViewController:searchVC animated:YES completion:nil];
}

//地图画线
-(void)makeLocusWithLocation:(NSArray *)locationArr{
    NSInteger _userArrayCount = locationArr.count;
    /** 轨迹折线 */
    CLLocationCoordinate2D commuterLotCoords[_userArrayCount];
    for (int i=0; i<_userArrayCount; i++)
    {
        commuterLotCoords[i].latitude = [[[locationArr objectAtIndex:i] objectForKey:@"latitude"] floatValue];
        commuterLotCoords[i].longitude = [[[locationArr objectAtIndex:i] objectForKey:@"longitude"] floatValue];
    }
    //构造折线对象
    _commonPolyline = [MAPolyline polylineWithCoordinates:commuterLotCoords count:_userArrayCount];
    //在地图上添加折线对象
    [self.mapView addOverlay: _commonPolyline];
    [self.OverlayArr addObject:_commonPolyline];
    
    /** 端点 */
    //轨迹端点半径
    CGFloat circleRadius = 7.0f;
    //画两边端点
    // @param radius 半径，单位：米
    _circleStart = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(commuterLotCoords[0].latitude, commuterLotCoords[0].longitude) radius:circleRadius];
    //在地图上添加圆圈
    [self.mapView addOverlay: _circleStart];
    [self.OverlayArr addObject: _circleStart];
    //终点构造圆圈
    _circleEnd = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(commuterLotCoords[(_userArrayCount - 1)].latitude, commuterLotCoords[(_userArrayCount - 1)].longitude) radius:circleRadius];
    //在地图上添加圆圈
    [self.mapView addOverlay: _circleEnd];
    [self.OverlayArr addObject:_circleEnd];
    
    //确定缩放比例
    [self zoomToMapPoints:self.mapView annotations:locationArr];
}
//根据坐标数组确定中心和缩放比例!
- (void)zoomToMapPoints:(MAMapView*)mapView annotations:(NSArray*)annotationsDict{
    NSMutableArray *annotations = [NSMutableArray array];
    for (NSDictionary *locDict in annotationsDict) {
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        CLLocationDegrees latitude = [[locDict objectForKey:@"latitude"] floatValue];
        CLLocationDegrees longitude = [[locDict objectForKey:@"longitude"] floatValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        annotation.coordinate = coordinate;
        [annotations addObject:annotation];
    }
    double minLat = 360.0f, maxLat = -360.0f;
    double minLon = 360.0f, maxLon = -360.0f;
    for (MAPointAnnotation *annotation in annotations) {
        if ( annotation.coordinate.latitude  < minLat ) minLat = annotation.coordinate.latitude;
        if ( annotation.coordinate.latitude  > maxLat ) maxLat = annotation.coordinate.latitude;
        if ( annotation.coordinate.longitude < minLon ) minLon = annotation.coordinate.longitude;
        if ( annotation.coordinate.longitude > maxLon ) maxLon = annotation.coordinate.longitude;
    }
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((minLat + maxLat) / 2.0, (minLon + maxLon) / 2.0);
    MACoordinateSpan span = MACoordinateSpanMake((maxLat - minLat), (maxLon - minLon));
    MACoordinateRegion region = MACoordinateRegionMake(center, span);
    [mapView setRegion:region animated:YES];
}



#pragma mark - 地图API
//
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        
        [self.mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    } 
}


//获取用户位置调用方法
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

//在地图上画轨迹
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    //画行驶折线
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        //轨迹宽度(笔触宽度)
        polylineView.lineWidth = 4.2f;
        //轨迹颜色
        polylineView.strokeColor = [UIColor orangeColor];
        //连接类型
        polylineView.lineJoin = kCGLineJoinBevel;
        //端点类型
        polylineView.lineCap = kCGLineCapRound;
        polylineView.lineDashPhase = 2.0;
        return polylineView;
    }
    //在轨迹两端画圆圈
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
        circleView.lineWidth = 2.f;
        circleView.strokeColor = colorWithRGBA(0, 130, 251, 1);
        return circleView;
    }
    return nil;
}

#pragma mark - SearchPersonDelegate
/** 传递当前数据库中搜索到的坐标点 -> 按照时间顺序排列 */
-(void)searchPersonVC:(SearchPersonController *)searchPersonVC passLocationArr:(NSArray *)locationArr{
    NSLog(@"界面跳转传值>passLocationArr>>>");
    [self makeLocusWithLocation:locationArr];
}

-(NSArray *)simulateData{
    
    //自定义四个坐标点
    CLLocationCoordinate2D _commonPolylineCoords[8];
    
    //双井富力城:116.459928,39.897942
    _commonPolylineCoords[0].latitude = 39.897942;
    _commonPolylineCoords[0].longitude = 116.459928;
    
    //门: 116.45835,39.897975
    _commonPolylineCoords[1].latitude = 39.897975;
    _commonPolylineCoords[1].longitude = 116.45835;
    
    //天力街路口: 116.458243,39.893662
    _commonPolylineCoords[2].latitude = 39.893662;
    _commonPolylineCoords[2].longitude = 116.458243;
    
    //双井 : 116.461816,39.893506
    _commonPolylineCoords[3].latitude = 39.893506;
    _commonPolylineCoords[3].longitude = 116.461816;
    
    //双井东苑小区: 116.464359,39.89353
    _commonPolylineCoords[4].latitude = 39.89353;
    _commonPolylineCoords[4].longitude = 116.464359;
    
    //双井东苑小区东:  116.465024,39.893481
    _commonPolylineCoords[5].latitude = 39.893481;
    _commonPolylineCoords[5].longitude = 116.465024;
    
    //百环商务独栋:  116.465013,39.892378
    _commonPolylineCoords[6].latitude = 39.892378;
    _commonPolylineCoords[6].longitude = 116.465013;
    
    //乔家大院:  116.465024,39.891299
    _commonPolylineCoords[7].latitude = 39.891299;
    _commonPolylineCoords[7].longitude = 116.465024;
    
    NSMutableArray *userTrackLocationArr0 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<8 ; i++) {
        //将定位生成的左边点转化成存放坐标字典的数组
        NSMutableDictionary *dictRep = [[NSMutableDictionary alloc] init];
        [dictRep setObject:[NSNumber numberWithDouble:_commonPolylineCoords[i].latitude] forKey:@"latitude"];
        [dictRep setObject:[NSNumber numberWithDouble:_commonPolylineCoords[i].longitude] forKey:@"longitude"];
        [userTrackLocationArr0 addObject:dictRep];
    }
    
#warning 测试起点终点距离
    //1.将两个经纬度点转成投影点
    MAMapPoint point1 = MAMapPointForCoordinate(_commonPolylineCoords[0]);
    MAMapPoint point2 = MAMapPointForCoordinate(_commonPolylineCoords[7]);
    
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    NSLog(@"计算距离-> %.2f",distance);
    
    return (NSArray *)userTrackLocationArr0;
}

@end
