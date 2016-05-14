//
//  PublishedController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "PublishedController.h"
#import "PublishedCell.h"
#import "KeyboardToolBar.h"
@interface PublishedController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) UIView *closeV;

@end

@implementation PublishedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
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
    [self.view addSubview:_tableView];
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"PublishedCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishedCell"];
    cell.textView.delegate = self;
    cell.textView.tag = 2000;
    cell.textView.text = @"请输入发布内容";
    cell.textView.textColor = RGB(142, 142, 142);
    [KeyboardToolBar registerKeyboardToolBar:cell.titleTextFild];
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
