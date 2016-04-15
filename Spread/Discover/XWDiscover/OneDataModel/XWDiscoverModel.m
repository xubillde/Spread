//
//  XWDiscoverModel.m
//  Spread
//
//  Created by 邱学伟 on 16/4/6.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  cell 每条数据的模型

#import "XWDiscoverModel.h"

@implementation XWDiscoverModel

+ (XWDiscoverModel *)getTestModel {
    XWDiscoverModel *testModel = [[XWDiscoverModel alloc] init];
    testModel.titleModel = [XWDiscoverTitleModel getTestModel];
    testModel.contentModel = [XWDiscoverContentModel getTestModel];
    
    int modelSwitch = (arc4random() % 3);
    switch (modelSwitch) {
        case 0:
        {
            testModel.imageModel = [XWDiscoverImageModel getTestModel];
        }
            break;
        case 1:
        {
            testModel.shareModel = [XWDiscoverShareModel getTestModel];
        }
            break;
        case 2:
        {
            testModel.videoModel = [XWDiscoverVideoModel getTestModel];
        }
            break;
            
        default: {
            
        }
            break;
    }
    
    testModel.commentsModel = [XWDiscoverCommentsModel getTestModel];
    return testModel;
}

+(XWDiscoverModel *)getModel{
    XWDiscoverModel *discoverModel = [[XWDiscoverModel alloc] init];
    
    [discoverModel setTitleModel:[XWDiscoverTitleModel getTitleModelWithHeadIocnUrlStr:@"http://www.zgshjj.com/uploads/allimg/c101202/12912542391bF-3392Q.jpg" withUserName:@"crazyfire" withTime:@"2016-4-11"]];
    
    [discoverModel setContentModel:[XWDiscoverContentModel getContentModelWithContent:@"\"轻度App\"是疯火科技为旗下智能代步车开发的手机端控制软件，借助“轻度”可以随心所欲的操控您的代步车：速度控制：通过蓝牙匹配到您的代步车后，可以限制车的速度，方便新手骑行； 仪表显示：提供仪表盘显示，实时关注代步车的行驶速度、剩余电量、行驶历程，剩余行驶里程；3、个性化车灯：一键设置代步车转把上的个性化车灯，由疯火科技自主研发的高亮智能照明控制系统可提供1600种颜色随心所欲的变色，4、地图导航：提供地图导航功能，想去哪里，随心所欲，车友实时位置共享，让邂逅更容易，车友附近出没，更及时的了解车友动态；5、安全预警：超速预警，保证您的安全，低电量提醒，自动转入助力模式，滑行更方便；"]];
    [discoverModel setCommentsModel:[XWDiscoverCommentsModel getCommentModelWithIsPraised:NO withPraisedCount:(arc4random()%500)+1 withCommentCount:(arc4random()%500)+2 withIsCommented:NO]];
    
    //随机三个种类
    int modelSwitch  = (arc4random() % 3);
    switch (modelSwitch) {
        case 0:{
            NSMutableArray *imageLib = [NSMutableArray arrayWithObjects:@"http://i9.download.fd.pchome.net/g1/M00/12/1C/ooYBAFbpI0mICtMaAAOO40OgNKEAAC4CAPum6AAA477169.jpg",
                                        @"http://i4.download.fd.pchome.net/g1/M00/0F/0D/ooYBAFU_PFyIGi8eAAPotewjNYoAACcOgI_fFgAA-jN703.jpg",
                                        @"http://i5.download.fd.pchome.net/g1/M00/0C/1E/ooYBAFR-sMmIPII9AAQ44H7d-mkAACIYAFCbLMABDj4877.jpg",
                                        @"http://i4.download.fd.pchome.net/g1/M00/0C/1E/oYYBAFR-sOeIF8DvAALddopx87EAACIYAGfCF0AAt2O799.jpg",
                                        @"http://i2.download.fd.pchome.net/g1/M00/12/05/oYYBAFZX48CIZvN4AAdCTLqK6OEAACyRANW6YIAB0Jk130.jpg",
                                        @"http://i9.download.fd.pchome.net/g1/M00/10/0F/ooYBAFWVBg2IPOHiAAQCRrcQQhQAACkqQNHyk4ABAJe933.jpg",
                                        @"http://i6.download.fd.pchome.net/g1/M00/0E/01/oYYBAFTRvsWIWgGrAB0ClZt8mJgAACRUwCT534AHQKt428.jpg",
                                        @"http://i2.download.fd.pchome.net/g1/M00/0D/1A/oYYBAFTAw-yIPJ7QABQEd17ze4kAACPnQEZdIYAFASP791.jpg",
                                        @"http://i9.download.fd.pchome.net/g1/M00/0C/15/oYYBAFRuldCID7I_AAW9FwJLAHoAACGQQLxMdAABb0v093.jpg", nil];
            //随机生成图片个数
            int imageCount = arc4random() % 10;
            NSMutableArray *beReturnImageArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < imageCount; i++) {
                int imageIndex = (arc4random() % imageLib.count);
                NSString *imageUrl = [imageLib objectAtIndex:imageIndex];
                [beReturnImageArr addObject:imageUrl];
                [imageLib removeObjectAtIndex:imageIndex];
            }
            
            //如果图片只有一张,随机尺寸
            NSArray *sizeArr = [[NSArray alloc] init];
            if (beReturnImageArr.count == 1) {
                int modelSwitch = arc4random() % 2;
                switch (modelSwitch) {
                    case 0:
                    {
                        sizeArr = [NSArray arrayWithObjects:@"800x600", nil];
                    }
                        break;
                    case 1:{
                        sizeArr = [NSArray arrayWithObjects:@"1080x1920", nil];
                    }
                    default:
                        break;
                }
            }
            
            [discoverModel setImageModel:[XWDiscoverImageModel getImageModelWithImageUrlArr:beReturnImageArr withSizeArr:sizeArr]];
        }
            break;
        case 1:{
            [discoverModel setShareModel:[XWDiscoverShareModel getShreModelWithThumImageUrlStr:@"http://pic.baomihua.com/photos/201104/m_634376313000085000_40197732.jpg" withTitle: @"这是分享模块model分享模块model分享模块model分享模块model" withSummary:@"疯火科技,疯火科技,这是疯火科技哈~~n疯火科技,疯火科技,这是疯火科技哈~isi疯火科技,疯火科技,这是疯火科技哈~owo疯火科技,疯火科技,这是疯火科技哈~" withUrlStr:@"http://www.crazyfire.love"]];
        }
            break;
        case 2:{
            NSString *name = [[NSString alloc] init];
            NSString *duration = @"10";
            NSString *thumImageUrlStr = [[NSString alloc] init];
            NSString *videoUrlStr = [[NSString alloc] init];
            NSInteger width,height;
            
            int modelSwitch = arc4random() % 2;
            switch (modelSwitch) {
                case 0:
                {
                    name = [NSString stringWithFormat:@"%d号名称",modelSwitch];
                    thumImageUrlStr = @"http://a3.att.hudong.com/76/53/28300001051406138369533085488_950.jpg";
                    videoUrlStr = @"http://v.ku6.com/show/3-i-l2cFChtf4CycVnvZgQ...html";
                    width = 800;
                    height = 452;
                }
                    break;
                case 1:
                {
                    name = [NSString stringWithFormat:@"%d号名称",modelSwitch];
                    thumImageUrlStr = @"http://www.sh.xinhuanet.com/titlepic/134420730_1437097105798_title1n.jpg";
                    videoUrlStr = @"http://v.ku6.com/show/3-i-l2cFChtf4CycVnvZgQ...html";
                    width = 500;
                    height = 753;
                }
                    break;
                    
                default:
                    break;
            }
            
            [discoverModel setVideoModel:[XWDiscoverVideoModel getVideoModelWithName:name withDuration:duration  withThumImageUrlStr:thumImageUrlStr withVideoUrlStr:videoUrlStr withWidth:width withHeight:height]];
        }
            break;
        default:
            break;
    }
    
    return discoverModel;
}

