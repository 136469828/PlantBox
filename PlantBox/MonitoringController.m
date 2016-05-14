//
//  MonitoringController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "MonitoringController.h"
#import "GuideController.h"
#import "GrowingEnvironmentController.h"
@interface MonitoringController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    NSArray *imgs;
}
@property (nonatomic ,strong) UITableView *tableView;


@end

@implementation MonitoringController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    imgs = @[@"huanjing_jk",@"yindao_jk",@"zhuangtai_jk"];
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
    NSArray *titles = @[@"生长状态",@"生长环境",@"种植引导"];
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
    if (indexPath.row == 1)
    {
        GrowingEnvironmentController *subVC = [[GrowingEnvironmentController alloc] init];
        subVC.title = @"生长环境";
        [self.navigationController pushViewController:subVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        GuideController *subVC = [[GuideController alloc] init];
        subVC.title = @"种植引导";
        [self.navigationController pushViewController:subVC animated:YES];
    }
}
@end
