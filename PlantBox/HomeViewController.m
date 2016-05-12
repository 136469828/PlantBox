//
//  HomeViewController.m
//  PlantBox
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 JCK. All rights reserved.
//  无限滚动广告 sdcyclescrollerview

#import "HomeViewController.h"
#import "SDCycleScrollView.h"

#import "GrowingTreeViewController.h"
#import "AreaViewController.h"
#import "TheActivityViewController.h"

#import "HJTestViewController.h"
#import "HJLeftViewController.h"
#import "HJMiddleViewController.h"
#import "HJRightViewController.h"
#import "MenuContentViewController.h"
#import "SHMenu.h"

#import "HomeCell.h"
#import "HomeMapCell.h"
#import "DropDownListView.h"

#import "ProjectModel.h"
#import "NextManger.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,UIScrollViewDelegate>
{
    NSInteger *conunt;
    NSMutableArray *listNameArr;
    UIButton *barLeftButton;
    NextManger *manger;
}
@property (nonatomic, strong) SHMenu *menu;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topSliderLine;
@property(nonatomic,strong) UIScrollView *m_scrollView;

@property (nonatomic, strong) UIView *m_slideView;

@property (nonatomic, strong)UIButton *leftbtn;

@end

@implementation HomeViewController
// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _initnavigationBar];
    [self setTableView];
   // 导航栏返回btn
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
//    self.navigationItem.backBarButtonItem.image = [UIImage imageNamed:@"leftBtn"];
    backItem.title = @"";
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    manger= [NextManger shareInstance];
    manger.isKeyword = NO;
    [manger loadData:RequestOfGetprojectlist];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityAction) name:@"city" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"GetprojectlistWithKeyword" object:nil];


}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self cityAction];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadDataAction
{
    [self.tableView reloadData];
}
#pragma - mark navigationBar
- (void)_initnavigationBar{
#pragma - mark 中间搜索栏
    UIButton *seachButton = ({
        UIButton *seachButton = [UIButton buttonWithType:UIButtonTypeCustom];
        seachButton.alpha = 0.25;
        seachButton.frame = CGRectMake(0, 0, 260, 30);
        seachButton.backgroundColor = [UIColor whiteColor];
        seachButton.titleLabel.font = [UIFont systemFontOfSize:14];
        seachButton.layer.cornerRadius = 15;
        seachButton.layer.borderColor = [UIColor whiteColor].CGColor;
        seachButton.layer.borderWidth = 1;
        seachButton.backgroundColor = RGB(7, 115, 226);
        [seachButton setTitleColor:RGBColor(195, 195, 195) forState:UIControlStateNormal];
        [seachButton setTitle:[NSString stringWithFormat:@"搜索植物品/用户"]  forState:UIControlStateNormal];
        [seachButton setImage:[UIImage imageNamed:@"icon_textfield_search@2x"] forState:UIControlStateNormal];
        [seachButton addTarget:self action:@selector(pushSeachVC) forControlEvents:UIControlEventTouchDown];
        seachButton;
    });
    
    self.navigationItem.titleView = seachButton;
#pragma mark - 设置navigationItem右侧按钮
    UIButton *meassageBut = ({
        UIButton *meassageBut = [UIButton buttonWithType:UIButtonTypeCustom];
        meassageBut.frame = CGRectMake(-20, 0, 40, 40);
        [meassageBut addTarget:self action:@selector(pushMSG) forControlEvents:UIControlEventTouchDown];
        [meassageBut setImage:[UIImage imageNamed:@"icon_homepage_scan"]forState:UIControlStateNormal];
        meassageBut;
    });
    
    UIBarButtonItem *rBtn = [[UIBarButtonItem alloc] initWithCustomView:meassageBut];
    self.navigationItem.rightBarButtonItem = rBtn;
    
#pragma mark - 设置navigationItem左侧按钮
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        barLeftButton = ({
        barLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        barLeftButton.frame = CGRectMake(0, 0, 50, 40);
        [barLeftButton setTitle:[user objectForKey:@"city"] forState:UIControlStateNormal];
        barLeftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [barLeftButton addTarget:self action:@selector(pushCityAction) forControlEvents:UIControlEventTouchDown];
        
        barLeftButton;
    });
//    barLeftButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *lBtn = [[UIBarButtonItem alloc] initWithCustomView:barLeftButton];

    self.navigationItem.leftBarButtonItem = lBtn;
    
//    listNameArr = [NSMutableArray arrayWithArray:@[@[@"深圳"]]];
//    DropDownListView *listView = [[DropDownListView alloc] initWithFrame:CGRectMake(-20, 0, 65, 30)dataSource:self delegate:self];
//    listView.mSuperView = self.view;
//    
//    UIBarButtonItem *lBut = [[UIBarButtonItem alloc] initWithCustomView:listView];
//    
//    self.navigationItem.leftBarButtonItem = lBut;
    
}