@end

#pragma mark - 标题model

@implementation XWDiscoverTitleModel

+(XWDiscoverTitleModel *)getTitleModelWithHeadIocnUrlStr:(NSString *)headIocnUrlStr withUserName:(NSString *)userName withTime:(NSString *)time
{
    XWDiscoverTitleModel *titleModel = [[XWDiscoverTitleModel alloc] init];
    [titleModel setHeadIocnUrlStr:headIocnUrlStr];
    [titleModel setUserName:userName];
    [titleModel setTime:time];
    return titleModel;
}

//用户头像
+ (XWDiscoverTitleModel *)getTestModel {
    XWDiscoverTitleModel *testModel = [[XWDiscoverTitleModel alloc] init];
    testModel.headIocnUrlStr = @"http://www.zgshjj.com/uploads/allimg/c101202/12912542391bF-3392Q.jpg";
    testModel.userName = @"crazyfire";
    testModel.time = @"2016-4-6";
    return testModel;
}

@end

#pragma mark - 文本主体model

@implementation XWDiscoverContentModel

+(XWDiscoverContentModel *)getContentModelWithContent:(NSString *)content{
    XWDiscoverContentModel *contentModel = [[XWDiscoverContentModel alloc] init];
    [contentModel setContent:content];
    return contentModel;
}

