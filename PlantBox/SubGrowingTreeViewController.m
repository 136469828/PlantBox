//
//  SubGrowingTreeViewController.m
//  PlantBox
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "SubGrowingTreeViewController.h"
#import "OfflineController.h"
#import "BillController.h"
@interface SubGrowingTreeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    NSArray *titles;
    NSArray *imgs;
}
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation SubGrowingTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    titles = @[@"我的下线",@"我的收入"];
    imgs = @[@"shouru_cz",@"xiaxian_cz"];
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
    return titles.count;
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
    if (indexPath.row == 0) {
        OfflineController *subVC = [[OfflineController alloc] init];
        [self.navigationController pushViewController:subVC animated:YES];
    }
    else if (indexPath.row == 1) {
        BillController *subVC = [[BillController alloc] init];
        subVC.title = @"我的收入";
        [self.navigationController pushViewController:subVC animated:YES];
    }
    
}
@end
