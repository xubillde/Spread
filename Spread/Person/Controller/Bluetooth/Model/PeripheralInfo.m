//
//  PeripheralInfo.m
//  Spread
//
//  Created by 邱学伟 on 16/3/27.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "PeripheralInfo.h"

@implementation PeripheralInfo
//初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        _characteristics = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
