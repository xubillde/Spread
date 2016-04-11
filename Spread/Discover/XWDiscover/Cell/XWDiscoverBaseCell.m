//
//  XWDiscoverBaseCell.m
//  Spread
//
//  Created by 邱学伟 on 16/4/6.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWDiscoverBaseCell.h"

@implementation XWDiscoverBaseCell

-(void)loadDataSourceWithIndexPath:(NSIndexPath *)indexPath{
    
}

+(CGFloat)countHeightWithGroupCellModel:(XWDiscoverModel *)model width:(CGFloat)width{
    return 0.0;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //自动布局
    CGFloat maxYOrigin = 0;
    
    for (XWDiscoverCellBaseModule *currentModule in _modules) {
        currentModule.frame = CGRectMake(0, maxYOrigin, CGRectGetWidth(self.frame), currentModule.height);
        maxYOrigin = CGRectGetMaxY(currentModule.frame);
    }
}

@end
