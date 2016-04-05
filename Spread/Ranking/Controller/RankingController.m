//
//  RankingController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/21.
//  Copyright © 2016年 邱学伟. All rights reserved.
// 热度排行

#import "RankingController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "OneNew.h"
#import "OneNewImage.h"
#import "SDWebImageManager.h"
#import "LinkNewsController.h"
#import <WebKit/WebKit.h>
#import "MJRefresh.h"
#import "OnlyTextCell.h"
#import "OneImageCell.h"
#import "MoreThan3ImageCell.h"
#import "UIImageView+WebCache.h"


@interface RankingController ()<UITableViewDataSource,UITableViewDelegate>{
    /** 蒙版 */
    MBProgressHUD *_MB;
    /** 新闻数组 */
    NSMutableArray *_newsArrM;
    
}

/** 新闻展示表格 */
@property (nonatomic, strong) UITableView *newsTableView;
/**
 *  存放所有下载操作的队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;

/**
 *  存放所有的下载操作（url是key，operation对象是value）
 */
@property (nonatomic, strong) NSMutableDictionary *operations;

/**
 *  存放所有下载完的图片
 */
@property (nonatomic, strong) NSMutableDictionary *images;


@end

@implementation RankingController
#pragma mark - 懒加载
- (NSOperationQueue *)queue
{
    if (!_queue) {
        self.queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (NSMutableDictionary *)operations
{
    if (!_operations) {
        self.operations = [[NSMutableDictionary alloc] init];
    }
    return _operations;
}

- (NSMutableDictionary *)images
{
    if (!_images) {
        self.images = [[NSMutableDictionary alloc] init];
    }
    return _images;
}

-(UITableView *)newsTableView{
    if (_newsTableView == nil) {
        _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44-64) style:UITableViewStylePlain];
        [_newsTableView setDelegate:self];
        [_newsTableView setDataSource:self];
        __unsafe_unretained __typeof(self) weakSelf = self;
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        _newsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getNews];
        }];
        // 马上进入刷新状态
        [_newsTableView.mj_header beginRefreshing];
        
    }
    return _newsTableView;
}

#pragma mark - 视图
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setTitle:@"新闻"];
    //设置二级界面返回按钮样式
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    //添加子视图
    [self addChildViews];
    //请求数据
    [self getNews];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
//}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 类内方法
-(void)addChildViews{
    //添加新闻展示界面
    [self.view addSubview:self.newsTableView];
    
}

#pragma mark - 网络请求获取新闻数据
-(void)getNews{
    //显示蒙版
    dispatch_async(kMainQueue, ^{
        _MB = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    });
    
    //接口路径
    NSString *path = @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news";
    
    //路径-+参数
    NSString *pathWithPhoneNum = path;
    [NSString stringWithFormat:@"%@?page=%@",path,@"1"];
    
    //中文编码
    NSString *urlPath = [pathWithPhoneNum stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //URL
    NSURL *phoneURL = [NSURL URLWithString:urlPath];
    
    //请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:phoneURL];
    
    //请求方式
    [request setHTTPMethod:@"GET"];
    
    //请求头
    [request setValue:@"0e833868d7e7bbdffa9ed5884323c0fa" forHTTPHeaderField:@"apikey"];
    
    //网络配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    //任务
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //回到主线程更新UI -> 撤销遮罩
        dispatch_async(dispatch_get_main_queue(), ^{
            [_newsTableView.mj_header endRefreshing];
            [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
            NSLog(@"所有蒙版: %ld",[MBProgressHUD allHUDsForView:self.view].count);
            
        });
        
        if (error) {
            NSLog(@"请求失败... %@",error);
            
            //提示用户请求失败!
            UIAlertController *AV = [UIAlertController alertControllerWithTitle:@"提示" message:@"抱歉,服务器错误,请稍后重试..." preferredStyle:UIAlertControllerStyleActionSheet];
            [AV addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击OK,进行相应操作,可置nil
                NSLog(@"您点击了OK..");
            }]];
            [self presentViewController:AV animated:YES completion:nil];
            
        }else{
            //JSON 解析 苹果原生效率最高
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"请求成功... %@",result);
            //获取数据->主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *showapi_res_body = [result objectForKey:@"showapi_res_body"];
                if (showapi_res_body) {
                    NSDictionary *pagebean = [showapi_res_body objectForKey:@"pagebean"];
                    if (pagebean) {
                        NSArray *contentlist = [pagebean objectForKey:@"contentlist"];
                        if (contentlist) {
                            _newsArrM = [[NSMutableArray alloc] init];
                            for (NSDictionary *newDict in contentlist) {
                                OneNew *new = [[OneNew alloc] init];
                                [new setTitle:[newDict objectForKey:@"title"]];
                                [new setDesc:[newDict objectForKey:@"desc"]];
                                [new setChannelName:[newDict objectForKey:@"channelName"]];
                                [new setSource:[newDict objectForKey:@"source"]];
                                [new setPubDate:[newDict objectForKey:@"pubDate"]];
                                [new setLink:[newDict objectForKey:@"link"]];
                                NSArray *imageurlsArr = [newDict objectForKey:@"imageurls"];
                                
                                NSMutableArray *imageurlsArrM = [[NSMutableArray alloc] init];
                                if (imageurlsArr.count != 0) {
                                    for (NSDictionary *imageDict in imageurlsArr) {
                                        OneNewImage *oneNewImage = [[OneNewImage alloc] init];
                                        [oneNewImage setUrl:[imageDict objectForKey:@"url"]];
                                        [oneNewImage setHeight:[imageDict objectForKey:@"height"]];
                                        [oneNewImage setWidth:[imageDict objectForKey:@"width"]];
                                        [imageurlsArrM addObject:oneNewImage];
                                    }
                                }
                                [new setImageurls:imageurlsArrM];
                                [_newsArrM addObject:new];
                            }
                            NSLog(@"self.newsArrM 数量 :%ld",_newsArrM.count);
                            
                            //更新UI
                            dispatch_async(kMainQueue, ^{
                                [self.newsTableView reloadData];
                            });
                        }else{
                            NSLog(@"1请求失败...");
                        }
                    }else{
                        NSLog(@"2请求失败...");
                    }
                }else{
                    NSLog(@"3请求失败...");
                }
                [MBProgressHUD hideAllHUDsForView:self.navigationController.view  animated:YES];
            });
        }
    }];
    //开始任务
    [sessionTask resume];
    
}

