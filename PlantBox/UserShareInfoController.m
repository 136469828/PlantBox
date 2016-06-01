//
//  UserShareInfoController.m
//  PlantBox
//
//  Created by admin on 16/5/26.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "UserShareInfoController.h"
#import "PublishedCell.h"
#import "ProjectModel.h"
#import "NextManger.h"
#import "UIImageView+WebCache.h"
@interface UserShareInfoController ()<UITableViewDelegate,UITableViewDataSource>
{
    //    NSInteger count;
    UIButton *addImg;
    NextManger *manger;
    UITextField *timeLab;
    UITextView *contextView;
    //    UILabel *titlelab;
}
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation UserShareInfoController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.goodsID);
    if (self.goodsID.length == 0)
    {
        self.goodsID = @"0";
    }
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
    //    count = 1;
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
    
    manger = [NextManger shareInstance];
    manger.keyword = self.goodsID;
    [manger loadData:RequestOfgetusercourse];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getusercourse" object:nil];
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
    self.tableView.estimatedRowHeight = 150;
    
    //    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    //    titlelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    //    timeLab.textAlignment = kCTTextAlignmentCenter;
    //    timeLab.font = [UIFont systemFontOfSize:15];
    //    timeLab.textColor = [UIColor blackColor];
    //    [v addSubview:timeLab];
    //
    //    self.tableView.tableHeaderView = v;
    
    //    UISwipeGestureRecognizer *recognizer;
    //
    //    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    //    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    //    [self.tableView addGestureRecognizer:recognizer];
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
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return count;
    if ([self.goodsID isEqualToString:@"0"])
    {
        return 0;
    }
    return manger.m_rcourses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishedCell"];
    ProjectModel *model = manger.m_rcourses[indexPath.row];
    cell.dayLab.text = model.recourseTime;
    cell.context.text = model.rcourseCom;
    //    titlelab.text = model.rcourseTitle;
    for (int i = 0; i < model.rcourseImgLists.count; i++)
    {
        UIImageView *image = (UIImageView *)[cell viewWithTag:700 + i];
        image.tag = 700 + i;
        [image sd_setImageWithURL:[NSURL URLWithString:model.rcourseImgLists[i]]];
        //        titleLabel.text = model.title;
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hideKeyboard];
}
-(void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
    
}


@end
