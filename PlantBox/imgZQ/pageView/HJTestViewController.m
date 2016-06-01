//
//  HJTestViewController.m
//  分页控制器
//
//  Created by 韩佳 on 16/3/19.
//  Copyright © 2016年 DDG. All rights reserved.
//

#import "HJTestViewController.h"
#import "HJLeftViewController.h"
#import "HJMiddleViewController.h"
#import "HJRightViewController.h"


@interface HJTestViewController ()

@end

@implementation HJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"种植中心";
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.leftController = [[HJLeftViewController alloc] init];
    self.leftMenuTitle = @"植物百科";
    
    self.middleController = [[HJMiddleViewController alloc] init];
    self.middleMuneTitle = @"植物监控";
    
    self.rightController = [[HJRightViewController alloc] init];
    self.rightMuneTitle = @"硬件对接";
}



@end
