//
//  HJLeftViewController.m
//  分页控制器
//
//  Created by 韩佳 on 16/3/19.
//  Copyright © 2016年 DDG. All rights reserved.
//

#import "HJLeftViewController.h"

@interface HJLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *cellTitles;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HJLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    cellTitles = @[@"植物百科",@"培育教程"];
    [self setTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)setTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -35, ScreenWidth, ScreenHeight - 34) style:UITableViewStyleGrouped];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellInfer = @"cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInfer];
    }
    if (indexPath.section == 0)
    {
        cell.textLabel.text = cellTitles[indexPath.row];
    }
    if (indexPath.section == 1)
    {
        cell.textLabel.text = @"我要发布培育教程";
    }
    
    return cell;
}

@end
