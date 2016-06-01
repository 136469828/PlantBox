//
//  CollectController.m
//  PlantBox
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "CollectController.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "ShopInfoController.h"
#import "MyCollectCell.h"
#import "UIImageView+WebCache.h"
@interface CollectController ()<UITableViewDataSource,UITableViewDelegate>
{
    NextManger *manger;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawtableView];
    manger = [NextManger shareInstance];
    [manger loadData:RequestOfuserCollectList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"getcollectlist" object:nil];
}
- (void)refreshData
{
    [self.tableView reloadData];
}
- (void)drawtableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, ScreenWidth, ScreenHeight-69-5) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
    
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"MyCollectCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (manger.m_collectLists.count == 0) {
        return 0;
    }
    else
    {
      return manger.m_collectLists.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *infierCell = @"cell";
//    UITableViewCell *cell = nil;
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:infierCell];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    MyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectCell"];
    ProjectModel *model = manger.m_collectLists[indexPath.row];
    cell.titleLab.text = model.colletName;
    cell.timeLab.text = model.collectTime;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.collcetImg]];
    cell.tag = [model.collectID integerValue];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ShopInfoController *subVC = [[ShopInfoController alloc] init];
    subVC.shopID = [NSString stringWithFormat:@"%ld",cell.tag];
    [self.navigationController pushViewController:subVC animated:YES];
}

@end
