//
//  MineBaseMideViewController.m
//  PlantBox
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "BasePlantViewController.h"
#import "NextManger.h"
#import "ProjectModel.h"
@interface BasePlantViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    NextManger *manger;
}
@property (nonatomic ,strong) UITableView *tableView;
@end

@implementation BasePlantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTableView];
    
    manger = [NextManger shareInstance];
    manger.keyword = @"2";
    [manger loadData:RequestOfGetusergoodpagelist];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"getusergoodpagelist" object:nil];
//    UIButton *meassageBut = ({
//        UIButton *meassageBut = [UIButton buttonWithType:UIButtonTypeCustom];
//        meassageBut.frame = CGRectMake(0, 0, 25, 10);
//        [meassageBut addTarget:self action:@selector(showActionsheet) forControlEvents:UIControlEventTouchDown];
//        [meassageBut setImage:[UIImage imageNamed:@"near_barIcon"]forState:UIControlStateNormal];
//        meassageBut;
//    });
//    
//    UIBarButtonItem *rBtn = [[UIBarButtonItem alloc] initWithCustomView:meassageBut];
//    self.navigationItem.rightBarButtonItem = rBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadDataAction
{
    [self.tableView reloadData];
}
#pragma mark -
- (void)setTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 65) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    _tableView.tableHeaderView = [self drawTopview];
    
    //    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    //    gestureRecognizer.cancelsTouchesInView = NO;
    
    //    [_tableView addGestureRecognizer:gestureRecognizer];
    //
    //    self.tableView.estimatedRowHeight = 100;
//    [self registerNib];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return manger.m_myBases.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *infierCell = @"cell";
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell];
    }
    ProjectModel *model = manger.m_myBases[indexPath.row];
    cell.textLabel.text = model.myBasePlantName;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, 2, ScreenWidth/2-16, 44)];
    lab.text = @"1株";
//    lab.backgroundColor = [UIColor redColor];
    lab.font = [UIFont systemFontOfSize:15];
    lab.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview: lab];
    return cell;
}
#pragma mark-
- (void)showActionsheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"数量递减", @"数量递增",@"按不同种类",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",buttonIndex);
    //
    //    if (buttonIndex == 0) {
    //        [self showAlert:@"确定"];
    //    }else if (buttonIndex == 1) {
    //        [self showAlert:@"第一项"];
    //    }else if(buttonIndex == 2) {
    //        [self showAlert:@"第二项"];
    //    }else if(buttonIndex == 3) {
    //        [self showAlert:@"取消"];
    //    }
    
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
@end