+ (XWDiscoverContentModel *)getTestModel {
    XWDiscoverContentModel *testModel = [[XWDiscoverContentModel alloc] init];
    testModel.content = @"\"轻度App\"是疯火科技为旗下智能代步车开发的手机端控制软件，借助“轻度”可以随心所欲的操控您的代步车：速度控制：通过蓝牙匹配到您的代步车后，可以限制车的速度，方便新手骑行； 仪表显示：提供仪表盘显示，实时关注代步车的行驶速度、剩余电量、行驶历程，剩余行驶里程；3、个性化车灯：一键设置代步车转把上的个性化车灯，由疯火科技自主研发的高亮智能照明控制系统可提供1600种颜色随心所欲的变色，4、地图导航：提供地图导航功能，想去哪里，随心所欲，车友实时位置共享，让邂逅更容易，车友附近出没，更及时的了解车友动态；5、安全预警：超速预警，保证您的安全，低电量提醒，自动转入助力模式，滑行更方便；";
    return testModel;
}


@end

#pragma mark - 图片模块

@implementation XWDiscoverImageModel

+(XWDiscoverImageModel *)getImageModelWithImageUrlArr:(NSArray *)imageUrlArr withSizeArr:(NSArray *)sizeArr{
    XWDiscoverImageModel *imageModel = [[XWDiscoverImageModel alloc] init];
    [imageModel setImageUrlArr:imageUrlArr];
    [imageModel setSizeArr:sizeArr];
    return imageModel;
}


+ (XWDiscoverImageModel *)getTestModel {
    XWDiscoverImageModel *testModel = [[XWDiscoverImageModel alloc] init];
    NSMutableArray *imageLib = [NSMutableArray arrayWithObjects:@"http://i9.download.fd.pchome.net/g1/M00/12/1C/ooYBAFbpI0mICtMaAAOO40OgNKEAAC4CAPum6AAA477169.jpg",
                                @"http://i4.download.fd.pchome.net/g1/M00/0F/0D/ooYBAFU_PFyIGi8eAAPotewjNYoAACcOgI_fFgAA-jN703.jpg",
                                @"http://i5.download.fd.pchome.net/g1/M00/0C/1E/ooYBAFR-sMmIPII9AAQ44H7d-mkAACIYAFCbLMABDj4877.jpg",
                                @"http://i4.download.fd.pchome.net/g1/M00/0C/1E/oYYBAFR-sOeIF8DvAALddopx87EAACIYAGfCF0AAt2O799.jpg",
                                @"http://i2.download.fd.pchome.net/g1/M00/12/05/oYYBAFZX48CIZvN4AAdCTLqK6OEAACyRANW6YIAB0Jk130.jpg",
                                @"http://i9.download.fd.pchome.net/g1/M00/10/0F/ooYBAFWVBg2IPOHiAAQCRrcQQhQAACkqQNHyk4ABAJe933.jpg",
                                @"http://i6.download.fd.pchome.net/g1/M00/0E/01/oYYBAFTRvsWIWgGrAB0ClZt8mJgAACRUwCT534AHQKt428.jpg",
                                @"http://i2.download.fd.pchome.net/g1/M00/0D/1A/oYYBAFTAw-yIPJ7QABQEd17ze4kAACPnQEZdIYAFASP791.jpg",
                                @"http://i9.download.fd.pchome.net/g1/M00/0C/15/oYYBAFRuldCID7I_AAW9FwJLAHoAACGQQLxMdAABb0v093.jpg", nil];
    
    int imageCount = arc4random() % 10;//生成图片个数
    NSMutableArray *beReturnImageArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageCount; i+=1) {
        int imageIndex = (arc4random() % imageLib.count);//生成随机插入图片的下标
        NSString *imageUrl = [imageLib objectAtIndex:imageIndex];
        [beReturnImageArr addObject:imageUrl];
        [imageLib removeObjectAtIndex:imageIndex];
    }
    
    if (beReturnImageArr.count == 1) {
        int modelSwitch = arc4random() % 2;
        switch (modelSwitch) {
            case 0:
            {
                testModel.sizeArr = [NSArray arrayWithObjects:@"800x600", nil];
            }
                break;
            case 1:
            {
                testModel.sizeArr = [NSArray arrayWithObjects:@"1080x1920", nil];
            }
                break;
            default: {
                
            }
                break;
        }
    }
    testModel.imageUrlArr = beReturnImageArr;
    return testModel;
}

