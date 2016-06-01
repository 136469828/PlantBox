//
//  PlantBKController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "PlantBKController.h"
#import "PlantBKCell.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "UIImageView+WebCache.h"
#import "WebModel.h"
#import "WebViewController.h"
@interface PlantBKController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    NextManger *manger;
}
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation PlantBKController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%@ %@",_classID,_channelId);
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
    manger = [NextManger shareInstance];
    manger.channelID = self.channelId;
    manger.keyword = self.classID;
    [manger loadData:RequestOfGetarticlelist];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"Getarticlelist" object:nil];
}
- (void)reloadDatas
{
    [self.tableView reloadData];
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
    NSArray *registerNibs = @[@"PlantBKCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return manger.m_listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlantBKCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlantBKCell"];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    ProjectModel *model = manger.m_listArr[indexPath.row];
    cell.titleLab.text = model.title;
    cell.contentLab.text = model.summary;
    cell.tag = [model.projectIDofModel integerValue];
    cell.imgV.layer.cornerRadius = 5;
    cell.imgV.layer.masksToBounds = YES;
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.author]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlantBKCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    WebModel *model = [[WebModel alloc] initWithUrl:[NSString stringWithFormat:@"http://plantbox.meidp.com/Mobi/Home/NoticeDetail/%ld",cell.tag]];
    WebViewController *SVC = [[WebViewController alloc] init];
    SVC.title = @"植物百科";
    SVC.hidesBottomBarWhenPushed = YES;
    [SVC setModel:model];
    [self.navigationController pushViewController:SVC animated:YES];
}
@end
