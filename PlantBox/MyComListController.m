//
//  MyComListController.m
//  PlantBox
//
//  Created by admin on 16/5/20.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "MyComListController.h"
#import "HomeBaseComCell.h"
#import "UIImageView+WebCache.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "UIImageView+WebCache.h"
@interface MyComListController ()<UITableViewDataSource,UITableViewDelegate>
{
    NextManger *manger;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MyComListController
// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    manger = [NextManger shareInstance];
    [manger loadData:RequestOfuserGetcommentlist];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getcommentlist" object:nil];
    [self drawTableview];
}
- (void)reloadDatas
{
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)drawTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-69) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.estimatedRowHeight = 200;
    [self.view addSubview:self.tableView];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"HomeBaseComCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return manger.m_comLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectModel *model = manger.m_comLists[indexPath.row];
    HomeBaseComCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBaseComCell"];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:manger.userPhoto]];

    cell.timeLab.text = model.comTime;
    cell.titleLab.text = model.comment;
    return cell;
}

@end
