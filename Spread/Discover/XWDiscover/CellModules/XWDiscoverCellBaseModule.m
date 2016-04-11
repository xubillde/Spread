//
//  XWDiscoverCellBaseModule.m
//  Spread
//
//  Created by 邱学伟 on 16/4/7.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWDiscoverCellBaseModule.h"

@implementation XWDiscoverCellBaseModule

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//任意返回默认值 0
+(CGFloat)countHeightWithModel:(XWDiscoverModel *)model width:(CGFloat)width{
    return 0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
