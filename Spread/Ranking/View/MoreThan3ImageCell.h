//
//  MoreThan3ImageCell.h
//  OneHelper
//
//  Created by qiuxuewei on 16/3/16.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreThan3ImageCell : UITableViewCell
/** 新闻标题 */
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLB;

/** 来源 */
@property (weak, nonatomic) IBOutlet UILabel *newsSourceLB;

/** 第一幅图片 */
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView1;

/** 第2幅图片 */
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView2;

/** 第3幅图片 */
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView3;

@end
