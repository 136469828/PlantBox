//
//  OperationController.m
//  PlantBox
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "OperationController.h"
#import "OperationCell.h"
#import "ASValueTrackingSlider.h"
@interface OperationController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic ,strong) UITableView *tableView;


@end

@implementation OperationController

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
    NSArray *registerNibs = @[@"OperationCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 80;
    }
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *infierCell = @"cell";
        UITableViewCell *cell = nil;
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell];
        }
        cell.textLabel.text = @"控制灯光";
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        return cell;
    }
//    if (indexPath.row == 3) {
//        static NSString *infierCell2 = @"cell2";
//        UITableViewCell *cell = nil;
//        if (!cell)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell2];
//        }
//        cell.textLabel.text = @"拍照";
//        cell.textLabel.font = [UIFont systemFontOfSize:13];
//        return cell;
//    }
    OperationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OperationCell"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    [cell.slider setNumberFormatter:formatter];
    cell.slider.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:13];
    cell.slider.popUpViewAnimatedColors = @[[UIColor purpleColor], [UIColor redColor], [UIColor orangeColor]];
    return cell;
}

@end
