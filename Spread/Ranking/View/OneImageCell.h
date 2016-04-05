//
//  OneImageCell.h
//  OneHelper
//
//  Created by qiuxuewei on 16/3/16.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneImageCell : UITableViewCell
/** 新闻图片 */
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

/** 新闻标题 */
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLB;

/** 新闻来源 */
@property (weak, nonatomic) IBOutlet UILabel *newsSourceLB;

@end
