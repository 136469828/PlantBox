//
//  PublishInfoController.m
//  PlantBox
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "ConditionsController.h"
#import "workCell.h"
#import "KeyboardToolBar.h"
@interface ConditionsController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger count;
}
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation ConditionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
    count = 1;
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
    //    self.tableView.estimatedRowHeight = 75;
    self.tableView.tableFooterView = [self setFootView];
    [self.view addSubview:_tableView];
    [self registerNib];
}
- (UIView *)setFootView
{
    UIView *fV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(10, 5, ScreenWidth-20, 30);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addDay) forControlEvents:UIControlEventTouchDown];
    [fV addSubview:addBtn];
    return fV;
}
- (void)addDay
{
    count++;
    [self.tableView reloadData];
    
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"workCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    workCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workCell"];
    //    cell.textView.delegate = self;
    //    cell.textView.tag = 2000;
    //    cell.textView.text = @"请输入发布内容";
    //    cell.textView.textColor = RGB(142, 142, 142);
    cell.titleTF.placeholder = @"请输入生长条件";
    cell.workloadTF.placeholder = @"请输入数量";
    [KeyboardToolBar registerKeyboardToolBar:cell.titleTF];
    [KeyboardToolBar registerKeyboardToolBar:cell.workloadTF];
    return cell;
}



@end
