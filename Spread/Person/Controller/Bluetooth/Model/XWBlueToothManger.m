//
//  XWBlueToothManger.m
//  Spread
//
//  Created by 邱学伟 on 16/3/28.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWBlueToothManger.h"

@implementation XWBlueToothManger
#pragma mark - 单例
+(instancetype)shareBluetoothManger{
    static XWBlueToothManger *blueToothManger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        blueToothManger = [[self alloc] init];
    });
    return blueToothManger;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self shareSelf];
    }
    return self;
}
-(void)shareSelf{
    dispatch_queue_t t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:t];
    myPeripheralArrM = [[NSMutableArray alloc] init];
}

#pragma mark -CBCentralManagerDelegate
//当前手机状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"手机蓝牙已经打开>>>!!!!<<<<");
        //开始扫描周围的外设
        /*
         第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
         - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
         */
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    }else{
        NSLog(@"手机不支持蓝牙");
    }
}

@end
