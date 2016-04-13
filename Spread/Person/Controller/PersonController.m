//
//  PersonController.m
//  Spread
//
//  Created by qiuxuewei on 16/3/21.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "PersonController.h"
#import "LocationSetUpController.h"
#import "LinkPersonController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AboutSelfController.h"
#import "XWBlueToothController.h"
#import "XWAlertController.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface PersonController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>{
    
}



//属性列表
/** 顶部图片视图 */
@property (nonatomic, strong) UIView *headerBackView;
@property (nonatomic, strong) UIImageView *headerImageView;
/** 个人信息界面 */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PersonController
#pragma mark - 懒加载
-(UIView *)headerBackView{
    if (_headerBackView == nil) {
        _headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        [_headerBackView setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _headerBackView;
}
-(UIImageView *)headerImageView{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        NSString *iconImageStr = [[NSUserDefaults standardUserDefaults] objectForKey:@""];
        if (iconImageStr) {
            NSData *iconImageData = [[NSData alloc] initWithBase64EncodedString:iconImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *iconImage = [UIImage imageWithData:iconImageData];
            [_headerImageView setImage:iconImage];
        }else{
            [_headerImageView setImage:[UIImage imageNamed:@"iconMM.jpg"]];
        }
        [_headerImageView setBackgroundColor:[UIColor greenColor]];
        [_headerImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headerImageView setClipsToBounds:YES];
        //添加交互方法
        [_headerImageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *headerImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_headerImageView addGestureRecognizer:headerImageViewTap];
    }
    return _headerImageView;
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //添加子视图
    [self addChildViews];
}
#pragma mark - 类内方法
//添加子视图
-(void)addChildViews{
    
    //自定义BarButtonItem
    UIButton *locationSetUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationSetUpBtn setBackgroundImage:[UIImage imageNamed:@"Location_64px"] forState:UIControlStateNormal];
    [locationSetUpBtn setFrame:CGRectMake(0, 0, 32, 32)];
    [locationSetUpBtn addTarget:self action:@selector(locationSetUpClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *locationBarBtnCustom = [[UIBarButtonItem alloc] initWithCustomView:locationSetUpBtn];
    self.navigationItem.rightBarButtonItem = locationBarBtnCustom;
    
    //添加表格
    [self.view addSubview:self.tableView];
    //添加头像图片
    [self addHeaderImageView];

}
//添加头像
-(void)addHeaderImageView{
    [self.tableView setTableHeaderView:self.headerBackView];
    [self.headerImageView setFrame:self.headerBackView.bounds];
    [self.headerBackView addSubview:self.headerImageView];
}
//定位设置
-(void)locationSetUpClick{
    NSLog(@"locationSetUpClick");
    LocationSetUpController *locationSetUpVC = [[LocationSetUpController alloc] init];
    [locationSetUpVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:locationSetUpVC animated:YES];

}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

#pragma mark UITableView点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态。
    // 加上此句，返回时直接就是非选中状态。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        //第二模块
        if (indexPath.row == 0) {
            //绑定蓝牙硬件
            LinkPersonController *linkPersonVC = [[LinkPersonController alloc] init];
            [linkPersonVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:linkPersonVC animated:YES];
        }else if (indexPath.row == 1){
            //添加蓝牙硬件
            XWBlueToothController *MyBlueToothVC = [[XWBlueToothController alloc] init];
            [MyBlueToothVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:MyBlueToothVC animated:YES];
            
        }else if (indexPath.row == 2){
            AboutSelfController *aboutSelfVC = [[AboutSelfController alloc] init];
            [aboutSelfVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:aboutSelfVC animated:YES];
        }
        
        
    }else{
        //第一模块
        
    }
}

//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //个人信息
    if (indexPath.section == 0) {
        static NSString *PersonInfoCell = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonInfoCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:PersonInfoCell];
        }
        //初始化cell数据!
        [cell.textLabel setText:@"阿伟"];
        [cell.detailTextLabel setText:@"2016-03-22"];
        
        return cell;

    }
    
    //
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.6F]];
        
    }
    //初始化cell数据!
    if (indexPath.row == 0) {
        [cell.imageView setImage:[UIImage imageNamed:@"add_about"]];
        [cell.textLabel setText:@"绑定蓝牙硬件"];
    }else if (indexPath.row == 1){
        [cell.imageView setImage:[UIImage imageNamed:@"My_about"]];
        [cell.textLabel setText:@"我的蓝牙硬件"];
    }else if (indexPath.row == 2){
        [cell.imageView setImage:[UIImage imageNamed:@"About"]];
        [cell.textLabel setText:@"关于扩散"];
    }
    return cell;
}

//滚动tableview 完毕之后
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //图片高度
    CGFloat imageHeight = self.headerBackView.frame.size.height;
    //图片宽度
    CGFloat imageWidth = kScreenWidth;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    
    NSLog(@"图片上下偏移量 imageOffsetY:%f ->",imageOffsetY);
    
    //上移
    if (imageOffsetY < 0) {
        //总共偏移量 图片高度+偏移距离的绝对值(ABS())
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        //缩放比例
        CGFloat f = totalOffset / imageHeight;
        //恢复
        self.headerImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}

#pragma mark - 图片剪裁->
-(void)editPortrait{
    __weak typeof(self) weakSelf = self;
    
    
//#warning ->测试->XW
//    XWAlertController *choiceAV = [XWAlertController XWAlertDefaultMessage:@"OK" alertControllerWithTitle:nil message:@"选择头像" preferredStyle:UIAlertControllerStyleAlert];
//    [choiceAV show];
    
    //正确代码->
    UIAlertController *choicePhotoAC = [UIAlertController alertControllerWithTitle:nil message:@"选择宝宝头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cameraAA = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相机");
        
        // 从相册中选取
        if ([weakSelf isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = weakSelf;
            [weakSelf presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }

        
    }];
    
    UIAlertAction *photoAA = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍照");
        if (![weakSelf isCameraAvailable]) {
            return ;
        }
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([weakSelf isFrontCameraAvailable]) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = weakSelf;
        [weakSelf presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
        
    }];
    [choicePhotoAC addAction:cancelAA];
    [choicePhotoAC addAction:cameraAA];
    [choicePhotoAC addAction:photoAA];
    
    [self presentViewController:choicePhotoAC animated:YES completion:nil];
}


#pragma mark VPImageCropperDelegate
//剪裁完调用
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.headerImageView.image = editedImage;
    //将此照片保存本地
    NSData *iconData = UIImageJPEGRepresentation(editedImage, 0.3);
    NSString *iconImageStr = [iconData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [[NSUserDefaults standardUserDefaults] setObject:iconImageStr forKey:@"iconImageStr"];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

//点击取消调用
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // present the cropper view controller
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width+120) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self presentViewController:imgCropperVC animated:YES completion:^{
            // TO DO
            NSLog(@"我要剪裁图片了");
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
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
