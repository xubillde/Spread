//
//  XWPlaceholderTextView.m
//  Spread
//
//  Created by 邱学伟 on 16/4/18.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWPlaceholderTextView.h"

//间隔
#define kMargin 7
//字体大小
#define kFontSize 17

@interface XWPlaceholderTextView ()<UITextViewDelegate>

/**
 *  占位文本框
 */
@property (nonatomic, strong) UILabel *placeholderLB;

@end

@implementation XWPlaceholderTextView
#pragma mark - 懒加载
-(UILabel *)placeholderLB{
    if (_placeholderLB == nil) {
        _placeholderLB = [[UILabel alloc] init];
        _placeholderLB.textColor = [UIColor lightGrayColor];
        [_placeholderLB setNumberOfLines:0];
    }
    return _placeholderLB;
}
//初始化方法
-(instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholderStr{
    self = [super initWithFrame:frame];
    if (self) {
        //设置占位文本才会调用getter/setter方法
        self.placeholderStr = placeholderStr;
        self.delegate = self;
//        self.layer.cornerRadius = kMargin;
        self.font = [UIFont systemFontOfSize:kFontSize];
    }
    return self;
}
+(instancetype)shareWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholderStr{
    XWPlaceholderTextView *XWText = [[XWPlaceholderTextView alloc] initWithFrame:frame withPlaceholder:placeholderStr];
    return XWText;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLB.hidden = textView.text.length;
}

#pragma mark - setter方法
-(void)setPlaceholderStr:(NSString *)placeholderStr{
    if (_placeholderStr != placeholderStr) {
        _placeholderStr = placeholderStr;
        //只有在设置占位文字时,才加载占位label
        [self addSubview:self.placeholderLB];
        //设置占位文本
        [self.placeholderLB setText:_placeholderStr];
        
        //占位文本Lable的尺寸
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]
                                     };
        //获取一段文本在规定长宽的尺寸
        CGRect placeholderLBSize = [_placeholderStr boundingRectWithSize:CGSizeMake(self.frame.size.width - kMargin * 2, 0) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attributes context:nil];
        
        [self.placeholderLB setFrame:CGRectMake(kMargin, kMargin, placeholderLBSize.size.width, placeholderLBSize.size.height)];
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
