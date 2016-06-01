//
//  AboutMeViewController.m
//  ManagementSystem
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "AboutMeViewController.h"
#import "JieshaoController.h"
#import "NextManger.h"
#import "FunctionViewController.h"
@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NextManger *manger = [NextManger shareInstance];
    [manger loadData:RequestOfGetlatestversoin];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(versionName:) name:@"VersionName" object:nil];
    
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
- (IBAction)introduceBtn:(id)sender {
    FunctionViewController *sub = [[FunctionViewController alloc] init];
    sub.title = @"功能介绍";
    [self.navigationController pushViewController:sub animated:YES];

}
- (IBAction)wellcomeBtn:(id)sender {
    JieshaoController *sub = [[JieshaoController alloc] init];
    [self.navigationController pushViewController:sub animated:YES];
}
- (void)versionName:(NSNotification*)theObj
{
    self.titleLab.text = [NSString stringWithFormat:@"植物盒子 %@ 版",theObj.object];

}
@end
