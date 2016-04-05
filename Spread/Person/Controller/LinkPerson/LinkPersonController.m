//
//  LinkPersonController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/23.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "LinkPersonController.h"
#import "XWBlueToothController.h"
#import "PeripheralInfo.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BuyCrzayfireController.h"


#define kPulseAnimation @"kPulseAnimation"

@interface LinkPersonController ()<CBCentralManagerDelegate,CBPeripheralDelegate>{
    //系统蓝牙设备管理对象,用来扫描和连接外设
    CBCentralManager *_manager;
    //用于保存被发现设备
    NSMutableArray *_peripherals;
    //蓝牙设备
    PeripheralInfo *_peripheral;
    //是否正在搜索
    BOOL _isAnimating;
}

@end

@implementation LinkPersonController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //默认没有在搜索
    _isAnimating = NO;
    _peripherals = [[NSMutableArray alloc] init];
    _peripheral = [[PeripheralInfo alloc] init];
    
//    self.navigationItem
}
-(void)viewWillAppear:(BOOL)animated{
    if ([self.addLB.text isEqualToString:@"正在添加"]) {
        if (_isAnimating == NO) {
            [self waveAnimationLayerWithView:self.addBtn diameter:250 duration:1.2];
            [self waveAnimationLayerWithView:self.addBtn diameter:200 duration:1.2];
            _isAnimating = YES;
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_isAnimating == YES) {
        NSArray *layerArr = [NSArray arrayWithArray:self.addBtn.superview.layer.sublayers];
        for (CALayer *layer in layerArr) {
            if ([layer.animationKeys containsObject:kPulseAnimation]) {
                //            [self waveAnimationLayerWithView:sender diameter:250 duration:1.2];
                //            [self waveAnimationLayerWithView:sender diameter:200 duration:1.2];
                [layer removeAllAnimations];
                [layer removeFromSuperlayer];
                _isAnimating = NO;
            }
        }
    }
}

#pragma mark - 类内方法
//添加点击方法
- (IBAction)addBtnClick:(UIButton *)addBtn {
    [self.addLB setText:@"正在添加"];
    [addBtn setUserInteractionEnabled:NO];
    //连接蓝牙
    [self connectBluetooth];
    //动画
    [self waveAnimationLayerWithView:addBtn diameter:250 duration:1.2];
    [self waveAnimationLayerWithView:addBtn diameter:200 duration:1.2];
    //正在动画
    _isAnimating = YES;
    
//    NSArray *layerArr = [NSArray arrayWithArray:sender.superview.layer.sublayers];
//    
//    for (CALayer *layer in layerArr) {
//        if ([layer.animationKeys containsObject:kPulseAnimation]) {
//            _isAnimating = YES;
//            [layer removeAllAnimations];
//            [layer removeFromSuperlayer];
//        }
//    }
//
//    if (!_isAnimating) {
//        [self waveAnimationLayerWithView:sender diameter:250 duration:1.2];
//        [self waveAnimationLayerWithView:sender diameter:200 duration:1.2];
//    }
}
//购买按钮点击
- (IBAction)buyBtnClick:(UIButton *)sender {
    BuyCrzayfireController *buyCrazyfireVC = [[BuyCrzayfireController alloc] init];
    [self.navigationController pushViewController:buyCrazyfireVC animated:YES];
}


#pragma mark - Bluetooth相关
-(void)connectBluetooth{
    //初始化并设置委托和线程队列，最好一个线程的参数可以为nil，默认会就main线程
    _manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
}
#pragma mark - 蓝牙委托
//主设备状态改变的委托，在初始化CBCentralManager的适合会打开设备，只有当设备正确打开后才能使用其他选择实现的委托中比较重要的：
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    if (central.state == CBCentralManagerStatePoweredOn) {
        //连接蓝牙成功->
        //开始扫描周围的外设
        /*
         第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入 _>didDiscoverPeripheral
         */
        [_manager scanForPeripheralsWithServices:nil options:nil];
        
    }else{
        NSLog(@"蓝牙状态有误....!!!");
    }
}
//找到外设的委托
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"---->>>>didDiscoverPeripheral");
    NSLog(@"当扫描到设备:%@",peripheral.name);
    //设置下连接规则
    if ([peripheral.name hasPrefix:@"Z"]){
        //发现crazyfire型号的蓝牙
        //->提醒用户
        NSString *peripheralName = [NSString stringWithFormat:@"找到疯火科技蓝牙模块\"%@\"",peripheral.name];
        UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:nil message:peripheralName preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *AlertAction = [UIAlertAction actionWithTitle:@"连接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击连接!!! ->>>>>>");
            //连接蓝牙
            //连接蓝牙
            [_peripherals addObject:peripheral];
            //连接设备
            [_manager connectPeripheral:peripheral options:nil];
        }];
        UIAlertAction *radarAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消..");
        }];
        [AlertController addAction:AlertAction];
        [AlertController addAction:radarAlertAction];
        [self presentViewController:AlertController animated:YES completion:nil];
    }
    //接下来可以连接设备
}
//连接外设成功的委托
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"---->>>>didConnectPeripheral");
    NSLog(@">>>连接到名称为（%@）的设备-成功  唯一标示符UUID->%@:",peripheral.name,peripheral.identifier.UUIDString);
    //1.取消动画 2.更改按钮文字 3.提示绑定成功
    [self.addBtn setUserInteractionEnabled:NO];
    //取消动画
    NSArray *layerArr = [NSArray arrayWithArray:self.addBtn.superview.layer.sublayers];
    for (CALayer *layer in layerArr) {
        if ([layer.animationKeys containsObject:kPulseAnimation]) {
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
        }
    }
    
    //上传服务器->
    //转化为模型
    [_peripheral setServiceUUID:peripheral.identifier.UUIDString];
    //将当前UUID保存本地
    NSMutableArray *crazyfireUUIDArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"crazyfireUUIDArrKEY"];
    if (!crazyfireUUIDArr) {
        crazyfireUUIDArr = [[NSMutableArray alloc] init];
    }
    //判断数组中是否存在当前对象UUID
    if ([crazyfireUUIDArr containsObject:_peripheral.serviceUUID]) {
        NSLog(@"已经存在");
        //更改按钮文字
        [self.addLB setText:@"已绑定此设备"];
    }else{
        [crazyfireUUIDArr addObject:_peripheral.serviceUUID];
        [[NSUserDefaults standardUserDefaults] setObject:crazyfireUUIDArr forKey:@"crazyfireUUIDArrKEY"];
        //更改按钮文字
        [self.addLB setText:@"连接成功"];
    }
    
