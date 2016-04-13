//
//  XWDiscoverCellTitleModule.m
//  Spread
//
//  Created by 邱学伟 on 16/4/7.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  cell顶部模块(头像+昵称+发布时间)

#import "XWDiscoverCellTitleModule.h"

@interface XWDiscoverCellTitleModule (){
    //头像
//    UIImageView *self.headIcon;
    //昵称label
    UILabel *userNameLB;
    //发布时间
    UILabel *timeLB;
    //模块宽度
    CGFloat width;
    //数据模型
    XWDiscoverTitleModel *dataSourceModel;
}

@end

@implementation XWDiscoverCellTitleModule

#pragma mark - init
-(instancetype)initWithWidth:(CGFloat)widthTemp{
    self = [super init];
    if (self) {
        width = widthTemp;
        /**
         *头像
         */
        self.headIcon = [[UIImageView alloc] init];
        [self.headIcon setBackgroundColor:[UIColor clearColor]];
        [self.headIcon setUserInteractionEnabled:YES];
        //设置圆角
        [self.headIcon.layer setCornerRadius:15.0f];
        [self.headIcon.layer setMasksToBounds:YES];
        [self.headIcon.layer setShouldRasterize:YES];
        [self.headIcon.layer setRasterizationScale:[UIScreen mainScreen].scale];
        //点击事件
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHead:)];
        [self.headIcon addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:self.headIcon];
        
        
        /**
         *用户昵称
         */
        userNameLB = [[UILabel alloc] init];
        [userNameLB setBackgroundColor:[UIColor clearColor]];
        [userNameLB setFont:[UIFont systemFontOfSize:14.0f]];
        [userNameLB setTextColor:ColorFromRGBA(0x009696, 1)];
        [self addSubview:userNameLB];
        
        /**
         *  发布时间
         */
        timeLB = [[UILabel alloc] init];
        [timeLB setBackgroundColor:[UIColor clearColor]];
        [timeLB setFont:[UIFont systemFontOfSize:10.0f]];
        [timeLB setTextColor:ColorFromRGBA(0x999999, 1)];
        [self addSubview:timeLB];
        
    }
    return self;
}

//头像点击方法
-(void)tapHead:(UITapGestureRecognizer *)tapGestureRecognizer{
    NSLog(@"点击头像了->通过block传递事件!!");
    self.tapHeadBlock();
}

#pragma mark - setter
-(void)setDataWithModel:(XWDiscoverTitleModel *)model{
    dataSourceModel = model;
    [self refreshViewData];
}

#pragma mark - getter
/**
 *  顶部条高度设置为50
 */
-(CGFloat)height{
    return 50;
}
+(CGFloat)countHeightWithModel:(XWDiscoverTitleModel *)model width:(CGFloat)width{
    return 50;
}
/**
 *  更新模块数据
 */
-(void)refreshViewData{
    //载入头像
    self.loadImageBlock(self.headIcon, dataSourceModel.headIocnUrlStr, load_default_head);
    [userNameLB setText:dataSourceModel.userName];
    [timeLB setText:dataSourceModel.time];
    //标记为需要重新布局，不立即刷新，但layoutSubviews一定会被调用,配合layoutIfNeeded立即更新
    [self setNeedsLayout];
}

//布局方法
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //头像,
    [self.headIcon setFrame:CGRectMake(12, 10, 30, 30)];
    
    //昵称
//    CGSize userNameSize = [userNameLB.text sizeWithFont:userNameLB.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15) lineBreakMode:userNameLB.lineBreakMode];
//    [userNameLB setFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame) + 10, 10, userNameSize.width, userNameSize.height)];
    
    
    
    NSDictionary *attributes = @{NSFontAttributeName : userNameLB.font,
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    //CGSizeMake(CGFLOAT_MAX, 15)->限制最大的宽度和高度`  采用换行模式
//    CGSize userNameLBSize = [userNameLB.text sizeWithFont:userNameLB.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15) lineBreakMode:userNameLB.lineBreakMode];
    
    CGRect userNameLBRect = [userNameLB.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    [userNameLB setFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame) + 10, 10, userNameLBRect.size.width, userNameLBRect.size.height)];
    
    //发布时间
    [timeLB setFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame) + 10, CGRectGetMaxY(userNameLB.frame) + 5, 90, 11)];
}



@end
