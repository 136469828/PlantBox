//
//  PlantCenterController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "PlantCenterController.h"
#import "EncyclopediaViewController.h"
#import "MonitoringController.h"
#import "HardwareController.h"
#import "WebModel.h"
#import "WebViewController.h"
#import "TheOfficialTutorialListController.h"
#import "UserShareController.h"
#import "PublishedListController.h"
#import "GrowingEnvironmentController.h"
#import "ErweimaViewController.h"
#import "OperationController.h"
#import "WorkForDayController.h"
#import "ConditionsController.h"
#import "PlantBKController.h"

@interface PlantCenterController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    NSArray *imgs;
}
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation PlantCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"种植中心";
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
//    imgs = @[@[@"baike_bk",@"jiaogcheng_bk",@"023",@"fabu_bk"],@[@"zhuangtai_jk",@"huanjing_jk",@"yindao_jk",@"024"],@[@"saomiao_yj",@"caozuo_yj"]];
       imgs = @[@[@"baike_bk",@"jiaogcheng_bk",@"023",@"fabu_bk"],@[@"saomiao_yj",@"caozuo_yj"]];

    [self setTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)setTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView // 一个表视图里面有多少组
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 2) {
//        return 2;
//    }
    if (section == 1) {
        return 2;
    }
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section // 返回组的头宽
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section // 返回组的尾宽
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *infierCell = @"cell";
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *titles = @[@[@"植物百科",@"官方教程",@"参考用户教程",@"我要发布教程"],@[@"扫描设备",@"操作系统"]];
//    NSArray *titles = @[@[@"植物百科",@"官方教程",@"参考用户教程",@"我要发布教程"],@[@"生长状态",@"生长环境",@"生长条件",@"当日工作"],@[@"扫描设备",@"操作系统"]];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 0,100, 44)];
    lab.text = [NSString stringWithFormat:@"%@",titles[indexPath.section][indexPath.row]];
    //        lab.backgroundColor = [UIColor redColor];
    lab.font = [UIFont systemFontOfSize:15];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 15, 15)];
    imgv.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgs[indexPath.section][indexPath.row]]];
    [cell.contentView addSubview:imgv];
    [cell.contentView addSubview: lab];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // @"植物百科",@"官方教程",@"用户分享",@"我要发布教程"
        switch (indexPath.row) {
            case 0:
            {
//                WebModel *model = [[WebModel alloc] initWithUrl:@"http://plantbox.meidp.com/Mobi/Home/NoticeList?ChannelId=1001"];
                PlantBKController *SVC = [[PlantBKController alloc] init];
                SVC.title = @"植物百科";
                SVC.channelId = @"1001";
                SVC.hidesBottomBarWhenPushed = YES;
//                [SVC setModel:model];
                [self.navigationController pushViewController:SVC animated:YES];
            }
                break;
            case 1:
            {
//                TheOfficialTutorialListController *subVC = [[TheOfficialTutorialListController alloc] init];
//                subVC.title = @"官方教程";
//                [self.navigationController pushViewController:subVC animated:YES];
                PlantBKController *SVC = [[PlantBKController alloc] init];
                SVC.title = @"官方教程";
                SVC.channelId = @"1002";
                SVC.hidesBottomBarWhenPushed = YES;
                //                [SVC setModel:model];
                [self.navigationController pushViewController:SVC animated:YES];
            }
                break;
            case 2:
            {
                UserShareController *subVC = [[UserShareController alloc] init];
                subVC.title = @"用户教程";
                [self.navigationController pushViewController:subVC animated:YES];

            }
                break;
            case 3:
            {
                PublishedListController *subVC = [[PublishedListController alloc] init];
                subVC.title = @"我要发布教程";
                [self.navigationController pushViewController:subVC animated:YES];

            }
                break;
                
            default:
                break;
        }
    }
//    else if (indexPath.section == 1)
//    {
//        // @"生长状态",@"生长环境",@"生长条件",@"当日工作"
//        switch (indexPath.row) {
//            case 0:
//            {
//                UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此功能开发中" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [al show];
//            }
//                break;
//            case 1:
//            {
//                GrowingEnvironmentController *subVC = [[GrowingEnvironmentController alloc] init];
//                subVC.title = @"生长环境";
//                [self.navigationController pushViewController:subVC animated:YES];
//
//            }
//                break;
//            case 2:
//            {
//                ConditionsController  *subVC = [[ConditionsController alloc] init];
//                subVC.title = @"生长条件";
//                [self.navigationController pushViewController:subVC animated:YES];
//            }
//                break;
//            case 3:
//            {
//                WorkForDayController *subVC = [[WorkForDayController alloc] init];
//                subVC.title = @"当日工作";
//                [self.navigationController pushViewController:subVC animated:YES];
//
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
    else
    {
        // @"扫描设备",@"操作系统"
        switch (indexPath.row) {
            case 0:
            {
                ErweimaViewController *eVC = [[ErweimaViewController alloc] init];
                eVC.hidesBottomBarWhenPushed = YES;
                eVC.title = @"扫描设备";
                [self.navigationController pushViewController:eVC animated:eVC];
            }
                break;
            case 1:
            {
                OperationController *eVC = [[OperationController alloc] init];
                eVC.hidesBottomBarWhenPushed = YES;
                eVC.title = @"操作设备";
                [self.navigationController pushViewController:eVC animated:eVC];
            }
                break;
                
            default:
                break;
        }
    }

}
@end
