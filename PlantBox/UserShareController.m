//
//  UserShareController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "UserShareController.h"

@interface UserShareController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation UserShareController

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
    return 10;
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
    cell.textLabel.text = @"马云的分享";
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-80, 0,45, 44)];
    lab.text = @"10:02";
    lab.textAlignment = NSTextAlignmentRight;
    lab.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview: lab];
    
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.35, 0,ScreenWidth-ScreenWidth*0.35-80, 44)];
    contentLab.text = @"多肉植物养成日记";
    contentLab.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview: contentLab];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
//        ErweimaViewController *eVC = [[ErweimaViewController alloc] init];
//        eVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:eVC animated:eVC];
    }
}
@end
