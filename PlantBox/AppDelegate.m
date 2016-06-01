//
//  AppDelegate.m
//  PlantBox
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabbarController.h"
#import "LoginViewController.h"
#import "StarViewController.h"
#import "MMZCViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import "JPUSHService.h"

//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//
////微信SDK头文件
//#import "WXApi.h"
//
////新浪微博SDK头文件
//#import "WeiboSDK.h"
//
//
////新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

// 友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
@interface AppDelegate ()
{
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
//    //    RootTabbarController *tabbatCtl = [[RootTabbarController alloc] init];
//    LoginViewController *tabbatCtl = [[LoginViewController alloc] init];
//    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabbatCtl];
//    self.window.rootViewController = tabbatCtl;
//    [self.window makeKeyAndVisible];
    // 打开变慢
    [NSThread sleepForTimeInterval:1];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userID_Code = [user objectForKey:@"userID_Code"];
    NSLog(@"userID_Code %@",userID_Code);
//    int a = 0;
    if (userID_Code.length == 0)
    {
        StarViewController *mVC = [[StarViewController alloc] init];
        
        self.window.rootViewController = mVC;

    }
    else
    {
         MMZCViewController *login=[[MMZCViewController alloc]init];
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController=nav;
        NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
        [nav.navigationBar setTitleTextAttributes:attributes];

    }
    
    
    // 百度地图
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"eqxZyXnUPMmFhfocwllLG05tqEl04Wma"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    // Add the navigation controller's view to the window and display.
    
