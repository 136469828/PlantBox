//
//  RootTabbarController.m
//  ManagementSystem
//
//  Created by JCong on 16/2/27.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "RootTabbarController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "NearViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
@interface RootTabbarController ()

@end

@implementation RootTabbarController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self setTabBarController];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
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
#pragma mark TabBarView
- (void)setTabBarController{    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setUpOneChildViewController:homeVC Homepage:[UIImage imageNamed:@"009"] Selected:[UIImage imageNamed:@""] title:@"首页"];
    //    homeVC.hidesBottomBarWhenPushed = YES;
    NearViewController *classifyVC = [[NearViewController alloc] init];
    [self setUpOneChildViewController:classifyVC Homepage:[UIImage imageNamed:@"010"] Selected:[UIImage imageNamed:@""] title:@"附近"];
    
    MessageViewController *stopCarVC = [[MessageViewController alloc] init];
    [self setUpOneChildViewController:stopCarVC Homepage:[UIImage imageNamed:@"011"] Selected:[UIImage imageNamed:@""] title:@"消息"];
    
    MineViewController *infoVC = [[MineViewController alloc] init];
    [self setUpOneChildViewController:infoVC Homepage:[UIImage imageNamed:@"012"] Selected:[UIImage imageNamed:@""] title:@"我的"];
    
}

#pragma mark 快速创建TabBarView模板
- (void)setUpOneChildViewController:(UIViewController *)viewController Homepage:(UIImage *)homepage Selected:(UIImage *)selectedImage title:(NSString *)title{

    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];

    navC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:homepage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[UINavigationBar appearance] setTintColor:RGB(7, 124, 245)];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];    //设置tabbar的背景图片
        [navC.navigationBar setTranslucent:NO];  // 不透明
    [self addChildViewController:navC];
}

@end
