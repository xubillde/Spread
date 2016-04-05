//
//  SearchPersonController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/22.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "SearchPersonController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


@interface SearchPersonController ()<UITextFieldDelegate>

@end

@implementation SearchPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //界面布局
    [self customViewLaout];
    //设置代理
    [self setUpNickNameFD];
}

-(void)customViewLaout{
    //按钮
     //阴影 Shadow
    self.searchBtn.layer.shadowColor = [UIColor blackColor].CGColor; //黑
    self.searchBtn.layer.shadowOpacity = 0.33;//阴影的不透明度
    self.searchBtn.layer.shadowOffset = CGSizeMake(0, 1.5);//阴影的偏移
    self.searchBtn.layer.shadowRadius = 4.0;//阴影半径
    self.searchBtn.layer.shouldRasterize = YES; //圆角缓存
    self.searchBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;//提高流畅度.
    //圆角
    self.searchBtn.layer.cornerRadius = 6.0f;
}

#pragma mark - 类内方法
-(void)setUpNickNameFD{
    [self.nickNameFD setDelegate:self];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nickNameFD resignFirstResponder];
    return YES;
}
//返回
- (IBAction)cacelBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getLocationFromNetWithUserName:(NSString *)username{
    
}
//按钮点击事件
- (IBAction)searchPersonClick:(UIButton *)sender {
    
    //网络请求数据->
//    [self getLocationFromNetWithUserName:self.nickNameFD.text];
    //代理传值
//    if ([self.delegate respondsToSelector:@selector(searchPersonVC:passLocationArr:)]) {
//        //用来判断是否有以某个名字命名的方法(被封装在一个selector的对象里传递)
//        [self.delegate searchPersonVC:self passLocationArr:[self simulateData]];
//    }
    
    
    //block传值
    //要传递的字典
    NSMutableDictionary *locationDict = [NSMutableDictionary dictionary];
    [locationDict setObject:self.nickNameFD.text forKey:@"nickName"];
    [locationDict setObject:[self simulateData] forKey:@"locationArr"];
    self.passLocatonBlock(locationDict);
    [self dismissViewControllerAnimated:YES completion:nil];
}

//block 传值
-(void)passLocationWithLocationArr:(passLocationArrBlock)passlocationArrBlock{
    self.passLocatonBlock = passlocationArrBlock;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nickNameFD resignFirstResponder];
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
    
    //B2期: 116.457675,39.897786
    _commonPolylineCoords[2].latitude = 39.897786;
    _commonPolylineCoords[2].longitude = 116.457675;
    
    //2器 2 : 116.45717,39.898041
    _commonPolylineCoords[3].latitude = 39.898041;
    _commonPolylineCoords[3].longitude = 116.45717;
    
    //2期们: 116.456012,39.898033
    _commonPolylineCoords[4].latitude = 39.898033;
    _commonPolylineCoords[4].longitude = 116.456012;
    
    //C:  116.457299,39.897267
    _commonPolylineCoords[5].latitude = 39.897267;
    _commonPolylineCoords[5].longitude = 116.457299;
    
    //C中:  116.456881,39.896592
    _commonPolylineCoords[6].latitude = 39.896592;
    _commonPolylineCoords[6].longitude = 116.456881;
    
    //小黑屋:  116.456441,39.895876
    _commonPolylineCoords[7].latitude = 39.895876;
    _commonPolylineCoords[7].longitude = 116.456441;
    
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