#pragma mark - tableview 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_newsArrM) {
        return _newsArrM.count;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_newsArrM) {
        OneNew *oneNew = [_newsArrM objectAtIndex:indexPath.section];
        NSArray *imageArr = oneNew.imageurls;
        if (imageArr.count == 0) {
            return 84;
        }else if (imageArr.count <= 2){
            return 84;
        }else{
            return 176;
        }
    }else{
        return 64;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //模型中取出新闻对象
    OneNew *oneNew = [_newsArrM objectAtIndex:indexPath.section];
    NSArray *imagesArr = oneNew.imageurls;
    
    //三种不同样式的cell
    if (imagesArr.count == 0) {
        static NSString *OnlyTextCellIdentifier = @"OnlyTextCellIdentifier";
        OnlyTextCell *onlyTextCell = [tableView dequeueReusableCellWithIdentifier:OnlyTextCellIdentifier];
        if (!onlyTextCell) {
            UINib *onlyTextCellNib = [UINib nibWithNibName:@"OnlyTextCell" bundle:nil];
            [tableView registerNib:onlyTextCellNib forCellReuseIdentifier:OnlyTextCellIdentifier];
            onlyTextCell = [tableView dequeueReusableCellWithIdentifier:OnlyTextCellIdentifier];
            [onlyTextCell.contentView setBackgroundColor:colorWithRGBA(254, 253, 254, 1)];
            [onlyTextCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [onlyTextCell.newsTitleLB setText:oneNew.title];
        [onlyTextCell.newsSourceLB setText:oneNew.source];
        return onlyTextCell;
    }else if(imagesArr.count <= 2){
        static NSString *oneImageCellIdentifier = @"oneImageCellIdentifier";
        OneImageCell *oneImageCell = [tableView dequeueReusableCellWithIdentifier:oneImageCellIdentifier];
        if (!oneImageCell) {
            UINib *oneImageCellNib = [UINib nibWithNibName:@"OneImageCell" bundle:nil];
            [tableView registerNib:oneImageCellNib forCellReuseIdentifier:oneImageCellIdentifier];
            oneImageCell = [tableView dequeueReusableCellWithIdentifier:oneImageCellIdentifier];
            [oneImageCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [oneImageCell.contentView setBackgroundColor:colorWithRGBA(254, 253, 254, 1)];
        }
        //初始化图片
        OneNewImage *oneNewImage = [oneNew.imageurls objectAtIndex:0];
        [oneImageCell.newsImageView sd_setImageWithURL:[NSURL URLWithString:oneNewImage.url] placeholderImage:[UIImage imageNamed:@"newsP"]];
        //标题
        [oneImageCell.newsTitleLB setText:oneNew.title];
        //来源
        [oneImageCell.newsSourceLB setText:oneNew.source];
        
        return oneImageCell;
        
    }else{
        static NSString *moreThan3ImageCellIdentifier = @"moreThan3ImageCellIdentifier";
        MoreThan3ImageCell *moreThan3ImageCell = [tableView dequeueReusableCellWithIdentifier:moreThan3ImageCellIdentifier];
        if (!moreThan3ImageCell) {
            UINib *moreThan3ImageCellNib = [UINib nibWithNibName:@"MoreThan3ImageCell" bundle:nil];
            [tableView registerNib:moreThan3ImageCellNib forCellReuseIdentifier:moreThan3ImageCellIdentifier];
            moreThan3ImageCell = [tableView dequeueReusableCellWithIdentifier:moreThan3ImageCellIdentifier];
            [moreThan3ImageCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [moreThan3ImageCell.contentView setBackgroundColor:colorWithRGBA(254, 253, 254, 1)];
        }
        //新闻图片
        OneNewImage *oneNewImage1 = [imagesArr objectAtIndex:0];
        [moreThan3ImageCell.newsImageView1 sd_setImageWithURL:[NSURL URLWithString:oneNewImage1.url] placeholderImage:[UIImage imageNamed:@"newsP"]];
        
        OneNewImage *oneNewImage2 = [imagesArr objectAtIndex:1];
        [moreThan3ImageCell.newsImageView2 sd_setImageWithURL:[NSURL URLWithString:oneNewImage2.url] placeholderImage:[UIImage imageNamed:@"newsP"]];
        
        OneNewImage *oneNewImage3 = [imagesArr objectAtIndex:2];
        [moreThan3ImageCell.newsImageView3 sd_setImageWithURL:[NSURL URLWithString:oneNewImage3.url] placeholderImage:[UIImage imageNamed:@"newsP"]];
        
        //设置标题和来源
        [moreThan3ImageCell.newsTitleLB setText:oneNew.title];
        [moreThan3ImageCell.newsSourceLB setText:oneNew.source];
        
        return moreThan3ImageCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_newsArrM) {
        OneNew *oneNew = [_newsArrM objectAtIndex:indexPath.section];
        LinkNewsController *linkNewsVC = [[LinkNewsController alloc] init];
        linkNewsVC.link = oneNew.link;
        [linkNewsVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:linkNewsVC animated:YES];
    }
    
}


@end