#warning 成功->
    
    
//    [peripheral setDelegate:self];
    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
//    [peripheral discoverServices:nil];
    
    
}
//外设连接失败的委托
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
     NSLog(@"---->>>>didFailToConnectPeripheral>>外设连接失败");
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
    //提示连接失败
    
}
//断开外设的委托
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"---->>>>didDisconnectPeripheral>>断开外设");
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    
}


#pragma mark 扫描设备服务 -> 暂时不需要扫描服务->
//扫描到Services
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
      NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error)
    {
        NSLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    for (CBService *service in peripheral.services) {
        NSLog(@"service.UUID->>>>%@",service.UUID.UUIDString);
        
        
        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
//        [peripheral discoverCharacteristics:nil forService:service];
    }
    
}

//扫描到Characteristics
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    NSLog(@"--->>> didDiscoverCharacteristicsForService 扫描到Characteristics");
    if (error)
    {
        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
    }
    
    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        {
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
    
    //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
    
    
}

//获取的charateristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //打印出characteristic的UUID和值
    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);
    
}

//搜索到Characteristic的Descriptors
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //打印出Characteristic和他的Descriptors
    NSLog(@"characteristic uuid:%@",characteristic.UUID);
    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"Descriptor uuid:%@",d.UUID);
    }
    
}
//获取到Descriptors的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}

#pragma mark 把数据写到Characteristic中
//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{
    
    //打印出 characteristic 的权限，可以看到有很多种，这是一个NS_OPTIONS，就是可以同时用于好几个值，常见的有read，write，notify，indicate，知知道这几个基本就够用了，前连个是读写权限，后两个都是通知，两种不同的通知方式。
    /*
     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
     CBCharacteristicPropertyBroadcast												= 0x01,
     CBCharacteristicPropertyRead													= 0x02,
     CBCharacteristicPropertyWriteWithoutResponse									= 0x04,
     CBCharacteristicPropertyWrite													= 0x08,
     CBCharacteristicPropertyNotify													= 0x10,
     CBCharacteristicPropertyIndicate												= 0x20,
     CBCharacteristicPropertyAuthenticatedSignedWrites								= 0x40,
     CBCharacteristicPropertyExtendedProperties										= 0x80,
     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)		= 0x100,
     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)	= 0x200
     };
     
     */
    NSLog(@"%lu", (unsigned long)characteristic.properties);
    
    
    //只有 characteristic.properties 有write的权限才可以写
    if(characteristic.properties & CBCharacteristicPropertyWrite){
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
         */
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }else{
        NSLog(@"该字段不可写！");
    }
    
    
}

