//
//  XWRadarView.m
//  Spread
//
//  Created by qiuxuewei on 16/3/23.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWRadarView.h"
#import <QuartzCore/QuartzCore.h>
#import "XWRadarPointView.h"
#import "XWRadarIndicatorView.h"

//默认的圈数
#define RADAR_DEFAULT_SECTIONS_NUM 3
//默认的半径大小  150
#define RADAR_DEFAULT_RADIUS 150.f
//默认的头像半径大小
#define RADAR_DEFAULT_IMGRADIUS 20.f
#define RADAR_ROTATE_SPEED 140.0f
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@implementation XWRadarView

#pragma mark - 初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUpSelf];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSelf];
    }
    return self;
}
//设置
-(void)setUpSelf{
    //指针
    if (!self.indicatorView) {
        XWRadarIndicatorView *indicatorView = [[XWRadarIndicatorView alloc] init];
        [self addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    //指示文本
    if (!self.textLabel) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y + self.radius, self.bounds.size.width, 30)];
        [self addSubview:textLabel];
        _textLabel = textLabel;
    }
    //目标点视图
    if (!self.pointsView) {
        UIView *pointsView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:pointsView];
        _pointsView = pointsView;
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //一个不透明类型的Quartz 2D绘画环境
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /* 背景图片*/
    if (self.backgroundImage) {
        UIImage *backgroundImage = self.backgroundImage;
        //在坐标中画出图片
        [backgroundImage drawInRect:self.bounds];
    }
    
    //默认的圈数
    NSUInteger sectionsNum = RADAR_DEFAULT_SECTIONS_NUM;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionInRadarView:)]) {
        sectionsNum = [self.dataSource numberOfSectionInRadarView:self];
    }
    
    //默认半径大小
    CGFloat radius = RADAR_DEFAULT_RADIUS;
    if (self.radius) {
        radius = self.radius;
    }
    
    //默认头像半径
    CGFloat imageRadius = RADAR_DEFAULT_IMGRADIUS;
    if (self.imgradius) {
        imageRadius = self.imgradius;
    }
    
    //画很多圆圈
    //最小圆半径
    CGFloat sectionRadius = (radius - imageRadius) / sectionsNum + imageRadius;
    /* 循环画圆 */
    for (NSInteger i = 0; i < sectionsNum; i++) {
        //边框圆
        //画笔线的颜色(透明度渐变)
//        CGContextSetRGBStrokeColor(context, 2, 2, 2, (1-(float)i/(sectionsNum + 1)) * 0.5);
        CGContextSetRGBStrokeColor(context, 255, 255, 255, 1);
        
        //线的宽度
        CGContextSetLineWidth(context, 2.0f);
        
        //添加一个圆
        /** void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)
         1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π  360°＝360×π/180 ＝2π 弧度
         x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。 */
        CGContextAddArc(context, self.center.x, self.center.y, sectionRadius, 0, 2 * M_PI, 0);
        //绘制路劲
        CGContextDrawPath(context, kCGPathStroke);
        
        //半径加
        sectionRadius += (radius - imageRadius) / sectionsNum;
    }
    
    
    //旋转的指针 和 后面的扇形弧度，其实frame是整个屏幕，所以旋转是绕着用户头像
    //指针
    if (self.indicatorView) {
        [self.indicatorView setFrame:CGRectMake(0, -40, kScreenWidth, kScreenHeight)];
        [self.indicatorView setBackgroundColor:[UIColor clearColor]];
        [self.indicatorView setRadius:self.radius];
    }
    
    //文本
    if (self.textLabel) {
        [self.textLabel setFrame:CGRectMake(0, self.center.y - ([UIScreen mainScreen].bounds.size.height) / 2, rect.size.width,30)];
        self.textLabel.textColor = [UIColor whiteColor];
        [self.textLabel setFont:[UIFont systemFontOfSize:13.0]];
        if (self.labelText) {
            self.textLabel.text = self.labelText;
        }
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        //将一个UIView显示在最前面
        [self bringSubviewToFront:self.textLabel];
        
    }
    
    if(self.PersonImage&&self.imgradius)
    {
        UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x-self.imgradius, self.center.y-self.imgradius, self.imgradius*2, self.imgradius*2)];
        avatarView.layer.cornerRadius = self.imgradius;
        avatarView.layer.masksToBounds = YES;
        
        [avatarView setImage:self.PersonImage];
        [self addSubview:avatarView];
        [self bringSubviewToFront:avatarView];
    }

    
}

- (void)setLabelText:(NSString *)labelText {
    _labelText = labelText;
    if (self.textLabel) {
        self.textLabel.text = labelText;
    }
}

#pragma mark - 方法
//开始旋转

-(void)scan{
    //转动动画
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0f];
    rotationAnimation.duration = 360.f / RADAR_ROTATE_SPEED;
    //旋转效果累积
    rotationAnimation.cumulative = YES;
    //无限循环
    rotationAnimation.repeatCount = INT_MAX;
    [_indicatorView.layer addAnimation:rotationAnimation forKey:@"rotationAnimationKey"];
}
//结束旋转动画
-(void)stop{
    [_indicatorView.layer removeAnimationForKey:@"rotationAnimationKey"];
}


@end
