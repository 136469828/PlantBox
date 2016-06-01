//
//  PublishedListController.m
//  PlantBox
//
//  Created by admin on 16/5/23.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "PublishedListController.h"
#import "PublishedController.h"
#import "MyBaseOrPlantListController.h"
#import "PlantBKCell.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "UIImageView+WebCache.h"
@interface PublishedListController ()<UITableViewDataSource,UITableViewDelegate>
{
    NextManger *manger;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation PublishedListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-59)style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self registerNib];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
    // 添加导航右按钮
    UIBarButtonItem *rightBtuForBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPulished)];
    self.navigationItem.rightBarButtonItem = rightBtuForBar;
    
    manger = [NextManger shareInstance];
    [manger loadData:RequestOfgetusercoursepagelistmine];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getusercoursepagelistmine" object:nil];
}
- (void)reloadDatas
{
    [self.tableView reloadData];
}
//#pragma mark - 注册Cell
//- (void)registerNib{
//    NSArray *registerNibs = @[@"PlantBKCell"];
//    for (int i = 0 ; i < registerNibs.count; i++) {
//        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
//    }
//    
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return manger.m_jcListsmine.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *allCell = @"cell";
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCell];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    
//    PlantBKCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlantBKCell"];
    ProjectModel *model = manger.m_jcListsmine[indexPath.row];
//    cell.selectionStyle = UITableViewCellAccessoryNone;
//    cell.titleLab.text = model.headTitle;
//    cell.contentLab.text = model.goodsCom;
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(18, 5, 60-16, 60-16)];
    imgv.layer.cornerRadius = 5;
    [cell.contentView addSubview:imgv];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(18+60-16+5, 5, ScreenWidth-18+60-16+5, 25)];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.text = model.headTitle;
    [cell.contentView addSubview:titleLab];
    
    UILabel *subtitleLab = [[UILabel alloc] initWithFrame:CGRectMake(18+60-16+5, 30, ScreenWidth-18+60-16+5, 25)];
    subtitleLab.font = [UIFont systemFontOfSize:13];
    subtitleLab.text = model.goodsCom;
    [cell.contentView addSubview:subtitleLab];

    if ([model.goodImg isEqualToString:@"1"])
    {
        imgv.image = [UIImage imageNamed:@"1138bb6d96b8709ba6028a89c95006bc.jpg"];
    }
    else
    {
        [imgv sd_setImageWithURL:[NSURL URLWithString:model.goodImg]];
    }

    cell.tag = [model.goodsID integerValue];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlantBKCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PublishedController *subVC = [[PublishedController alloc] init];
    subVC.goodsID = [NSString stringWithFormat:@"%ld",cell.tag];
    subVC.sType = @"2";
    subVC.title = @"详情";
    [self.navigationController pushViewController:subVC animated:YES];
}
- (void)addPulished
{
    PublishedController *subVC = [[PublishedController alloc] init];
//    subVC.title = @"我要发布教程";
    subVC.sType = @"2";
    subVC.goodsID = @"0";
    [self.navigationController pushViewController:subVC animated:YES];
//    MyBaseOrPlantListController *subVC = [[MyBaseOrPlantListController alloc] init];
//    subVC.title = @"请选择需要发布的教程的植物";
//    [self.navigationController pushViewController:subVC animated:YES];
}

@end
