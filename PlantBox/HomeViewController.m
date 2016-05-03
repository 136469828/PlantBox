//
//  HomeViewController.m
//  PlantBox
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 JCK. All rights reserved.
//  无限滚动广告 sdcyclescrollerview

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "HomeCell.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _initnavigationBar];
    [self setTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark navigationBar
- (void)_initnavigationBar{
#pragma - mark 中间搜索栏
    UIButton *seachButton = ({
        UIButton *seachButton = [UIButton buttonWithType:UIButtonTypeCustom];
        seachButton.alpha = 0.6;
        seachButton.frame = CGRectMake(0, 0, 260, 30);
        seachButton.backgroundColor = [UIColor whiteColor];
        seachButton.titleLabel.font = [UIFont systemFontOfSize:15];
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
        meassageBut.frame = CGRectMake(0, 0, 40, 40);
        [meassageBut addTarget:self action:@selector(pushMSG) forControlEvents:UIControlEventTouchDown];
        [meassageBut setImage:[UIImage imageNamed:@"icon_homepage_scan"]forState:UIControlStateNormal];
        meassageBut;
    });
    
    UIBarButtonItem *rBtn = [[UIBarButtonItem alloc] initWithCustomView:meassageBut];
    self.navigationItem.rightBarButtonItem = rBtn;
    
#pragma mark - 设置navigationItem左侧按钮
    UIButton *barLeftButton = ({
        UIButton *barLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        barLeftButton.frame = CGRectMake(0, 0, 40, 40);
        [barLeftButton setTitle:@"肇庆" forState:UIControlStateNormal];
        barLeftButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [barLeftButton addTarget:self action:@selector(pushErWeiMaV) forControlEvents:UIControlEventTouchDown];
        
        barLeftButton;
    });
    UIBarButtonItem *lBtn = [[UIBarButtonItem alloc] initWithCustomView:barLeftButton];
    self.navigationItem.leftBarButtonItem = lBtn;
    
}
#pragma mark - 头视图
- (UIView *)drawHeardView
{
    UIView *heardV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.45)];
    heardV.backgroundColor = [UIColor whiteColor];
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"zq1.jpg",
                            @"zq2.jpg",
                            @"zq3.jpg",
                            @"zq4.jpg",
                            ];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, heardV.bounds.size.height*0.65) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [heardV addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    NSArray *titles = @[@"植物商城",@"种植中心",@"成长树",@"活动专区"];
    NSArray *btnImgs = @[@"001",@"002",@"003",@"004"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button = [[UIButton alloc] initWithFrame:CGRectMake(i *(ScreenWidth/4)+ScreenWidth*0.06, heardV.bounds.size.height*0.6+20, 46, 46)];
        button.layer.cornerRadius = 23;
//        button.backgroundColor = [UIColor blueColor];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",btnImgs[i]]] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(i *(ScreenWidth/4)+ScreenWidth*0.028, heardV.bounds.size.height*0.6+65, 70, 30)];
        titleLab.text = titles[i];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:13];
        [heardV addSubview:titleLab];
        [heardV addSubview:button];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, heardV.bounds.size.height-5, ScreenWidth, 5)];
    line.backgroundColor = RGB(240, 240, 240);
    [heardV addSubview:line];
    return heardV;
}
#pragma mark - 
- (void)setTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = [self drawHeardView];
//    self.tableView.estimatedRowHeight = 300;
//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    gestureRecognizer.cancelsTouchesInView = NO;
//    
//    [_tableView addGestureRecognizer:gestureRecognizer];
//    
//    self.tableView.estimatedRowHeight = 100;
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"HomeCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (void)pushSeachVC
{
    NSLog(@"点击搜索");
}
#pragma mark - tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 270;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    static NSString *cellIndefier = @"cell";
//    UITableViewCell *cell = nil;
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefier];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row ];
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)pushMSG
{
    NSLog(@"点击了");
}
@end
