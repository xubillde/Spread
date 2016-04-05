//
//  SearchPersonController.h
//  Spread
//
//  Created by qiuxuewei on 16/3/22.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "BaseViewController.h"
@class SearchPersonController;

//代理传值->
//传值协议
@protocol SearchPersonDelegate <NSObject>

@optional

/** 传递当前数据库中搜索到的坐标点 -> 按照时间顺序排列 */
-(void)searchPersonVC:(SearchPersonController *)searchPersonVC passLocationArr:(NSArray *)locationArr;



@end


@interface SearchPersonController : BaseViewController

/**  */

/** 搜索按钮 */
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

/** 昵称输入框 */
@property (weak, nonatomic) IBOutlet UITextField *nickNameFD;

/** 传值代理 */
@property (nonatomic, strong) id<SearchPersonDelegate> delegate;

//传值尝试2
//block传值->
typedef void(^passLocationArrBlock)(NSDictionary *locationDict);

@property (nonatomic, copy) passLocationArrBlock passLocatonBlock;
//block 方法
-(void)passLocationWithLocationArr:(passLocationArrBlock)passlocationArrBlock;




@end