#pragma mark - 头视图
- (UIView *)drawHeardView
{
    UIView *heardV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.5)];
    heardV.backgroundColor = [UIColor whiteColor];
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"zq1.jpg",
                            @"zq2.jpg",
                            @"zq3.jpg",
                            @"zq4.jpg",
                            ];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, heardV.bounds.size.height*0.5) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [heardV addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    NSArray *titles = @[@"植物商城",@"种植中心",@"成长树",@"活动专区"];
    NSArray *btnImgs = @[@"001",@"002",@"003",@"004"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button = [[UIButton alloc] initWithFrame:CGRectMake(i *(ScreenWidth/4)+ScreenWidth*0.06, heardV.bounds.size.height*0.5+15, 46, 46)];
        button.layer.cornerRadius = 23;
//        button.backgroundColor = [UIColor blueColor];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",btnImgs[i]]] forState:UIControlStateNormal];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(i *(ScreenWidth/4)+ScreenWidth*0.028, heardV.bounds.size.height*0.5+65, 70, 30)];
        titleLab.text = titles[i];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:13];
        [heardV addSubview:titleLab];
        [heardV addSubview:button];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, heardV.bounds.size.height*0.5+95, ScreenWidth, 5)];
    line.backgroundColor = RGB(240, 240, 240);
    [heardV addSubview:line];
    
    self.m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,heardV.bounds.size.height*0.5+100, ScreenWidth, 40)];
    //手动滑动的范围
    self.m_scrollView.contentSize = CGSizeMake(ScreenWidth*3, 0);
    // 分页属性
    self.m_scrollView.pagingEnabled = YES;
    self.m_scrollView.delegate = self;
    [heardV addSubview:self.m_scrollView];
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(0, heardV.bounds.size.height*0.5+105, ScreenWidth, 40);
    backgroundView.backgroundColor = [UIColor whiteColor];
    [heardV addSubview:backgroundView];
    
    NSArray *titleArray = @[@"最新", @"热门", @"综合"];
    CGFloat labelW = ScreenWidth / 3;  //数组里面有几个就除以几
    //遍历titleArray数组(从下标0开始) 返回obj(label的内容),idx(从下标0开始)
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(idx * labelW, 0,labelW, 40);
        label.text = obj;
        //设置文本内容居中
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        label.tag = idx;
        [backgroundView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        [label addGestureRecognizer:tap];
        
    }];
    
    //滑动条
    self.m_slideView = [[UIView alloc] init];
    self.m_slideView.frame = CGRectMake(ScreenWidth*0.1, 40-2, ScreenWidth/7, 2);
    self.m_slideView.backgroundColor = RGB(27, 116, 203);
    [backgroundView addSubview:self.m_slideView];
    return heardV;
}
//单击label的时候scrollView滑动范围
- (void)tapHandler:(UITapGestureRecognizer *)tap
{
    //view(表示当前对应的label)  获取视图对应的Tag值
    NSInteger i = tap.view.tag;
    
    [self.m_scrollView setContentOffset:CGPointMake(i * ScreenWidth, 0) animated:YES];
    
}
#pragma mark - UIScrollViewDelegate
// 手势滑动视图减速完成后调用方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        
        NSInteger i = self.m_scrollView.contentOffset.x / ScreenWidth;
        
        self.m_slideView.frame = CGRectMake((ScreenWidth/3)*i+ScreenWidth*0.1, 40-2,ScreenWidth/7,2);
    }];
}


