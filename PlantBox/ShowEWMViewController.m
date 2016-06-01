//
//  ShowEWMViewController.m
//  PlantBox
//
//  Created by admin on 16/5/20.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "ShowEWMViewController.h"
#import "NextManger.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
@interface ShowEWMViewController ()<UMSocialUIDelegate>
{
    NextManger *manger;
}
@end

@implementation ShowEWMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    manger = [NextManger shareInstance];
    UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2-((ScreenWidth/1.4)/2), 40, ScreenWidth/1.4, ScreenWidth/1.4+50)];
    bgV.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    imgv.layer.cornerRadius = 20;
    imgv.image = [UIImage imageNamed:@"testUserImg"];
//    imgv.image = [UIImage imageNamed:@""]
    [bgV addSubview:imgv];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, ScreenWidth/1.2-60, 25)];
    nameLab.text = manger.userC_Name;
    nameLab.font = [UIFont systemFontOfSize:15];
    [bgV addSubview:nameLab];
    
    UILabel *arrdessLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, ScreenWidth/1.2-60, 25)];
    arrdessLab.text = manger.userAddress;
    arrdessLab.font = [UIFont systemFontOfSize:13];
    [bgV addSubview:arrdessLab];
    
    UIImageView *qRCodeUrl = [[UIImageView alloc] initWithFrame:CGRectMake(bgV.bounds.size.width/2-(ScreenWidth/1.6-25)/2, 60, ScreenWidth/1.6-25, ScreenWidth/1.6-25)];
//    qRCodeUrl.backgroundColor = [UIColor redColor];
    [qRCodeUrl sd_setImageWithURL:[NSURL URLWithString:manger.userEWM]];
    [bgV addSubview:qRCodeUrl];
    
    
    [self.view addSubview:bgV];
    
    UIButton *meassageBut = ({
        UIButton *meassageBut = [UIButton buttonWithType:UIButtonTypeCustom];
        meassageBut.frame = CGRectMake(0, 0, 23, 8);
        [meassageBut addTarget:self action:@selector(showActionsheet) forControlEvents:UIControlEventTouchDown];
        [meassageBut setImage:[UIImage imageNamed:@"附近"]forState:UIControlStateNormal];
        meassageBut;
    });
    
    UIBarButtonItem *rBtn = [[UIBarButtonItem alloc] initWithCustomView:meassageBut];
    self.navigationItem.rightBarButtonItem = rBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showActionsheet
{
//    [UMSocialData defaultData].extConfig.title = @"植物君邀请您加入PlantBox的世界";
//    [UMSocialData defaultData].extConfig.qqData.url = @"http://oa.meidp.com/";
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"57429ef6e0f55a7716000931"
//                                      shareText:[NSString stringWithFormat:@"%@",manger.userEWM]
//                                     shareImage:[UIImage imageNamed:@"plantBox"]
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
//                                       delegate:self];
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:manger.userEWM];
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57429ef6e0f55a7716000931"
                                      shareText:@"植物君邀请您加入PlantBox的世界"
                                     shareImage:[UIImage imageNamed:@"plantBox"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline,UMShareToSina]
                                       delegate:self];
    
}
//实现回调方法：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
@end
