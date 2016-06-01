//
//  MineViewController.m
//  PlantBox
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "MineViewController.h"
#import "MyBaseViewController.h"
#import "TheActivityViewController.h"
#import "SettingViewController.h"
#import "CollectController.h"
#import "MyOrderController.h"
#import "NextManger.h"
#import "UIImageView+WebCache.h"
#import "AQCollectionVC.h"
#import "BasePlantViewController.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
//#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
//#import <ShareSDK/ShareSDK+Base.h>
//
//#import <ShareSDKExtension/ShareSDK+Extension.h>

#import "UMSocial.h"
@interface MineViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UMSocialUIDelegate>
{
    UIButton *imgBtn;
    BOOL isImgOrPhone;
}
@property (nonatomic,strong) UIImageView *userImage;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    
//    self.view.backgroundColor = [UIColor lightGrayColor];
    [self drawTopview];
//    NSArray *titles = @[@"我的基地", @"我的活动", @"我的收藏", @"我的订单", @"活动专区", @"我的分享", @"联系客服", @"我的钱包",@"设置"];
    NSArray *titles = @[@"我的基地", @"我的收藏", @"我的订单", @"我的植物", @"联系客服", @"活动专区",@"设置"];
    NSArray *imageNames = @[@"mine01",@"mine03",@"mine04",@"mine06",@"mine07",@"mine08",@"mine09"];
    
    [self drawHoneViewWithAppviewW:ScreenWidth/3 AppviewH:(ScreenHeight-ScreenHeight*0.34-19-29)/3 Totalloc:3 Count:7 ImageArray:imageNames TitleArray:titles];
    
}
- (void)drawTopview
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.37-19)];
    topView.backgroundColor = RGB(7, 115, 226);
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 19, ScreenWidth, 44)];
//    titleLab.backgroundColor = [UIColor redColor];
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = @"个人中心";
    [topView addSubview:titleLab];
    
    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2, titleLab.bounds.origin.y + 60, (ScreenHeight-ScreenHeight*0.38-19-29)/3, (ScreenHeight-ScreenHeight*0.38-19-29)/3)];
    NextManger *manger = [NextManger shareInstance];
    [_userImage sd_setImageWithURL:[NSURL URLWithString:manger.userPhoto]];
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = ((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2;
    [topView addSubview:_userImage];

    imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBtn.frame = CGRectMake(ScreenWidth/2-((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2, titleLab.bounds.origin.y + 60, (ScreenHeight-ScreenHeight*0.38-19-29)/3, (ScreenHeight-ScreenHeight*0.38-19-29)/3);
//    imgBtn.backgroundColor = [UIColor redColor];
    imgBtn.layer.borderColor = RGB(86, 168, 256).CGColor;
    imgBtn.layer.borderWidth = 1;
    imgBtn.layer.cornerRadius = ((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2;
    imgBtn.layer.masksToBounds = YES;
    imgBtn.backgroundColor = [UIColor clearColor];
//    if (_userImage.image == nil)
//    {
//        [imgBtn setImage:[UIImage imageNamed:@"testUserImg"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [imgBtn setImage:_userImage.image forState:UIControlStateNormal];
//    }
    [imgBtn addTarget:self action:@selector(changeHeadViews) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:imgBtn];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, topView.bounds.size.height-35, ScreenWidth, 30)];
//    nameLab.backgroundColor = [UIColor redColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont systemFontOfSize:15];
    
    nameLab.text = [NextManger shareInstance].userC_Name;
    [topView addSubview:nameLab];
    
    [self.view addSubview:topView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:YES animated:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [super.navigationController setNavigationBarHidden:NO animated:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 创建九宫格
- (void)drawHoneViewWithAppviewW:(CGFloat)appviewWith AppviewH:(CGFloat)appviewHeght Totalloc:(int)totalloc Count:(int)count ImageArray:(NSArray *)images TitleArray:(NSArray *)titles{
    //    三列
    //    int totalloc=3;
    //    CGFloat appvieww=80;
    //    CGFloat appviewh=100;
    CGFloat margin=([UIScreen mainScreen].bounds.size.width-totalloc*appviewWith)/(totalloc+1);
    //    int count = 8;
    for (int i=0; i<count; i++) {
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        
        CGFloat appviewx=margin+(appviewWith + .5)*loc;
        CGFloat appviewy=margin+(appviewHeght + .5)*row;
        
        //创建uiview控件
        UIView *appview=[[UIView alloc]initWithFrame:CGRectMake(appviewx,appviewy+ScreenHeight*0.37-19, appviewWith, appviewHeght)];
//        appview.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:appview];
        
        // 创建按钮
        UIButton *bTn = [UIButton buttonWithType:UIButtonTypeCustom];
        bTn.frame = CGRectMake(0, 0, appviewWith,appviewHeght);
        [bTn addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchDown];
        [bTn setBackgroundColor:[UIColor whiteColor]];
        bTn.tag = 1200 + i;
        [appview addSubview:bTn];
        
        //创建uiview控件中的子视图
        UIImageView *appimageview=[[UIImageView alloc]initWithFrame:CGRectMake(appview.bounds.size.width/2 -  appviewHeght/3,10, appviewHeght/1.5,appviewHeght/1.5)];
        UIImage *appimage=[UIImage imageNamed:images[i]];
        appimageview.image=appimage;
//        appimageview.backgroundColor = [UIColor lightGrayColor];
        [appimageview setContentMode:UIViewContentModeScaleAspectFit];
        // NSLog(@"%@",self.apps[i][@"icon"]);
        [appview addSubview:appimageview];
        
        //创建文本标签
        UILabel *applable=[[UILabel alloc]initWithFrame:CGRectMake(0, appviewHeght-30, appview.bounds.size.width, 20)];
//                applable.backgroundColor = [UIColor redColor];
        [applable setText:titles[i]];
        [applable setTextAlignment:NSTextAlignmentCenter];
        [applable setFont:[UIFont systemFontOfSize:14.0]];
        [appview addSubview:applable];
        
    }
    
}
#pragma  mark 更改头像方法
// 更改头像
- (void)changeHeadViews{
//    [self closeKeyBorads];
    isImgOrPhone = YES;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从本地中选取", nil];
    [actionSheet showInView:self.view];
}
// 实现代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (isImgOrPhone)
    {
        switch (buttonIndex) {
            case 0:
                // 拍照
                [self visitCamers];
                break;
            case 1:
                // 打开相册
                [self visitPhotos];
                break;
                
            default:
                break;
        }

    }
    else if (!isImgOrPhone)
    {
        switch (buttonIndex) {
            case 0:
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0769-82669988"]];
            }
                break;
                
            default:
                break;
        }

    }
    
}
// 访问摄像头
- (void)visitCamers{
    UIImagePickerController *pickerCamerController = [[UIImagePickerController alloc] init];
    pickerCamerController.delegate = self;
    BOOL isAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear|
                        UIImagePickerControllerCameraDeviceFront];
    if (isAvailable)
    {
        pickerCamerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSLog(@"打开相机成功");
        [self presentViewController:pickerCamerController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *camerAlert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"你的设备不支持摄像头" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [camerAlert show];
    }
}

// 访问相册
- (void)visitPhotos{
    UIImagePickerController *photoPickerController = [[UIImagePickerController alloc] init];
    photoPickerController.delegate = self;
    photoPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:photoPickerController animated:YES completion:nil];
}
// 读取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *userImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%@",info);
    _userImage.image = userImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 从相册返回
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)clickOn:(UIButton *)btn
{
    NSLog(@"click");
    switch (btn.tag) {
        case 1200:
        {
            MyBaseViewController *myBase = [[MyBaseViewController alloc] init];
            myBase.hidesBottomBarWhenPushed = YES;
            myBase.title = @"我的基地";
            [self.navigationController pushViewController:myBase animated:YES];
        }
            break;
        case 1201:
        {
            CollectController *myBase = [[CollectController alloc] init];
            myBase.hidesBottomBarWhenPushed = YES;
            myBase.title = @"我的收藏";
            [self.navigationController pushViewController:myBase animated:YES];
        }
            break;
        case 1202:
        {
            MyOrderController *myBase = [[MyOrderController alloc] init];
            myBase.hidesBottomBarWhenPushed = YES;
            myBase.title = @"我的订单";
            [self.navigationController pushViewController:myBase animated:YES];
        }
            break;
        case 1203:
        {
//            [self ShareApp:self.view];
//            [UMSocialData defaultData].extConfig.title = @"植物君邀请您加入PlantBox的世界";
//            [UMSocialData defaultData].extConfig.qqData.url = @"http://oa.meidp.com/";
//            [UMSocialSnsService presentSnsIconSheetView:self
//                                                 appKey:@"57429ef6e0f55a7716000931"
//                                              shareText:@"加入植物盒子，享受绿色生活，http://oa.meidp.com/"
//                                             shareImage:[UIImage imageNamed:@"plantBox"]
//                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
//                                               delegate:self];
            BasePlantViewController *subVC = [[BasePlantViewController alloc] init];
            subVC.hidesBottomBarWhenPushed = YES;
            subVC.title = @"基地植物";
            [self.navigationController pushViewController:subVC animated:YES];

            
        }
            break;
        case 1204:
        {
            isImgOrPhone = NO;
            [self showActionsheet];

        }
            break;
        case 1205:
        {
            TheActivityViewController *myBase = [[TheActivityViewController alloc] init];                 myBase.hidesBottomBarWhenPushed = YES;
            myBase.title = @"活动专区";
            [self.navigationController pushViewController:myBase animated:YES];
        }
            break;

        case 1206:
        {
            SettingViewController *myBase = [[SettingViewController alloc] init];
            myBase.hidesBottomBarWhenPushed = YES;
            myBase.title = @"设置";
            [self.navigationController pushViewController:myBase animated:YES];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark-
- (void)showActionsheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"拨打电话"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"0769-82669988",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

#if 0
-(void)ShareApp:(MineViewController *)bar
{
    //    NSLog(@"url :%@",disCountDetailURL(_articleInfo.articleid)); http://viewer.maka.im/k/ORXCZ50R
    
    
    //    NSArray* imageArray = @[_articleInfo.imageUrl];
    //构造分享内容 _articleInfo.title
    NSMutableDictionary *shareParams=[NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"植物盒子的分享"
                                     images:nil
                                        url:[NSURL URLWithString:@"http://www.baidu.com"]
                                      title:@"欢迎使用植物盒子"
                                       type:SSDKContentTypeAuto];
    
    
    
    //    NSLog(@"%@ %@",_articleInfo.title,[NSURL URLWithString:disCountDetailURL(_articleInfo.articleid)]);
    __weak MineViewController *theController = self;
    
    
    [ShareSDK showShareActionSheet:bar
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state,
                                     SSDKPlatformType platformType,
                                     NSDictionary *userData,
                                     SSDKContentEntity *contentEntity,
                                     NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           //                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           //                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                           //                                                                               message:nil
                           //                                                                              delegate:nil
                           //                                                                     cancelButtonTitle:@"确定"
                           //                                                                     otherButtonTitles:nil];
                           //                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin)
                   {
                       //                       [theController showLoadingView:NO];
                   }
                   
               }];
    
    
    [self.view endEditing:YES];

}
#endif
@end
