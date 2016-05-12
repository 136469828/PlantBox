//
//  HJPageViewController.h
//  分页控制器
//
//  Created by 韩佳 on 16/3/19.
//  Copyright © 2016年 DDG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJPageViewController : UIViewController

@property (nonatomic, copy) NSString *leftMenuTitle;
@property (nonatomic, copy) NSString *middleMuneTitle;
@property (nonatomic, copy) NSString *rightMuneTitle;

@property (nonatomic, strong) UIViewController *leftController;
@property (nonatomic, strong) UIViewController *middleController;
@property (nonatomic, strong) UIViewController *rightController;

@end
