//
//  GuideController.m
//  PlantBox
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "GuideController.h"

@interface GuideController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;


@end

@implementation GuideController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
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
    return 2;
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
    NSArray *titles = @[@"生长条件",@"当日工作"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",titles[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
//        TheOfficialTutorialController *subVC = [[TheOfficialTutorialController alloc] init];
//        subVC.title = @"官方教程";
//        [self.navigationController pushViewController:subVC animated:YES];
    }
    else if (indexPath.row == 1)
    {
//        UserShareController *subVC = [[UserShareController alloc] init];
//        subVC.title = @"用户分享";
//        [self.navigationController pushViewController:subVC animated:YES];
    }
}
@end
