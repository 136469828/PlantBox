//
//  ShopController.m
//  PlantBox
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "ShopController.h"
#import "ShopCell.h"
#import "ShopInfoController.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "UIImageView+WebCache.h"
@interface ShopController ()<UITableViewDataSource,UITableViewDelegate>
{
    NextManger *manger;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"植物商城";
    
    manger = [NextManger shareInstance];
    [manger loadData:RequestOfGetproductlist];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getproductlist" object:nil];
    [self setTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadDatas
{
    NSLog(@"获取数据");
    [self.tableView reloadData];
}
#pragma mark -
- (void)setTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:_tableView];
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"ShopCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (manger.m_ProductShopLists.count == 0) {
        return 0;
    }
    else
    {
        return manger.m_ProductShopLists.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    ProjectModel *model = manger.m_ProductShopLists[indexPath.row];
    [cell.shopImg sd_setImageWithURL:[NSURL URLWithString:model.shopListImg]];
    cell.shopName.text = model.shopListName;
    cell.shopShow.text = model.shopListNotice;
    cell.shopBuy.text = [NSString stringWithFormat:@"%@ 人购买", model.shopListTotalBuy];
    cell.tag = [model.shopListID integerValue];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    ShopInfoController *subVC = [[ShopInfoController alloc] init];
    subVC.shopID = [NSString stringWithFormat:@"%ld",cell.tag];
    [self.navigationController pushViewController:subVC animated:YES];
}
@end
