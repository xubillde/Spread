//
//  UserInfoIconCell.h
//  Spread
//
//  Created by 邱学伟 on 16/3/29.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoIconCell : UITableViewCell
/** 用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;

@end