@end

#pragma mark - 分享模块

@implementation XWDiscoverShareModel

+(XWDiscoverShareModel *)getShreModelWithThumImageUrlStr:(NSString *)thumImageUrlStr withTitle:(NSString *)title withSummary:(NSString *)summary withUrlStr:(NSString *)urlStr{
    XWDiscoverShareModel *shareModel = [[XWDiscoverShareModel alloc] init];
    [shareModel setThumImageUrlStr:thumImageUrlStr];
    [shareModel setTitle:title];
    [shareModel setSummary:summary];
    [shareModel setUrlStr:urlStr];
    return shareModel;
}

+ (XWDiscoverShareModel *)getTestModel {
    XWDiscoverShareModel *testModel = [[XWDiscoverShareModel alloc] init];
    testModel.thumImageUrlStr = @"http://pic.baomihua.com/photos/201104/m_634376313000085000_40197732.jpg";
    testModel.title = @"这是分享模块model";
    testModel.summary = @"疯火科技,疯火科技,这是疯火科技哈~~";
    testModel.urlStr =  @"http://www.crazyfire.love";
    return testModel;
}

@end

#pragma mark - 视频模块

@implementation XWDiscoverVideoModel

+(XWDiscoverVideoModel *)getVideoModelWithName:(NSString *)name withDuration:(NSString *)duration withThumImageUrlStr:(NSString *)thumImageUrlStr withVideoUrlStr:(NSString *)videoUrlStr withWidth:(NSInteger)width withHeight:(NSInteger)height{
    XWDiscoverVideoModel *videoModel = [[XWDiscoverVideoModel alloc] init];
    [videoModel setName:name];
    [videoModel setDuration:duration];
    [videoModel setThumImageUrlStr:thumImageUrlStr];
    [videoModel setWidth:width];
    [videoModel setHeight:height];
    return videoModel;
}

+ (XWDiscoverVideoModel *)getTestModel {
    XWDiscoverVideoModel *testModel = [[XWDiscoverVideoModel alloc] init];
    int modelSwitch = arc4random() % 2;
    switch (modelSwitch) {
        case 0:
        {
            testModel.thumImageUrlStr = @"http://a3.att.hudong.com/76/53/28300001051406138369533085488_950.jpg";
            testModel.videoUrlStr = @"http://v.ku6.com/show/3-i-l2cFChtf4CycVnvZgQ...html";
            testModel.width = 800;
            testModel.height = 452;
        }
            break;
        case 1:
        {
            testModel.thumImageUrlStr = @"http://www.sh.xinhuanet.com/titlepic/134420730_1437097105798_title1n.jpg";
            testModel.videoUrlStr = @"http://v.ku6.com/show/3-i-l2cFChtf4CycVnvZgQ...html";
            testModel.width = 500;
            testModel.height = 753;
        }
            break;
        default: {
            
        }
            break;
    }
    return testModel;
}

@end

#pragma mark - 评论点赞模块

@implementation XWDiscoverCommentsModel

+(XWDiscoverCommentsModel *)getCommentModelWithIsPraised:(BOOL)isPraised withPraisedCount:(NSInteger)praisedCount withCommentCount:(NSInteger)commentCount withIsCommented:(BOOL)isCommented{
    
    XWDiscoverCommentsModel *commentModel = [[XWDiscoverCommentsModel alloc] init];
    [commentModel setIsPraised:isPraised];
    [commentModel setCommentCount:commentCount];
    [commentModel setIsCommented:isCommented];
    [commentModel setCommentCount:commentCount];
    
    return commentModel;
}

+ (XWDiscoverCommentsModel *)getTestModel {
    XWDiscoverCommentsModel *testModel = [[XWDiscoverCommentsModel alloc] init];
    testModel.praisedCount = (arc4random() % 500) + 1;
    testModel.commentCount = (arc4random() % 500) + 1;
    return testModel;
}

@end