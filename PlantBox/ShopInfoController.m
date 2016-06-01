//
//  ShopInfoController.m
//  PlantBox
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "ShopInfoController.h"
//#import "ShopCarNextMangerModel.h"
#import "OrderController.h"
#import "ShopInfoCell.h"
#import "ShopImgCell.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "webView/WebModel.h"
#import "WebViewController.h"
#import "UIImageView+WebCache.h"
#import "PlantBKController.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
//#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
//#import <ShareSDK/ShareSDK+Base.h>
//
//#import <ShareSDKExtension/ShareSDK+Extension.h>

#import "UMSocial.h"
//#import "ShopCarAdvModel.h"

@interface ShopInfoController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    NextManger *manger;
    int count;
    NSArray *imgs;
    BOOL isCollect;
    NSString *shopName;
    NSString *shopImg;
    NSString *shopPrice;
//    NSString *classID;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *titles;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *producerName;

@end

@implementation ShopInfoController
- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *shopID = [user objectForKey:@"id"];
    self.navigationItem.title = @"商品信息";
    //    NSLog(@"shopID - %@",URL_AFWorking(shopID));
    
//    ShopCarNextMangerModel *model = [[ShopCarNextMangerModel shareShopCarData]initWithURL:URL_AFWorking(shopID)];
//    model = nil;
//    
    manger = [NextManger shareInstance];
    manger.projectID = self.shopID;
    [manger loadData:RequestOfGetproduct];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refrshData:) name:@"getproduct" object:nil];
        [self _initTableView];
}

- (void)refrshData:(NSNotification *)obj{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    self.price = [user objectForKey:@"Price"];
//    self.titles = [user objectForKey:@"title"];
//    self.producerName = [user objectForKey:@"producerName"];
//    NSLog(@"%@",obj.object);
    imgs = obj.object;
    [self.tableView reloadData];

}
- (void)_initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -69-60) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ShopInfoCell" bundle:nil]  forCellReuseIdentifier:@"ShopInfoCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ShopImgCell" bundle:nil]  forCellReuseIdentifier:@"ShopImgCell"];
    
//    self.tableView.estimatedRowHeight = 200;
    
    UIView *shopV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 115, ScreenWidth, 60)];
    shopV.backgroundColor = [UIColor whiteColor];
//    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
//    imgV.image = [UIImage imageNamed:@"kefu"];
//    [shopV addSubview:imgV];
//    
//    UIImageView *imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(45,0, 30, 30)];
//    imgV2.image = [UIImage imageNamed:@"shopfenxiang"];
//    [shopV addSubview:imgV2];
//    
//    UIImageView *imgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(75,0, 30, 30)];
//    imgV3.image = [UIImage imageNamed:@"收藏"];
//    [shopV addSubview:imgV3];
    
    UIButton *kefuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    kefuBtn.frame = CGRectMake(10, 0, 50, 50);
    [kefuBtn setImage:[UIImage imageNamed:@"客服"] forState:UIControlStateNormal];
    [kefuBtn addTarget:self action:@selector(kefuAction) forControlEvents:UIControlEventTouchDown];
    [shopV addSubview:kefuBtn];
    
    UIButton *fenxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fenxiangBtn.frame = CGRectMake(70,0, 50, 50);
    [fenxiangBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [fenxiangBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchDown];
    [shopV addSubview:fenxiangBtn];
    
    UIButton *shoucangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shoucangBtn.frame = CGRectMake(130,0, 50, 50);
    [shoucangBtn setImage:[UIImage imageNamed:@"收藏1"] forState:UIControlStateNormal];
    [shoucangBtn setImage:[UIImage imageNamed:@"收藏0"] forState:UIControlStateNormal];
    [shoucangBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchDown];
    [shopV addSubview:shoucangBtn];
    
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(ScreenWidth - (ScreenWidth/2-60)-10,0, ScreenWidth/2-60, 40);
    buyBtn.layer.cornerRadius = 2;
    buyBtn.backgroundColor = [UIColor orangeColor];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(alerCtl) forControlEvents:UIControlEventTouchDown];
    [shopV addSubview:buyBtn];
    
    [self.view addSubview:shopV];
    
}
- (void)kefuAction
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
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
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

