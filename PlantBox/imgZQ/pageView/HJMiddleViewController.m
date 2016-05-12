//
//  HJMiddleViewController.m
//  分页控制器
//
//  Created by 韩佳 on 16/3/19.
//  Copyright © 2016年 DDG. All rights reserved.
//

#import "HJMiddleViewController.h"

@interface HJMiddleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *cellTitles;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HJMiddleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    cellTitles = @[@"生长对比",@"生长环境",@"硬件对接"];
    [self setTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)setTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_tableView];
    
    //    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    //    gestureRecognizer.cancelsTouchesInView = NO;
    //
    //    [_tableView addGestureRecognizer:gestureRecognizer];
    //
    //    self.tableView.estimatedRowHeight = 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellInfer = @"cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInfer];
    }
    cell.textLabel.text = cellTitles[indexPath.row];
    return cell;
}

@end