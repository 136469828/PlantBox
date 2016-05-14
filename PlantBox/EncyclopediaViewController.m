//
//  EncyclopediaViewController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "EncyclopediaViewController.h"
#import "CultivateController.h"
#import "PlantBKController.h"
#import "PublishedController.h"
#import "WebModel.h"
#import "WebViewController.h"
@interface EncyclopediaViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    NSArray *imgs;
}
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation EncyclopediaViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    imgs = @[@"baike_bk",@"fabu_bk",@"jiaogcheng_bk"];
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
    NSArray *titles = @[@"植物百科",@"培育教程",@"我要发布教程"];
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
        CultivateController *subVC = [[CultivateController alloc] init];
        subVC.title = @"培育教程";
        [self.navigationController pushViewController:subVC animated:YES];
    }
    else if (indexPath.row == 0)
    {
//        PlantBKController *subVC = [[PlantBKController alloc] init];
//        subVC.title = @"植物百科";
//        [self.navigationController pushViewController:subVC animated:YES];
        WebModel *model = [[WebModel alloc] initWithUrl:@"http://plantbox.meidp.com/Mobi/Home/NoticeList?ChannelId=1001"];
        WebViewController *SVC = [[WebViewController alloc] init];
        SVC.title = @"植物百科";
        SVC.hidesBottomBarWhenPushed = YES;
        [SVC setModel:model];
        [self.navigationController pushViewController:SVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        PublishedController *subVC = [[PublishedController alloc] init];
        subVC.title = @"我要发布教程";
        [self.navigationController pushViewController:subVC animated:YES];
    }
}
@end