- (void)shareAction
{
    //            [self ShareApp:self.view];
    [UMSocialData defaultData].extConfig.title = @"植物君邀请您加入PlantBox的世界";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://oa.meidp.com/";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57429ef6e0f55a7716000931"
                                      shareText:@"加入植物盒子，享受绿色生活，http://oa.meidp.com/"
                                     shareImage:[UIImage imageNamed:@"plantBox"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:self];
}
- (void)alerCtl{
//    UIAlertController *errorAlertV = [UIAlertController alertControllerWithTitle:@"抱歉" message:@"当前版本暂不支持该操作" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
////        [self.navigationController popToRootViewControllerAnimated:YES];
//    }];
//    [errorAlertV addAction:cancel];
//    [self presentViewController:errorAlertV animated:YES completion:nil];
    if (count == 0) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您购买的商品数目为0" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    OrderController *subVC = [[OrderController alloc] init];
    subVC.orderCount = count;
    subVC.orderImg = shopImg;
    subVC.orderName = shopName;
    subVC.orderPrice = shopPrice;
    subVC.shopID = self.shopID;
    [self.navigationController pushViewController:subVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController.navigationBar setTranslucent:NO];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return imgs.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 440;
    }
    else
    {
        return ScreenWidth*0.8;

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0)
    {
        ProjectModel *model = manger.m_ProductShopInfoLists[indexPath.row];
        ShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopInfoCell"];
        cell.producrName.text = model.shopInfoListName;
        shopName = cell.producrName.text;
        cell.title.text = model.shopInfoListNotice;
        cell.bayTotal.text = model.shopInfoListTotalBuy;
        cell.price.text = [NSString stringWithFormat:@"价格:%@",model.shopinfoListPrice];
        shopPrice = model.shopinfoListPrice;
        cell.countLab.text = [NSString stringWithFormat:@"%d",count];
//        manger.keyword = model.shopinfoListID;
        shopImg = imgs[0];
//        cell.cellImg.contentMode = UIViewContentModeScaleAspectFit;
        [cell.cellImg sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
        cell.selectionStyle = UITableViewCellStyleDefault;
        
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchDown];
        
        [cell.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchDown];
//        [cell.collectionBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchDown];
        cell.pushBK.tag = [model.shopinfoListID integerValue];
        [cell.pushBK addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchDown];
        
        return cell;
    }
    ShopImgCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ShopImgCell"];
//    cell.cellImg.contentMode = UIViewContentModeScaleAspectFit;
    [cell.cellImg sd_setImageWithURL:[NSURL URLWithString:imgs[indexPath.row]]];
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell; 
    
}

