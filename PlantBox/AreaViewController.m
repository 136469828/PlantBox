//
//  AreaViewController.m
//  LoginTest
//
//  Created by Admin on 15/9/16.
//  Copyright (c) 2015年 葱. All rights reserved.
//

#import "AreaViewController.h"
//#import "InfoViewController.h"
@interface AreaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *filePathArr;
    NSArray *countArr;
    NSMutableArray *titleArr;
    
    UITableView *_tableView;
    UITableViewCell *cell;
    NSString *_dataStr;
}
@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地区";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    [self filelala];
    [self _initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark 创建表视图
- (void)_initTableView{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"weatherCities" ofType:@"plist"];
    filePathArr = [NSArray arrayWithContentsOfFile:filePath];
    titleArr = [NSMutableArray arrayWithCapacity:5];
    for (NSDictionary *dic in filePathArr) {
        [titleArr addObjectsFromArray:[dic allKeys]];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-69) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma  mark Detlegate
// 返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return titleArr.count;
}
// 返回每个组的头标题（名字）
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return titleArr[section];
}
// 每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = [filePathArr objectAtIndex:section];
    countArr = [[dic allValues] objectAtIndex:0];
    return countArr.count;
}

// 每一行里面的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    NSDictionary *dicArr = filePathArr[indexPath.section];
    NSString *cityKey = titleArr[indexPath.section];
    NSArray *dataArr = [dicArr objectForKey:cityKey];
    cell.textLabel.text = [dataArr objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark 设置点击事件
// 点中某行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicArr = filePathArr[indexPath.section];
    NSArray *cityKey = titleArr[indexPath.section];
    NSArray *dataArr = [dicArr objectForKey:cityKey];
    //    cell.textLabel.text = [dataArr objectAtIndex:indexPath.row];
    NSLog(@"点中了我 %@",[dataArr objectAtIndex:indexPath.row]);
    _dataStr = [dataArr objectAtIndex:indexPath.row];
    [self pushMainView];
}
#pragma maek 存数据
- (void)saveUserDefault{
    //
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = _dataStr;
    NSLog(@"%@",name);
    [userDefault setObject:name forKey:@"city"];
    [userDefault synchronize];
}
#pragma mark 跳转
- (void)pushMainView{
    [self saveUserDefault];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)filelala{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",filePath);
}
@end