//点击手势视图完成后调用方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        
        NSInteger i = self.m_scrollView.contentOffset.x / ScreenWidth;
        self.m_slideView.frame = CGRectMake((ScreenWidth/3)*i+ScreenWidth*0.1, 40-2,ScreenWidth/7,2);
    }];
}
#pragma mark - 
- (void)setTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = [self drawHeardView];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [_tableView addGestureRecognizer:gestureRecognizer];
//
//    self.tableView.estimatedRowHeight = 100;
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"HomeCell",@"HomeMapCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (void)pushSeachVC
{
    NSLog(@"点击搜索");
}
#pragma mark - tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (manger.m_ProductLists.count == 0) {
            return 0;
        }
        else
        {
            return manger.m_ProductLists.count;
    
        }
    }
    return 1;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 240;
    }
    if (indexPath.section == 2) {
        return 230;
    }
    return 30;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section // 返回组的头宽
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section // 返回组的尾宽
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIndefier = @"cell";
    UITableViewCell *cell = nil;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefier];
    }
    if (indexPath.section == 0)
    {
        HomeCell *homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
        homeCell.tag = 1008;
        ProjectModel *model = manger.m_ProductLists[indexPath.row];
//        NSLog(@"%ld",model.productListImgs.count);
        homeCell.nameLab.text = model.productName;
        homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [homeCell.downBtn addTarget:self action:@selector(downMune:) forControlEvents:UIControlEventTouchDown];
        return homeCell;

    }
    UIButton *loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loadMoreBtn.frame = CGRectMake(ScreenWidth/2-50, 3, 100, 25);
    loadMoreBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [loadMoreBtn setTitle:@"加载更多>>" forState:UIControlStateNormal];
    [loadMoreBtn setTitleColor:RGB(171, 171, 171) forState:UIControlStateNormal];
    [cell.contentView addSubview:loadMoreBtn];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 2) {
        HomeMapCell *mapCell = [tableView dequeueReusableCellWithIdentifier:@"HomeMapCell"];
        mapCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return mapCell;
    }
    
    return cell;
}
#pragma mark - 4个按钮
- (void)pushAction:(UIButton *)btn
{
    NSLog(@"%ld",btn.tag);
    switch (btn.tag) {
        case 1000:
        {
        
        }
            break;
        case 1001:
        {
            HJTestViewController *subVC = [[HJTestViewController alloc] init];
//            self.title = @"种植中心";
            subVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:subVC animated:YES];
        }
            break;
        case 1002:
        {
            GrowingTreeViewController *subVC = [[GrowingTreeViewController alloc] init];
            subVC.title = @"成长树";
            subVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:subVC animated:YES];
        }
            break;
        case 1003:
        {
            TheActivityViewController *subVC = [[TheActivityViewController alloc] init];
            subVC.title = @"活动专区";
            subVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:subVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - btnAction
- (void)pushCityAction
{
    AreaViewController *areaVC = [[AreaViewController alloc] init];
    areaVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:areaVC animated:YES];
}
- (void)pushMSG
{
    NSLog(@"点击了");
}
- (void)downMune:(UIButton*)sender
{
    UITableViewCell *cell = (UITableViewCell *)[self.view viewWithTag:1008];
    UIButton *button = (UIButton *)sender;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    CGRect rect1 = [button convertRect:button.frame fromView:cell.contentView];     //获取button在contentView的位置
    CGRect rect2 = [button convertRect:rect1 toView:window];         //获取button在window的位置
    CGRect rect3 = CGRectInset(rect2, -0.5 * 8, -0.5 * 8);          //扩大热区
    //rect3就是最终结果。
        NSLog(@"%f %f",rect3.origin.x,rect3.origin.y);
    
    if (_menu.state == MenuShow) return;
    MenuContentViewController *menuVC = [[MenuContentViewController alloc] init];
    SHMenu *menu = [[SHMenu alloc] initWithFrame:CGRectMake(0, 0, 160, 100)];
    _menu = menu;
    menu.contentVC = menuVC;
    menu.anchorPoint = CGPointMake(1, 0);
    menu.contentOrigin = CGPointMake(0, 8);
    [menu showFromPoint:CGPointMake(rect3.origin.x-120, rect3.origin.y)];
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

- (void)cityAction
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user objectForKey:@"city"]);
    [barLeftButton setTitle:[user objectForKey:@"city"] forState:UIControlStateNormal];
}
#pragma mark - dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [listNameArr count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =listNameArr[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return listNameArr[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}
@end