- (void)pushAction:(UIButton *)btn
{
//    
//    WebModel *model = [[WebModel alloc] initWithUrl:[NSString stringWithFormat:@"http://plantbox.meidp.com/Mobi/Home/NoticeDetail/%@",self.shopID]];
//    WebViewController *SVC = [[WebViewController alloc] init];
//    SVC.title = @"植物百科";
//    SVC.hidesBottomBarWhenPushed = YES;
//    [SVC setModel:model];
//    [self.navigationController pushViewController:SVC animated:YES];
    PlantBKController *sub = [[PlantBKController alloc] init];
    sub.title = @"植物百科";
    sub.classID = [NSString stringWithFormat:@"%ld",btn.tag];
    sub.channelId = @"1001";
    [self.navigationController pushViewController:sub animated:YES];

}
- (void)collectionAction:(UIButton *)btn
{
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"收藏0"]forState:UIControlStateSelected];
        
        btn.selected = !btn.selected;
        manger.IsCollect =  @"1";
    
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"收藏1"]forState:UIControlStateNormal];
        btn.selected = !btn.selected;
        manger.IsCollect =  @"0";
    }
    manger.userCollectFKId = self.shopID;
    [manger loadData:RequestOfuserCollect];
}
- (void)deleteBtnAction
{
    if (count == 0) {
        return;
    }
    count--;

    [self.tableView reloadData];
}
- (void)addBtnAction
{
    count++;
    [self.tableView reloadData];
}
// 等比缩放图片
- (UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)ShareApp:(ShopInfoController *)bar
{
    //    NSLog(@"url :%@",disCountDetailURL(_articleInfo.articleid)); http://viewer.maka.im/k/ORXCZ50R
    
//    
//    //    NSArray* imageArray = @[_articleInfo.imageUrl];
//    //构造分享内容 _articleInfo.title
//    NSMutableDictionary *shareParams=[NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:@"植物盒子的分享"
//                                     images:nil
//                                        url:[NSURL URLWithString:@"http://www.baidu.com"]
//                                      title:@"欢迎使用植物盒子"
//                                       type:SSDKContentTypeAuto];
//    
//    
//    
//    //    NSLog(@"%@ %@",_articleInfo.title,[NSURL URLWithString:disCountDetailURL(_articleInfo.articleid)]);
//    __weak ShopInfoController *theController = self;
//    
//    
//    [ShareSDK showShareActionSheet:bar
//                             items:nil
//                       shareParams:shareParams
//               onShareStateChanged:^(SSDKResponseState state,
//                                     SSDKPlatformType platformType,
//                                     NSDictionary *userData,
//                                     SSDKContentEntity *contentEntity,
//                                     NSError *error, BOOL end) {
//                   
//                   switch (state) {
//                           
//                       case SSDKResponseStateBegin:
//                       {
//                           //                           [theController showLoadingView:YES];
//                           break;
//                       }
//                       case SSDKResponseStateSuccess:
//                       {
//                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                               message:nil
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"确定"
//                                                                     otherButtonTitles:nil];
//                           [alertView show];
//                           break;
//                       }
//                       case SSDKResponseStateFail:
//                       {
//                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"OK"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show];
//                               break;
//                           }
//                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"OK"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show];
//                               break;
//                           }
//                           else
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:[NSString stringWithFormat:@"%@",error]
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"OK"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show];
//                               break;
//                           }
//                           break;
//                       }
//                       case SSDKResponseStateCancel:
//                       {
//                           //                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                           //                                                                               message:nil
//                           //                                                                              delegate:nil
//                           //                                                                     cancelButtonTitle:@"确定"
//                           //                                                                     otherButtonTitles:nil];
//                           //                           [alertView show];
//                           break;
//                       }
//                       default:
//                           break;
//                   }
//                   
//                   if (state != SSDKResponseStateBegin)
//                   {
//                       //                       [theController showLoadingView:NO];
//                   }
//                   
//               }];
//    
//    
//    [self.view endEditing:YES];
    
    /*
     //1、创建分享参数（必要）
     NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
     [shareParams SSDKSetupShareParamsByText:@"分享内容"
     images:[UIImage imageNamed:@"传入的图片名"]
     url:[NSURL URLWithString:@"http://mob.com"]
     title:@"分享标题"
     type:SSDKContentTypeAuto];
     
     // 定制新浪微博的分享内容
     [shareParams SSDKSetupSinaWeiboShareParamsByText:@"定制新浪微博的分享内容" title:nil image:[UIImage imageNamed:@"传入的图片名"] url:nil latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
     // 定制微信好友的分享内容
     [shareParams SSDKSetupWeChatParamsByText:@"定制微信的分享内容" title:@"title" url:[NSURL URLWithString:@"http://mob.com"] thumbImage:nil image:[UIImage imageNamed:@"传入的图片名"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];// 微信好友子平台
     
     //2、分享
     [ShareSDK showShareActionSheet:view
     items:nil
     shareParams:shareParams
     onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) { ...... }
     */
}


@end
