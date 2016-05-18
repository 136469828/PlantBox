//
//  ConditionsController.m
//  PlantBox
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "WorkForDayController.h"
#import "workCell.h"
#import "KeyboardToolBar.h"
@interface WorkForDayController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    NSInteger count;
}
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) UIView *closeV;


@end

@implementation WorkForDayController

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
    [KeyboardToolBar registerKeyboardToolBar:cell.titleTF];
    [KeyboardToolBar registerKeyboardToolBar:cell.workloadTF];
    return cell;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //  667 - 313
    _closeV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-49-258, ScreenWidth, 40)];
    _closeV.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *colseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colseBtn.frame = CGRectMake(ScreenWidth-45, 5, 40, 25);
    [colseBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [colseBtn addTarget:self action:@selector(leaveEditMode) forControlEvents:UIControlEventTouchDown];
    [_closeV addSubview:colseBtn];
    [self.view addSubview:_closeV];
    
    [UITableView animateWithDuration:0.25 animations:^{
        _tableView.frame = CGRectMake(0, -30, ScreenWidth, ScreenHeight);
    }];
    textView.text=@"";
    textView.textColor = [UIColor blackColor];
    return YES;
    
}
- (void)leaveEditMode {
    [UITableView animateWithDuration:0.25 animations:^{
        _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-69);
        [_closeV removeFromSuperview];
        _closeV = nil;
    }];
    UITableView *texrV = (UITableView *)[self.view viewWithTag:2000];
    [texrV resignFirstResponder];
    
}

@end
