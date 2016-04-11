//
//  XWDiscoverCellCommentModule.m
//  Spread
//
//  Created by 邱学伟 on 16/4/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWDiscoverCellCommentModule.h"

@interface XWDiscoverCellCommentModule (){
    //点赞
    UILabel *likeLB;
    //点赞数
    UILabel *likeCountLB;
    //评论
    UILabel *commentLB;
    //评论数
    UILabel *commentCountLB;
    //两侧view
    UIView *leftView;
    UIView *rightView;
    //参数
    CGFloat width;
    XWDiscoverCommentsModel *dataSourceModel;
}

@end

@implementation XWDiscoverCellCommentModule

#pragma mark - init
-(instancetype)initWithWidth:(CGFloat)widthTemp{
    self = [super init];
    if (self) {
        width = widthTemp;
        CGFloat viewWidth = (width - 24) * 0.5;
        CGFloat originX = (viewWidth - 40) * 0.5;
        
        /**
         *左侧视图容器
         */
        
        leftView = [[UIView alloc] init];
        [leftView setFrame:CGRectMake(12, 0, viewWidth, 38)];
        [leftView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:leftView];
        
        likeLB = [[UILabel alloc] init];
        [likeLB setBackgroundColor:[UIColor clearColor]];
        [likeLB setUserInteractionEnabled:YES];
        [likeLB setFrame:CGRectMake(originX, (38 - 18) * 0.5, 19, 18)];
        [likeLB setFont:[UIFont fontWithName:@"icomoon" size:18.0f]];
        [likeLB setTextColor:ColorFromRGBA(0x999999, 1)];
        [likeLB setText:@"\U0000E636"];
        [leftView addSubview:likeLB];
        
        likeCountLB = [[UILabel alloc] init];
        [likeCountLB setBackgroundColor:[UIColor clearColor]];
        [likeCountLB setFrame:CGRectMake(CGRectGetMaxX(likeLB.frame) + 5, (38 - 18) * 0.5, 50, 18)];
        [likeCountLB setFont:[UIFont systemFontOfSize:12.0f]];
        [likeCountLB setTextColor:ColorFromRGBA(0x999999, 1)];
        [leftView addSubview:likeCountLB];
        
        /**
         *右侧视图容器
         */
        rightView = [[UIView alloc] init];
        [rightView setFrame:CGRectMake(12 + viewWidth, 0, viewWidth, 38)];
        [rightView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:rightView];
        
        commentLB = [[UILabel alloc] init];
        [commentLB setBackgroundColor:[UIColor clearColor]];
        [commentLB setUserInteractionEnabled:YES];
        [commentLB setFrame:CGRectMake(originX, (38 - 18) * 0.5, 19, 18)];
        [commentLB setFont:[UIFont fontWithName:@"icomoon" size:18.0f]];
        [commentLB setTextColor:ColorFromRGBA(0x999999, 1)];
        [commentLB setText:@"\U0000E63D"];
        [rightView addSubview:commentLB];
        
        commentCountLB = [[UILabel alloc] init];
        [commentCountLB setBackgroundColor:[UIColor clearColor]];
        [commentCountLB setFrame:CGRectMake(CGRectGetMaxX(commentLB.frame) + 5, (38 - 18) * 0.5, 50, 18)];
        [commentCountLB setFont:[UIFont systemFontOfSize:12.0f]];
        [commentCountLB setTextColor:ColorFromRGBA(0x999999, 1)];
        [rightView addSubview:commentCountLB];
        
        /**
         *  点击事件
         */
        UITapGestureRecognizer *leftTapPraise = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapPraise)];
        [leftView addGestureRecognizer:leftTapPraise];
        
        UITapGestureRecognizer *rightTapComment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapComment)];
        [rightView addGestureRecognizer:rightTapComment];
    }
    return self;
}

#pragma mark - 点击事件
-(void)leftTapPraise{
    NSLog(@"点赞block->传递 ");
    //点击动画->
    [self shankeToShow:likeLB];
    self.tapPraiseBlock();
}
-(void)rightTapComment{
    NSLog(@"评论block->传递 ");
    self.tapCommentBlock();
}
//点赞动画
-(void)shankeToShow:(UIView *)view{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];

}

#pragma mark - setter
-(void)setDataWithModel:(XWDiscoverCommentsModel *)model{
    dataSourceModel = model;
    [self refreshViewData];
}

-(void)refreshViewData{
    if (dataSourceModel.isPraised) {
        [likeLB setTextColor:ColorFromRGBA(0xfe6400, 1)];
        [likeLB setText:@"\U0000E90B"];
    }else{
        [likeLB setTextColor:ColorFromRGBA(0x999999, 1)];
        [likeLB setText:@"\U0000E636"];
    }
    
    if (dataSourceModel.praisedCount != 0) {
        [likeCountLB setText:[NSString stringWithFormat:@"%ld",(long)dataSourceModel.praisedCount]];
    }else{
        [likeCountLB setText:@""];
    }
    
    if (dataSourceModel.commentCount != 0) {
        [commentCountLB setText:[NSString stringWithFormat:@"%ld",(long)dataSourceModel.commentCount]];
    }else{
        [commentCountLB setText:@""];
    }
}
#pragma mark - getter
-(CGFloat)height{
    return 38;
}
+(CGFloat)countHeightWithModel:(XWDiscoverModel *)model width:(CGFloat)width{
    return 38;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
