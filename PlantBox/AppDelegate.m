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
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    MMZCViewController *login=[[MMZCViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:login];
    self.window.rootViewController=nav;
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [nav.navigationBar setTitleTextAttributes:attributes];
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

    
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible]; 
    
    return YES;
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
@end
