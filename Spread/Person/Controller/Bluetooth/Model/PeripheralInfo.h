//
//  PeripheralInfo.h
//  Spread
//
//  Created by 邱学伟 on 16/3/27.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface PeripheralInfo : NSObject

/** 设备唯一标识 */
@property (nonatomic,strong) NSString *serviceUUID;
/** 设备特性 */
@property (nonatomic,strong) NSMutableArray *characteristics;


@end
