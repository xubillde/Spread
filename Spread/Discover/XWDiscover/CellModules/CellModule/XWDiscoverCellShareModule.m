//
//  XWDiscoverCellShareModule.m
//  Spread
//
//  Created by 邱学伟 on 16/4/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWDiscoverCellShareModule.h"

@interface XWDiscoverCellShareModule (){
    //背景
    UIView *backgroundView;
    //缩略图
    UIImageView *thumImageView;
    //标题
    UILabel *titleLB;
    //内容
    UILabel *contentLB;
    //参数
    CGFloat width;
    XWDiscoverShareModel *dataSourceModel;
}

@end

@implementation XWDiscoverCellShareModule

#pragma mark - init
-(instancetype)initWithWidth:(CGFloat)widthTemp{
    self = [super init];
    if (self) {
        width = widthTemp;
        backgroundView = [[UIView alloc] init];
        [backgroundView setFrame:CGRectMake(8, 0, width-16, 72)];
        [backgroundView setBackgroundColor:ColorFromRGBA(0xf8f8f8, 1)];
        [self addSubview:backgroundView];
        
        thumImageView = [[UIImageView alloc] init];
        [thumImageView setFrame:CGRectMake(4, 4, 64, 64)];
        [thumImageView setContentMode:UIViewContentModeScaleAspectFit];
        [thumImageView setClipsToBounds:YES];
        [thumImageView.layer setShouldRasterize:YES];
        [thumImageView.layer setRasterizationScale:[UIScreen mainScreen].scale];
        [backgroundView addSubview:thumImageView];
        
        titleLB = [[UILabel alloc] init];
        [titleLB setBackgroundColor:[UIColor clearColor]];
        [titleLB setFont:[UIFont systemFontOfSize:14.0f]];
        [titleLB setTextColor:ColorFromRGBA(0x4e5257, 1)];
        //以单词为单位换行，以单词为单位截断。结尾部分的内容以……方式省略，显示头的文字内容。
        [titleLB setLineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
        [backgroundView addSubview:titleLB];
        
        contentLB = [[UILabel alloc] init];
        [contentLB setBackgroundColor:[UIColor clearColor]];
        [contentLB setFont:[UIFont systemFontOfSize:12.0f]];
        [contentLB setTextColor:ColorFromRGBA(0x999999, 1)];
        [contentLB setNumberOfLines:2];
        [contentLB setLineBreakMode:NSLineBreakByWordWrapping |NSLineBreakByTruncatingTail];
        [backgroundView addSubview:contentLB];
        
        /**
         *  添加点击事件
         */
        UITapGestureRecognizer *tapGestureRecongizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf:)];
        [self addGestureRecognizer:tapGestureRecongizer];
        
    }
    return self;
}
#pragma mark - 点击事件
-(void)tapSelf:(UITapGestureRecognizer *)tapGestureRecognizer{
    NSLog(@"点击分享按钮->通过block传递事件");
    self.tapShareBlock();
}

#pragma mark - 刷新数据
-(void)refreshViewViewData{
    if (dataSourceModel) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }
    
    /**
     *  设置缩略图
     */
    self.loadImageBlock(thumImageView, dataSourceModel.thumImageUrlStr, load_default_image);
    
    //设置标题
    [titleLB setFrame:CGRectMake(CGRectGetMaxX(thumImageView.frame) + 10, 8,  CGRectGetWidth(backgroundView.frame) - (CGRectGetMaxX(thumImageView.frame) + 10) - 10, 0)];
    [titleLB setText:dataSourceModel.title];
    //文字大小自适应
    [titleLB sizeToFit];
    
    //设置摘要
    if (CGRectGetHeight(titleLB.frame) < 1) {
        [contentLB setFrame:CGRectMake(CGRectGetMaxX(thumImageView.frame) + 10, CGRectGetMaxY(titleLB.frame), CGRectGetWidth(backgroundView.frame) - (CGRectGetMaxX(thumImageView.frame) + 10) - 10, 0)];
        [contentLB setNumberOfLines:3];
    }else{
        [contentLB setFrame:CGRectMake(CGRectGetMaxX(thumImageView.frame) + 10, CGRectGetMaxY(titleLB.frame) + 8, CGRectGetWidth(backgroundView.frame) - (CGRectGetMaxX(thumImageView.frame) + 10) - 10, 0)];
        [contentLB setNumberOfLines:2];
    }
    
    //简介
    if (dataSourceModel.summary) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:dataSourceModel.summary];
        //   NSParagraphStyleAttributeName 段落的风格（设置首行，行间距，对齐方式什么的）看自己需要什么属性，写什么
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //行间距
        [paragraphStyle setLineSpacing:4];
        //换行方式
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
        //文字属性增加
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, [dataSourceModel.summary length])];
        [contentLB setAttributedText:attributedString];
        [contentLB sizeToFit];
        
        
        //扩展->
//        paragraphStyle.lineSpacing = 10;// 字体的行间距
//        paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
//        paragraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
//        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
//        paragraphStyle.headIndent = 20;//整体缩进(首行除外)
//        paragraphStyle.tailIndent = 20;//
//        paragraphStyle.minimumLineHeight = 10;//最低行高
//        paragraphStyle.maximumLineHeight = 20;//最大行高
//        paragraphStyle.paragraphSpacing = 15;//段与段之间的间距
//        paragraphStyle.paragraphSpacingBefore = 22.0f;//段首行空白空间/* Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph. */
//        paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;//从左到右的书写方向（一共➡️三种）
//        paragraphStyle.lineHeightMultiple = 15;/* Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height. */
//        paragraphStyle.hyphenationFactor = 1;//连字属性 在iOS，唯一支持的值分别为0和1
    }
}

#pragma mark - setter
-(void)setDataWithModel:(XWDiscoverShareModel *)model{
    dataSourceModel = model;
    [self refreshViewViewData];
}

#pragma mark - getter
-(CGFloat)height{
    if (dataSourceModel) {
        return 72;
    }else{
        return 0;
    }
}

+(CGFloat)countHeightWithModel:(XWDiscoverModel *)model width:(CGFloat)width{
    if (model.shareModel) {
        return 72;
    }else{
        return 0;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
