//
//  XWBlueToothManger.h
//  Spread
//
//  Created by 邱学伟 on 16/3/28.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

//扫描设备
typedef void(^XWScanPeripheral)(NSMutableArray *peripheralArrM);


@interface XWBlueToothManger : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>{
    //外设数组
    NSMutableArray *myPeripheralArrM;
}

/** 中心管理者 */
@property (nonatomic, strong) CBCentralManager *centralManager;

/** 当前连接的设备 */
@property (nonatomic, strong) CBPeripheral *currentPeripheral;

/** 扫描设备方法块 */
@property (nonatomic, copy)XWScanPeripheral  scanPeripheral;

/** 初始化蓝牙单例方法 */
+(instancetype)shareBluetoothManger;

/** 扫描设备 */
-(void)scanPeripherals;



@end