    // 极光推送
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    // Required
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"PushConfig" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    [JPUSHService setupWithOption:launchOptions appKey:dic[@"APP_KEY"] channel:dic[@"CHANNEL"] apsForProduction:NO];

#if 0
    // 配置ShareSDK
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。我们Demo提供的appKey为内部测试使用，可能会修改配置信息，请不要使用。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"12c749bc709df"
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeTencentWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeFacebook),
                            @(SSDKPlatformTypeTwitter),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeDouBan),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeKaixin),
                            @(SSDKPlatformTypeGooglePlus),
                            @(SSDKPlatformTypePocket),
                            @(SSDKPlatformTypeInstagram),
                            @(SSDKPlatformTypeLinkedIn),
                            @(SSDKPlatformTypeTumblr),
                            @(SSDKPlatformTypeFlickr),
                            @(SSDKPlatformTypeWhatsApp),
                            @(SSDKPlatformTypeYouDaoNote),
                            @(SSDKPlatformTypeLine),
                            @(SSDKPlatformTypeYinXiang),
                            @(SSDKPlatformTypeEvernote),
                            @(SSDKPlatformTypeYinXiang),
                            @(SSDKPlatformTypeAliPaySocial),
                            @(SSDKPlatformTypePinterest),
                            @(SSDKPlatformTypeKakao),
                            @(SSDKPlatformSubTypeKakaoTalk),
                            @(SSDKPlatformSubTypeKakaoStory),
                            @(SSDKPlatformTypeDropbox),
                            @(SSDKPlatformTypeVKontakte),
                            @(SSDKPlatformTypeMingDao),
                            @(SSDKPlatformTypePrint),
                            @(SSDKPlatformTypeYiXin),
                            @(SSDKPlatformTypeInstapaper),
                            @(SSDKPlatformTypeFacebookMessenger)
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;

                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"3002755918"
                                                appSecret:@"48af75ed85824e29a50a027a289f6ebb"
                                              redirectUri:@"http://www.baidu.com"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeTencentWeibo:
                      //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                      [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
                                                   appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                                 redirectUri:@"http://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeFacebook:
                      //设置Facebook应用信息，其中authType设置为只用SSO形式授权
                      [appInfo SSDKSetupFacebookByApiKey:@"107704292745179"
                                               appSecret:@"38053202e1a5fe26c80c753071f0b573"
                                                authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeTwitter:
                      [appInfo SSDKSetupTwitterByConsumerKey:@"LRBM0H75rWrU9gNHvlEAA2aOy"
                                              consumerSecret:@"gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G"
                                                 redirectUri:@"http://mob.com"];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"100371282"
                                           appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                         authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeDouBan:
                      [appInfo SSDKSetupDouBanByApiKey:@"02e2cbe5ca06de5908a863b15e149b0b"
                                                secret:@"9f1e7b4f71304f2f"
                                           redirectUri:@"http://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeRenren:
                      [appInfo SSDKSetupRenRenByAppId:@"226427"
                                               appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                            secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                             authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeKaixin:
                      [appInfo SSDKSetupKaiXinByApiKey:@"358443394194887cee81ff5890870c7c"
                                             secretKey:@"da32179d859c016169f66d90b6db2a23"
                                           redirectUri:@"http://www.sharesdk.cn/"];
                      break;
                  case SSDKPlatformTypeGooglePlus:
                      
                      [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                                                clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                                                 redirectUri:@"http://localhost"];
                      break;
                  case SSDKPlatformTypePocket:
                      [appInfo SSDKSetupPocketByConsumerKey:@"11496-de7c8c5eb25b2c9fcdc2b627"
                                                redirectUri:@"pocketapp1234"
                                                   authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeInstagram:
                      [appInfo SSDKSetupInstagramByClientID:@"ff68e3216b4f4f989121aa1c2962d058"
                                               clientSecret:@"1b2e82f110264869b3505c3fe34e31a1"
                                                redirectUri:@"http://sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeLinkedIn:
                      [appInfo SSDKSetupLinkedInByApiKey:@"ejo5ibkye3vo"
                                               secretKey:@"cC7B2jpxITqPLZ5M"
                                             redirectUrl:@"http://sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeTumblr:
                      [appInfo SSDKSetupTumblrByConsumerKey:@"2QUXqO9fcgGdtGG1FcvML6ZunIQzAEL8xY6hIaxdJnDti2DYwM"
                                             consumerSecret:@"3Rt0sPFj7u2g39mEVB3IBpOzKnM3JnTtxX2bao2JKk4VV1gtNo"
                                                callbackUrl:@"http://sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeFlickr:
                      [appInfo SSDKSetupFlickrByApiKey:@"33d833ee6b6fca49943363282dd313dd"
                                             apiSecret:@"3a2c5b42a8fbb8bb"];
                      break;
                  case SSDKPlatformTypeYouDaoNote:
                      [appInfo SSDKSetupYouDaoNoteByConsumerKey:@"dcde25dca105bcc36884ed4534dab940"
                                                 consumerSecret:@"d98217b4020e7f1874263795f44838fe"
                                                  oauthCallback:@"http://www.sharesdk.cn/"];
                      break;
                      
                      //印象笔记分为国内版和国际版，注意区分平台
                      //设置印象笔记（中国版）应用信息
                  case SSDKPlatformTypeYinXiang:
                      
                      //设置印象笔记（国际版）应用信息
                  case SSDKPlatformTypeEvernote:
                      [appInfo SSDKSetupEvernoteByConsumerKey:@"sharesdk-7807"
                                               consumerSecret:@"d05bf86993836004"
                                                      sandbox:YES];
                      break;
                  case SSDKPlatformTypeKakao:
                      [appInfo SSDKSetupKaKaoByAppKey:@"48d3f524e4a636b08d81b3ceb50f1003"
                                           restApiKey:@"ac360fa50b5002637590d24108e6cb10"
                                          redirectUri:@"http://www.mob.com/oauth"
                                             authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeAliPaySocial:
                      [appInfo SSDKSetupAliPaySocialByAppId:@"2015072400185895"];
                      break;
                  case SSDKPlatformTypePinterest:
                      [appInfo SSDKSetupPinterestByClientId:@"4799618093317899411"];
                      break;
                  case SSDKPlatformTypeDropbox:
                      [appInfo SSDKSetupDropboxByAppKey:@"i5vw2mex1zcgjcj"
                                              appSecret:@"3i9xifsgb4omr0s"
                                          oauthCallback:@"https://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeVKontakte:
                      [appInfo SSDKSetupVKontakteByApplicationId:@"5312801"
                                                       secretKey:@"ZHG2wGymmNUCRLG2r6CY"];
                      break;
                  case SSDKPlatformTypeMingDao:
                      [appInfo SSDKSetupMingDaoByAppKey:@"EEEE9578D1D431D3215D8C21BF5357E3"
                                              appSecret:@"5EDE59F37B3EFA8F65EEFB9976A4E933"
                                            redirectUri:@"http://sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeYiXin:
                      [appInfo SSDKSetupYiXinByAppId:@"yx0d9a9f9088ea44d78680f3274da1765f"
                                           appSecret:@"1a5bd421ae089c3"
                                         redirectUri:@"https://open.yixin.im/resource/oauth2_callback.html"
                                            authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeInstapaper:
                      [appInfo SSDKSetupInstapaperByConsumerKey:@"4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA"
                                                 consumerSecret:@"GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe"];
                      break;
                  default:
                      break;
              }
          }];

#endif
    // 友盟
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"57429ef6e0f55a7716000931"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxa581c35120b33dee" appSecret:@"3c3c36d673d61413823800a3dba8e68d" url:@"http://oa.meidp.com/"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105399638" appKey:@"L6HAVOvs6m90mbxu" url:@"http://oa.meidp.com/"];
    // 打开新浪微博的SSO开关
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"4284439021"
                                              secret:@"ab0427f1145330765ebba16bb78cebdc"
                                         RedirectURL:@"http://oa.meidp.com/"];
    //
    
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible]; 
    
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
    NSLog(@"%d |%d |%@| %@",URLREQUEST_SUCCEED,URLREQUEST_SUCCEED,url,options);
    return [UMSocialSnsService handleOpenURL:url];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"分享回调");
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
    // ＊＊＊＊＊星标1＊＊＊＊＊＊＊
    [JPUSHService setTags:[NSSet setWithObjects:@"test", nil] alias:nil callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    // ＊＊＊＊＊星标1＊＊＊＊＊＊＊
}

// ＊＊＊＊＊星标2＊＊＊＊＊＊＊
-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ntags: %@, \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\nalias: %@\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n", iResCode, tags , alias);
}
// ＊＊＊＊＊星标2＊＊＊＊＊＊＊
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
@end
