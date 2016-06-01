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
#import "KeyboardToolBar/KeyboardToolBar.h"
@interface ShopController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NextManger *manger;
    UIView *hearView;
    UITextField *seachTextField;
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
    self.tableView.tableHeaderView = [self hearView];
    [self.view addSubview:_tableView];
    [self registerNib];
}
- (UIView *)hearView{
    
    hearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    //    hearView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:hearView];
    seachTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 80, 30)];
    seachTextField.delegate = self;
    seachTextField.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    seachTextField.layer.borderWidth = 1.0; // set borderWidth as you want.
    seachTextField.layer.cornerRadius=8.0f;
    seachTextField.layer.masksToBounds=YES;
    [KeyboardToolBar registerKeyboardToolBar:seachTextField];
    [hearView addSubview:seachTextField];
    
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seachBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    seachBtn.frame = CGRectMake(SCREEN_WIDTH - 55, 5, 30, 30);
    [seachBtn addTarget:self action:@selector(seachAction) forControlEvents:UIControlEventTouchDown];
    [hearView addSubview:seachBtn];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(8, hearView.bounds.size.height - 1, ScreenWidth - 16, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [hearView addSubview:line];
    return hearView;
    
}
#pragma mark - 搜索
- (void)seachAction
{
    manger = [NextManger shareInstance];
    manger.keyword = seachTextField.text;
    [manger loadData:RequestOfGetproductlist];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getproductlist" object:nil];
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
    cell.shopBuy.text = [NSString stringWithFormat:@"￥: %@", model.shopListTotalBuy];
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
