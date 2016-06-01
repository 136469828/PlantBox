//
//  HomeBaseController.m
//  PlantBox
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "HomeBaseController.h"
#import "HomeBaseCell.h"
#import "HomeBaseComCell.h"
#import "UIImageView+WebCache.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "KeyboardToolBar/KeyboardToolBar.h"
#import "AQCollectionVC.h"
@interface HomeBaseController ()<UITableViewDataSource,UITableViewDelegate>
{
    NextManger *manger;
    UIView *pinglunView;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HomeBaseController
// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基地信息";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    manger = [NextManger shareInstance];
    manger.keyword = self.userID;
    [manger loadData:RequestOfgetusergoodsrecordpagelistUserID];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getusergoodsrecordpagelist" object:nil];
    [self drawTableview];
    
//    pinglunView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-30, ScreenWidth, 30)];
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(18, 2, ScreenWidth-40, 26)];
//    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    textField.layer.borderWidth = 1;
//    textField.layer.cornerRadius = 5;
//    textField.font = [UIFont systemFontOfSize:12];
//    textField.placeholder = @"请输入评论";
//    [KeyboardToolBar registerKeyboardToolBar:textField];
//    [pinglunView addSubview:textField];
//    [self.view addSubview:pinglunView];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedDidShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedDidappear:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark - 键盘
- (void)keyboaedDidShow:(NSNotification *)notif{
    //        NSLog(@"键盘出现 %@",notif);
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
//    NSLog(@"%d",height);
    
    pinglunView.frame = CGRectMake(0, height-30, ScreenWidth, 30);
    
}
- (void)keyboaedDidappear:(NSNotification *)notif{
    NSLog(@"键盘消失");
    pinglunView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-30, ScreenWidth, 30)];
}
- (void)reloadDatas
{
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)drawTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-69-30) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 230;
    [self.view addSubview:self.tableView];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"HomeBaseCell",@"HomeBaseComCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (manger.m_baseLists.count == 0)
    {
        return 0;
    }
    {
        return manger.m_baseLists.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        HomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBaseCell"];
        ProjectModel *model = manger.m_baseLists[indexPath.row];
        cell.nameLab.text = model.baseName;
        cell.conetLab.text = model.baseCom;
        cell.subConlab.text = model.baseTime;
        [cell.nameImg sd_setImageWithURL:[NSURL URLWithString:model.baseImg]];
        cell.nameImg.layer.cornerRadius = 2;
        for (int i = 0; i < model.baseImgLists.count; i++)
        {
            UIImageView *image = (UIImageView *)[cell viewWithTag:505 + i];
            image.tag = 505 + i;
            [image sd_setImageWithURL:[NSURL URLWithString:model.baseImgLists[i]]];
        }
        cell.tag = [model.baseID integerValue];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    
        return cell;
  }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HomeBaseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    ProjectModel *model = manger.m_baseLists[indexPath.row];
//    NSArray *imgs = model.baseImgLists;
//    AQCollectionVC *sub = [[AQCollectionVC alloc] init];
//    sub.title = @"查看图片";
//    sub.smallUrlArray = imgs;
//    sub.heardimg = cell.nameImg.image;
//    sub.nameLabstr = cell.nameLab.text;
//    sub.conetLabstr = cell.conetLab.text;
//    sub.subconetLabstr = cell.subConlab.text;
//    sub.fkID = [NSString stringWithFormat:@"%ld",cell.tag];
//    [self.navigationController pushViewController:sub animated:YES];

}
@end
