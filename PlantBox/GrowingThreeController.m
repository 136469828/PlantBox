//
//  GrowingThreeController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "GrowingThreeController.h"
#import "SubGrowingTreeViewController.h"
#import "OfflineController.h"
#import "BillController.h"
@interface GrowingThreeController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    NSArray *imgs;
}
@property (nonatomic ,strong) UITableView *tableView;
@end

@implementation GrowingThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    imgs = @[@"cz_czs",@"fenxiang_czs",@"shouru_cz",@"xiaxian_cz"];
//        imgs = @[@"kouling_czs"];
    [self setTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)setTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imgs.count;
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
    NSArray *titles = @[@"分享赢植币",@"口令赢植币",@"我的下线",@"我的收入"];
//        NSArray *titles = @[@"我的成长"];
//    NSArray *subTitles = @[@[@"我的二维码"],@[@"输入口令"],@[@"查看分销网络",@"下线列表",@"收入统计"]];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 0,100, 44)];
    lab.text = [NSString stringWithFormat:@"%@",titles[indexPath.row]];
    //        lab.backgroundColor = [UIColor redColor];
    lab.font = [UIFont systemFontOfSize:15];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 15, 15)];
    imgv.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgs[indexPath.row]]];
    [cell.contentView addSubview:imgv];
    [cell.contentView addSubview: lab];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
//        SubGrowingTreeViewController *subVC = [[SubGrowingTreeViewController alloc] init];
//        subVC.title = @"我的成长";
//        [self.navigationController pushViewController:subVC animated:YES];
    }
    else if (indexPath.row == 2) {
        OfflineController *subVC = [[OfflineController alloc] init];
        [self.navigationController pushViewController:subVC animated:YES];
    }
    else if (indexPath.row == 3) {
        BillController *subVC = [[BillController alloc] init];
        subVC.title = @"我的收入";
        [self.navigationController pushViewController:subVC animated:YES];
    }
}
@end
