//
//  UserShareController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "UserShareController.h"
#import "PlantBKCell.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "UIImageView+WebCache.h"
#import "UserShareInfoController.h"
@interface UserShareController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    NextManger *manger;
}
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation UserShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
//    [self registerNib];
    manger = [NextManger shareInstance];
    [manger loadData:RequestOfgetusercoursepagelist];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getusercoursepagelist" object:nil];
    
}
- (void)reloadDatas
{
    [self.tableView reloadData];
}
//#pragma mark - 注册Cell
//- (void)registerNib{
//    NSArray *registerNibs = @[@"PlantBKCell"];
//    for (int i = 0 ; i < registerNibs.count; i++) {
//        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
//    }
//    
//}
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
    [self.view addSubview:_tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return manger.m_jcLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *allCell = @"cell";
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCell];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    
    //    PlantBKCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlantBKCell"];
    ProjectModel *model = manger.m_jcLists[indexPath.row];
    //    cell.selectionStyle = UITableViewCellAccessoryNone;
    //    cell.titleLab.text = model.headTitle;
    //    cell.contentLab.text = model.goodsCom;
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(18, 5, 60-16, 60-16)];
    imgv.layer.cornerRadius = 5;
    [cell.contentView addSubview:imgv];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(18+60-16+16, 5, ScreenWidth-18+60-16+5, 25)];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.text = model.headTitle;
    [cell.contentView addSubview:titleLab];
    
    UILabel *subtitleLab = [[UILabel alloc] initWithFrame:CGRectMake(18+60-16+16, 30, ScreenWidth-18+60-16+5, 25)];
    subtitleLab.font = [UIFont systemFontOfSize:13];
    subtitleLab.text = model.goodsCom;
    [cell.contentView addSubview:subtitleLab];
    
    if ([model.goodImg isEqualToString:@"1"])
    {
        imgv.image = [UIImage imageNamed:@"1138bb6d96b8709ba6028a89c95006bc.jpg"];
    }
    else
    {
        [imgv sd_setImageWithURL:[NSURL URLWithString:model.goodImg]];
    }
    
    cell.tag = [model.goodsID integerValue];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlantBKCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UserShareInfoController *subVC = [[UserShareInfoController alloc] init];
    subVC.goodsID = [NSString stringWithFormat:@"%ld",cell.tag];
    subVC.sType = @"2";
    subVC.title = @"详情";
    [self.navigationController pushViewController:subVC animated:YES];
}
@end
