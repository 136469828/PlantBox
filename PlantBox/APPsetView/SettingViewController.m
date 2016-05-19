//
//  SettingViewController.m
//  ManagementSystem
//
//  Created by JCong on 16/3/12.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "SettingViewController.h"
#import "MMZCViewController.h"
#import "AboutMeViewController.h"
#import "PasswordViewController.h"
#import "PrivacyViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titles;
}
@property UITableView *normalTableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    titles = @[@"修改密码",@"通知",@"关于我们",@"隐私",@"升级为最高版本"];
    self.view.backgroundColor = RGB(239, 239, 244);
    [self setTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -tableView
- (void)setTableView{
    _normalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-79) style:UITableViewStyleGrouped];
    _normalTableView.delegate = self;
    _normalTableView.dataSource = self;
    [self.view addSubview:_normalTableView];
    
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section // 返回组的头宽
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section // 返回组的尾宽
{
    return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
            return titles.count;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = titles[indexPath.row];
    }
    else
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        lab.text = @"退出当前账号";
        lab.textColor = [UIColor orangeColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:lab];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                PasswordViewController *pwVC = [[PasswordViewController alloc] init];
                pwVC.title = @"修改密码";
                [self.navigationController pushViewController:pwVC animated:YES];
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                AboutMeViewController *abVC = [[AboutMeViewController alloc] init];
                abVC.title = @"关于我们";
                [self.navigationController pushViewController:abVC animated:YES];
            }
                break;
            case 3:
            {
                PrivacyViewController *abVC = [[PrivacyViewController alloc] init];
                abVC.title = @"隐私";
                [self.navigationController pushViewController:abVC animated:YES];
            }
                break;
                
            default:
                break;
        }

    }
    else
    {
        MMZCViewController *loginVC = [[MMZCViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
   }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
