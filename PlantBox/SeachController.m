//
//  SeachController.m
//  PlantBox
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "SeachController.h"
#import "ProjectModel.h"
#import "NextManger.h"
#import "HomeCell.h"
#import "UIImageView+WebCache.h"
#import "ShopInfoController.h"
#import "CommentsController.h"
#import "KeyboardToolBar/KeyboardToolBar.h"
@interface SeachController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NextManger *manger;
    UIView *hearView;
    UITextField *seachTextField;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SeachController
// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setTableView];
}
- (void)reloadDataAction
{
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self hearView];
    _tableView.tableHeaderView = hearView;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_tableView];
    
//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    gestureRecognizer.cancelsTouchesInView = NO;
//    
//    [_tableView addGestureRecognizer:gestureRecognizer];
    //
    //    self.tableView.estimatedRowHeight = 100;
    [self registerNib];
}
- (void)hearView{
    
    hearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    //    hearView.backgroundColor = [UIColor redColor];
    [self.view addSubview:hearView];
    seachTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 80, 30)];
    seachTextField.delegate = self;
    seachTextField.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    seachTextField.layer.borderWidth = 1.0; // set borderWidth as you want.
    seachTextField.layer.cornerRadius=8.0f;
    seachTextField.layer.masksToBounds=YES;
    [KeyboardToolBar registerKeyboardToolBar:seachTextField];
    [hearView addSubview:seachTextField];
    
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seachBtn setImage:[UIImage imageNamed:@"seachBtn"] forState:UIControlStateNormal];
    seachBtn.frame = CGRectMake(SCREEN_WIDTH - 55, 0, 30, 30);
    [seachBtn addTarget:self action:@selector(seachAction) forControlEvents:UIControlEventTouchDown];
    [hearView addSubview:seachBtn];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(8, hearView.bounds.size.height - 1, ScreenWidth - 16, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [hearView addSubview:line];
    
}
#pragma mark - 搜索
- (void)seachAction
{
    manger= [NextManger shareInstance];
    manger.isKeyword = YES;
    manger.keyword = seachTextField.text;
    [manger loadData:RequestOfGetprojectlist];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"GetprojectlistWithKeyword" object:nil];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"HomeCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
#pragma mark - tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (manger.m_ProductLists.count == 0)
    {
//        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未能搜索到相关项目" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [al show];
        return 0;
    }
    else
    {
        return manger.m_ProductLists.count;
        
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 230;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    //        homeCell.tag = 1008;
    ProjectModel *model = manger.m_ProductLists[indexPath.row];
    homeCell.nameLab.text = model.productName;
    homeCell.contentLab.text = model.prodeuctNotice;
    homeCell.infoLab.text = [NSString stringWithFormat:@"2分钟 来自 iPhone6 %@ 距离 5km",model.prodeuctAddress];
    homeCell.tag = [model.productListID integerValue];
    for (int i = 0; i < model.productListImgs.count; i++)
    {
        UIImageView *image = (UIImageView *)[homeCell viewWithTag:500 + i];
        image.tag = 500 + i;
        [image sd_setImageWithURL:[NSURL URLWithString:model.productListImgs[i]]];
        //        titleLabel.text = model.title;
    }
    homeCell.pinlunBtn.tag = [model.productListID integerValue];
    [homeCell.pinlunBtn addTarget:self action:@selector(pinlunAction:) forControlEvents:UIControlEventTouchDown];
    homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return homeCell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //        NSLog(@"%ld",cell.tag);
        //        WebModel *model = [[WebModel alloc] initWithUrl:[NSString stringWithFormat:@"http://plantbox.meidp.com/Mobi/Home/NoticeDetail?UserId=%@&id=%ld",manger.userId,cell.tag]];
        //        WebViewController *SVC = [[WebViewController alloc] init];
        //        SVC.title = @"植物详情";
        //        SVC.hidesBottomBarWhenPushed = YES;
        //        [SVC setModel:model];
        //        [self.navigationController pushViewController:SVC animated:YES];
        ShopInfoController *subVC = [[ShopInfoController alloc] init];
        subVC.shopID = [NSString stringWithFormat:@"%ld",cell.tag];
        subVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subVC animated:YES];
}
#pragma mark - 跳转评论
- (void)pinlunAction:(UIButton *)btn
{
    NSLog(@"%@",btn);
    CommentsController *subVC = [[CommentsController alloc] init];
    subVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subVC animated:YES];
}
#pragma mark - 点击/滚动tableView
- (void)hideKeyboard
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touchView" object:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touchView" object:nil];
}

@end