//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}


#pragma mark - 停止扫描并断开连接
//停止扫描并断开连接
-(void)disconnectPeripheral:(CBCentralManager *)centralManager
                 peripheral:(CBPeripheral *)peripheral{
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
}

#pragma mark - 波浪动画->
//波纹层层嵌套
//view: 中心view
//diameter: 半径
//duration: 持续时长
-(CALayer *)waveAnimationLayerWithView:(UIView *)view diameter:(CGFloat)diameter duration:(CGFloat)duration{
    CALayer *waveLayer = [CALayer layer];
    [waveLayer setBounds:CGRectMake(0, 0, diameter, diameter)];
    //设置圆角半径
    [waveLayer setCornerRadius:diameter * 0.5];
    //阴影 Shadow
    waveLayer.shadowColor = [UIColor blackColor].CGColor; //黑
    waveLayer.shadowOpacity = 0.33;//阴影的不透明度
    waveLayer.shadowOffset = CGSizeMake(0, 1.5);//阴影的偏移
    waveLayer.shadowRadius = diameter * 0.5;//阴影半径
    waveLayer.shouldRasterize = YES; //圆角缓存
    waveLayer.rasterizationScale = [UIScreen mainScreen].scale;//提高流畅度.
    
    //设置位置
    [waveLayer setPosition:view.center];
    [waveLayer setBackgroundColor:colorWithRGBA(233, 68, 71, 0.8).CGColor];
    
    
    //把扩散层放在按钮下面
    [view.superview.layer insertSublayer:waveLayer below:view.layer];
    
    //组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    //一次动画持续时长
    [animationGroup setDuration:duration];
    //动画循环次数->无限次
    [animationGroup setRepeatCount:INFINITY];
    //动画执行完是否被移除
    [animationGroup setRemovedOnCompletion:NO];
    
    /*动画速度,何时快、慢
     (
     kCAMediaTimingFunctionLinear 线性（匀速）|
     kCAMediaTimingFunctionEaseIn 先慢|
     kCAMediaTimingFunctionEaseOut 后慢|
     kCAMediaTimingFunctionEaseInEaseOut 先慢 后慢 中间快|
     kCAMediaTimingFunctionDefault 默认|
     )
     */
    //动画速度,何时快、慢
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [animationGroup setTimingFunction:defaultCurve];
    
     //核心动画->1
    /*
    CAAnimation可分为四种：
    
    1.CABasicAnimation
    通过设定起始点，终点，时间，动画会沿着你这设定点进行移动。可以看做特殊的CAKeyFrameAnimation
    2.CAKeyframeAnimation
    Keyframe顾名思义就是关键点的frame，你可以通过设定CALayer的始点、中间关键点、终点的frame，时间，动画会沿你设定的轨迹进行移动
    3.CAAnimationGroup
    Group也就是组合的意思，就是把对这个Layer的所有动画都组合起来。PS：一个layer设定了很多动画，他们都会同时执行，如何按顺序执行我到时候再讲。
    4.CATransition
    这个就是苹果帮开发者封装好的一些动画
     */
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    //开始大小
    [scaleAnimation setFromValue:[NSNumber numberWithFloat:0.7]];
    //最后大小
    [scaleAnimation setToValue:[NSNumber numberWithFloat:1.0]];
    [scaleAnimation setDuration:duration];
    [scaleAnimation setRemovedOnCompletion:NO];
    
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    //开始大小
    [opacityAnimation setFromValue:[NSNumber numberWithFloat:0.4]];
    //最后大小
    [opacityAnimation setToValue:[NSNumber numberWithFloat:0.0]];
    [opacityAnimation setDuration:duration];
    [opacityAnimation setRemovedOnCompletion:NO];
    
    [animationGroup setAnimations:@[scaleAnimation,opacityAnimation]];
    
    //开始动画
    [waveLayer addAnimation:animationGroup forKey:kPulseAnimation];
    return waveLayer;
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
