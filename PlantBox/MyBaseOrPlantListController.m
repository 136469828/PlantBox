//
//  MyBaseOrPlantListController.m
//  PlantBox
//
//  Created by admin on 16/5/25.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "MyBaseOrPlantListController.h"
#import "PublishedController.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "UIImageView+WebCache.h"
@interface MyBaseOrPlantListController ()<UITableViewDataSource,UITableViewDelegate>
{
    NextManger *manger;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyBaseOrPlantListController

// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-59)style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];

    
    manger = [NextManger shareInstance];
    [manger loadData:RequestOfgetusergoodpagelistmine];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"getusergoodpagelistmine" object:nil];
}
- (void)reloadDataAction
{
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return manger.m_goodPageLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *allCell = @"cell";
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCell];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    ProjectModel *model = manger.m_goodPageLists[indexPath.row];
    //    cell.textLabel.text = model.goodpageName;
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 60-16, 60-16)];
    [imgv sd_setImageWithURL:[NSURL URLWithString:model.goodpagImg]];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(60-5, 8, ScreenWidth-60-16, 60-16)];
    lab.text = model.goodpageName;
    lab.font = [UIFont systemFontOfSize:15];
    
    [cell.contentView addSubview:lab];
    [cell.contentView addSubview:imgv];
    
    cell.tag = [model.goodpagID integerValue];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PublishedController *sub = [[PublishedController alloc] init];
    sub.title = @"发布成果";
    sub.sType = @"1";
    sub.newgoodsID = [NSString stringWithFormat:@"%ld",cell.tag];
    [self.navigationController pushViewController:sub animated:YES];
}

@end
