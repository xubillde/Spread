//
//  PublishController.h
//  Spread
//
//  Created by qiuxuewei on 16/3/21.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "BaseViewController.h"

@interface PublishController : BaseViewController

/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

/** 昵称输入框 */
@property (weak, nonatomic) IBOutlet UITextField *nickNameFD;

/** 扩散按钮 */
@property (weak, nonatomic) IBOutlet UIButton *SpreadBtn;



@end
