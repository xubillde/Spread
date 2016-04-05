//
//  XWBlueToothController.m
//  Spread
//
//  Created by 邱学伟 on 16/3/28.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWBlueToothController.h"

@interface XWBlueToothController ()<UITableViewDataSource,UITableViewDelegate>{
    //本地取该用户储存的蓝牙硬件信息
    NSArray *_crazyfireUUIDArr;
}

//设备列表
@property (nonatomic, strong) UITableView *peripheralListTable;
//外设数组
@property (nonatomic, strong) NSMutableArray *peripherals;

@end

@implementation XWBlueToothController
#pragma mark - 懒加载
-(UITableView *)peripheralListTable{
    if (_peripheralListTable == nil) {
        _peripheralListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, kScreenWidth, _crazyfireUUIDArr.count * 64) style:UITableViewStylePlain];
        [_peripheralListTable setDataSource:self];
        [_peripheralListTable setDelegate:self];
        [_peripheralListTable setScrollEnabled:NO];
    }
    return _peripheralListTable;
}
-(NSMutableArray *)peripherals{
    if (_peripherals == nil) {
        _peripherals = [[NSMutableArray alloc] init];
    }
    return _peripherals;
}
#pragma mark - 视图
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.view setBackgroundColor:colorWithRGBA(246, 245, 242, 1)];
    //本地取该用户储存的蓝牙硬件信息
    _crazyfireUUIDArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"crazyfireUUIDArrKEY"];
    
    [self creatChildViews];
}
#pragma mark - 类内方法
-(void)creatChildViews{
    //设备列表
    [self.view addSubview:self.peripheralListTable];
}


#pragma mark - UITabeleView 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _crazyfireUUIDArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //初始化cell数据!
    //网络取出绑定的数组 ->_crazyfireUUIDArr(头像+昵称+UUID)
    
    [cell.imageView setImage:[UIImage imageNamed:@"baby"]];
    [cell.textLabel setText:@"萌宝CF"];
//    NSString *UUID = [_crazyfireUUIDArr objectAtIndex:indexPath.row];
//    [cell.detailTextLabel setText:UUID];
    
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
