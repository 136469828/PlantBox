//
//  MyOrderController.m
//  PlantBox
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "MyOrderController.h"
#import "MyOrderListCellCell.h"
#import "UIImageView+WebCache.h"
#import "NextManger.h"
#import "ProjectModel.h"
@interface MyOrderController ()<UITableViewDataSource,UITableViewDelegate>
{
    NextManger *manger;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    manger = [NextManger shareInstance];
    [manger loadData:RequestOfgetorderlist];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getorderlist" object:nil];
    [self drawTableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.


}

- (void)drawTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-69) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 120;
    [self.view addSubview:self.tableView];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self registerNib];
}

- (void)reloadDatas
{
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"MyOrderListCellCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return manger.m_MyorderLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectModel *model = manger.m_MyorderLists[indexPath.row];
    MyOrderListCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderListCellCell"];
    cell.timeLab.text       = [NSString stringWithFormat:@"下单时间: %@",model.myOrderTime];
    cell.orderAddress.text  = [NSString stringWithFormat:@"收货地址: %@",model.myOrderAddress];
    cell.orderName.text     = [NSString stringWithFormat:@"收  货  人: %@",model.myOrderName];
    cell.orderNoLab.text    = [NSString stringWithFormat:@"订单编号: %@",model.myOrderNo];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}
@end
