//
//  HomeViewController.m
//  PlantBox
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 JCK. All rights reserved.
//  无限滚动广告 sdcyclescrollerview

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"

#import "GrowingThreeController.h"
#import "AreaViewController.h"
#import "TheActivityViewController.h"
#import "ErweimaViewController.h"
#import "ShopController.h"
#import "ShopInfoController.h"
#import "HomeBaseController.h"

#import "HCommentsController.h"
#import "SeachController.h"
//#import "HJTestViewController.h"
//#import "HJLeftViewController.h"
//#import "HJMiddleViewController.h"
//#import "HJRightViewController.h"
#import "WebModel.h"
#import "WebViewController.h"
#import "PlantCenterController.h"
#import "MenuContentViewController.h"
#import "SHMenu.h"
#import "MJRefresh.h"
#import "HomeCell.h"
#import "HomeMapCell.h"
#import "DropDownListView.h"
#import "AQCollectionVC.h"
#import "ProjectModel.h"
#import "NextManger.h"

#import "KeyboardToolBar/KeyboardToolBar.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
//#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
//#import <ShareSDK/ShareSDK+Base.h>
//
//#import <ShareSDKExtension/ShareSDK+Extension.h>

#import "UMSocial.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,UIScrollViewDelegate,UMSocialUIDelegate>
{
    NSInteger *conunt;
    NSMutableArray *listNameArr;
    UIButton *barLeftButton;
    NextManger *manger;
    
    NSArray *homeBaseCellImgs;
    
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _initnavigationBar];
    [self setTableView];
    self.title = @"首页";
   // 导航栏返回btn
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
//    self.navigationItem.backBarButtonItem.image = [UIImage imageNamed:@"leftBtn"];
    backItem.title = @" ";
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    manger= [NextManger shareInstance];
    manger.isKeyword = NO;
    [manger loadData:RequestOfGetlist];
    [manger loadData:RequestOfGetprojectlist];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityAction) name:@"city" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"GetprojectlistWithKeyword" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawHeardView) name:@"advertise" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewData) name:@"subscribe" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedDidShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedDidappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self cityAction];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touchView" object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadDataAction
{
    [self.tableView reloadData];
}
- (void)reloadDataActionBtn
{
    [_tableView setContentOffset:CGPointMake(0,0) animated:YES];
//    [self.tableView reloadData];
}
#pragma - mark navigationBar
- (void)_initnavigationBar{
#pragma - mark 中间搜索栏
    UIButton *seachButton = ({
        UIButton *seachButton = [UIButton buttonWithType:UIButtonTypeCustom];
        seachButton.alpha = 0.25;
        seachButton.frame = CGRectMake(0, 0,300, 22);
        seachButton.backgroundColor = [UIColor whiteColor];
        seachButton.titleLabel.font = [UIFont systemFontOfSize:14];
        seachButton.layer.cornerRadius = 11;
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
        meassageBut.frame = CGRectMake(0, 0, 20, 20);
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
- (void)drawHeardView
{
    UIView *heardV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.4)];
    heardV.backgroundColor = [UIColor whiteColor];
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"zq1.jpg",
                            @"zq2.jpg",
                            @"zq3.jpg",
                            @"zq4.jpg",
                            ];
   /*
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, heardV.bounds.size.height*0.5) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [heardV addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    */
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, heardV.bounds.size.height*0.5) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
//    ProjectModel *model = [[ProjectModel alloc] init];
    NSArray *arr = manger.m_imgArr;
//    NSLog(@"%ld",arr.count);
    cycleScrollView3.imageURLStringsGroup = arr;
    [heardV addSubview:cycleScrollView3];
    
    NSArray *titles = @[@"植物商城",@"种植中心",@"成长树",@"活动专区"];
    NSArray *btnImgs = @[@"001",@"002",@"003",@"004"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button = [[UIButton alloc] initWithFrame:CGRectMake(i *(ScreenWidth/4)+ScreenWidth*0.07,heardV.bounds.size.height*0.5+15, ScreenWidth/9, ScreenWidth/9)];
        button.layer.cornerRadius = 23;
//        button.backgroundColor = [UIColor blueColor];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",btnImgs[i]]] forState:UIControlStateNormal];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(i *(ScreenWidth/4),heardV.bounds.size.height*0.5+15+ScreenWidth/9+5, ScreenWidth/4, 20)];
        titleLab.text = titles[i];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:12];
        [heardV addSubview:titleLab];
        [heardV addSubview:button];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, heardV.bounds.size.height-5, ScreenWidth, 5)];
    line.backgroundColor = RGB(240, 240, 240);
    [heardV addSubview:line];
    
    self.m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,heardV.bounds.size.height-5-33+5+10, ScreenWidth, 30)];
    //手动滑动的范围
    self.m_scrollView.contentSize = CGSizeMake(ScreenWidth*3, 0);
    // 分页属性
    self.m_scrollView.pagingEnabled = YES;
    self.m_scrollView.delegate = self;
    [heardV addSubview:self.m_scrollView];
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(0, heardV.bounds.size.height-5-33+5, ScreenWidth, 30);
    backgroundView.backgroundColor = [UIColor whiteColor];
    [heardV addSubview:backgroundView];
    
    NSArray *titleArray = @[@"最新", @"热门", @"综合"];
    CGFloat labelW = ScreenWidth / 3;  //数组里面有几个就除以几
    //遍历titleArray数组(从下标0开始) 返回obj(label的内容),idx(从下标0开始)
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(idx * labelW, 0,labelW, 30);
        label.text = obj;
        label.font = [UIFont systemFontOfSize:13];
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
    self.m_slideView.frame = CGRectMake(ScreenWidth*0.1, 30-2, ScreenWidth/7, 2);
    self.m_slideView.backgroundColor = RGB(27, 116, 203);
    [backgroundView addSubview:self.m_slideView];
    
    _tableView.tableHeaderView = heardV;
//    return heardV;
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
        
        self.m_slideView.frame = CGRectMake((ScreenWidth/3)*i+ScreenWidth*0.1, 30-2,ScreenWidth/7,2);

    }];
}


//点击手势视图完成后调用方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        
        NSInteger i = self.m_scrollView.contentOffset.x / ScreenWidth;
        self.m_slideView.frame = CGRectMake((ScreenWidth/3)*i+ScreenWidth*0.1, 30-2,ScreenWidth/7,2);
//        NSLog(@"%ld 点击手势视图完成后调用方法(long)",i);
        manger= [NextManger shareInstance];
        manger.isKeyword = YES;
//        NSLog(@"%ld",i+1);
        manger.keyword = [NSString stringWithFormat:@"%ld",i+1];
        [manger loadData:RequestOfGetprojectlist];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"GetprojectlistWithKeyword" object:nil];
        
    }];
}
#pragma mark - 创建视图
- (void)setTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [_tableView addGestureRecognizer:gestureRecognizer];
//
//    self.tableView.estimatedRowHeight = 100;
    [self registerNib];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}
- (void)loadNewData
{
    manger= [NextManger shareInstance];
    manger.isKeyword = NO;
    [manger loadData:RequestOfGetprojectlist];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"GetprojectlistWithKeyword" object:nil];
    [_tableView.header endRefreshing];
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
    SeachController *sub = [[SeachController alloc] init];
    sub.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sub animated:NO];
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
        return 220;
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
        if ( manger.m_ProductLists.count == 0) {
            return cell;
        }
        else
        {
            HomeCell *homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    //        homeCell.tag = 1008;
//            NSLog(@"%ld", manger.m_ProductLists.count);
            ProjectModel *model = manger.m_ProductLists[indexPath.row];
            [homeCell.nameBtn setTitle:model.productName forState:UIControlStateNormal];
            [homeCell.nameBtn addTarget:self action:@selector(pushInfo:) forControlEvents:UIControlEventTouchDown];
            
            homeCell.contentLab.text = model.prodeuctNotice;
            homeCell.infoLab.text = [NSString stringWithFormat:@"%@",model.prodeuctAddress];
            homeCell.userHeard.layer.cornerRadius = 41/2;
            [homeCell.userHeard sd_setImageWithURL:[NSURL URLWithString:model.productImg]];
            [homeCell.dianzanBtn setTitle:[NSString stringWithFormat:@"%@",model.hits] forState:UIControlStateNormal];
            [homeCell.pinlunBtn setTitle:[NSString stringWithFormat:@"%@",model.totalComment] forState:UIControlStateNormal];
            
            homeCell.tag = [model.productListID integerValue];
            homeCell.nameBtn.tag = [model.productUserID integerValue];
//            UIImageView *image = nil;
//            for (int i = 0; i < model.productListImgs.count; i++)
//            {
//                image = (UIImageView *)[homeCell viewWithTag:500 + i];
//                image.tag = 500 + i;
//                [image sd_setImageWithURL:[NSURL URLWithString:model.productListImgs[i]]];
//                image.image = [self croppIngimageByImageName:image.image toRect:CGRectMake(ScreenWidth/3.4/2, image.image.size.height/2-113/2, ScreenWidth/3.4, 113)];
//            }
            homeCell.img1.image = nil;
            homeCell.img2.image = nil;
            homeCell.img3.image = nil;
            if (model.productListImgs.count == 1)
            {
                [homeCell.img1 sd_setImageWithURL:[NSURL URLWithString:model.productListImgs[0]]];

                homeCell.img2.image = [UIImage imageNamed:@"nullImg"];
                homeCell.img3.image = [UIImage imageNamed:@"nullImg"];
            }
            else if (model.productListImgs.count == 2)
            {
                [homeCell.img1 sd_setImageWithURL:[NSURL URLWithString:model.productListImgs[0]]];

                [homeCell.img2 sd_setImageWithURL:[NSURL URLWithString:model.productListImgs[1]]];

                homeCell.img3.image = [UIImage imageNamed:@"nullImg"];
            }
            else if (model.productListImgs.count == 0)
            {
                homeCell.img1.image = [UIImage imageNamed:@"nullImg"];
                homeCell.img2.image = [UIImage imageNamed:@"nullImg"];
                homeCell.img3.image = [UIImage imageNamed:@"nullImg"];
            }
            else
            {
                [homeCell.img1 sd_setImageWithURL:[NSURL URLWithString:model.productListImgs[0]]];

                [homeCell.img2 sd_setImageWithURL:[NSURL URLWithString:model.productListImgs[1]]];

                [homeCell.img3 sd_setImageWithURL:[NSURL URLWithString:model.productListImgs[2]]];

            }

            homeCell.pinlunBtn.tag = [model.productListID integerValue];
            [homeCell.pinlunBtn addTarget:self action:@selector(pinlunAction:) forControlEvents:UIControlEventTouchDown];
            
            homeCell.dianzanBtn.tag = [model.productListID integerValue];
            [homeCell.dianzanBtn addTarget:self action:@selector(dianzanAction:) forControlEvents:UIControlEventTouchDown];
            
            [homeCell.shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchDown];
            homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            homeBaseCellImgs =  model.productListImgs;
            return homeCell;
//            static NSString *allCell = @"cell";
//            UITableViewCell *cell = nil;
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCell];
//                cell.selectionStyle = UITableViewCellAccessoryNone;
//            }
//            // 名字
//            UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(43, 8, ScreenWidth-86, 30)];
//            namelab.font = [UIFont systemFontOfSize:13];
//            [cell.contentView addSubview: namelab];
//            
//            // 描述
//            UILabel *conlab = [[UILabel alloc] initWithFrame:CGRectMake(43, 40, ScreenWidth-86, 30)];
//            conlab.font = [UIFont systemFontOfSize:11];
//            [cell.contentView addSubview: conlab];
//            
//            // 内容
//            UILabel *comlab = [[UILabel alloc] initWithFrame:CGRectMake(8, 45, ScreenWidth-90, 30)];
//            conlab.font = [UIFont systemFontOfSize:13];
//            [cell.contentView addSubview: comlab];
//            return cell;
        }
    }
    UIButton *loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loadMoreBtn.frame = CGRectMake(ScreenWidth/2-50, 3, 100, 25);
    loadMoreBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [loadMoreBtn setTitle:@"加载更多>>" forState:UIControlStateNormal];
    [loadMoreBtn setTitleColor:RGB(171, 171, 171) forState:UIControlStateNormal];
    [loadMoreBtn addTarget:self action:@selector(reloadDataActionBtn) forControlEvents:UIControlEventTouchDown];
    [cell.contentView addSubview:loadMoreBtn];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 2) {
        HomeMapCell *mapCell = [tableView dequeueReusableCellWithIdentifier:@"HomeMapCell"];
        mapCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return mapCell;
    }
    
    return cell;
}
#pragma mark - 处理图片
//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        NSLog(@"%ld",cell.tag);
//        HomeBaseController *subVC = [[HomeBaseController alloc] init];
////        subVC.shopID = [NSString stringWithFormat:@"%ld",cell.tag];
//        subVC.imgs = homeBaseCellImgs;
////        subVC.nameImgstr = cell.nameBtn.titleLabel.text;
//        subVC.heardimg = cell.userHeard.image;
//        subVC.conetLabstr = cell.contentLab.text;
//        subVC.hidesBottomBarWhenPushed = YES;
//        subVC.userID = [NSString stringWithFormat:@"%ld",cell.tag];
//        [self.navigationController pushViewController:subVC animated:YES];
        
//        ProjectModel *model = manger.m_baseLists[indexPath.row];
        NSArray *imgs = @[cell.img1.image,cell.img2.image,cell.img3.image];
        AQCollectionVC *sub = [[AQCollectionVC alloc] init];
        sub.title = @"查看详情";
        NSLog(@"%@",imgs);
        sub.smallUrlArray = imgs;
        sub.heardimg = cell.userHeard.image;
        sub.nameLabstr = cell.nameBtn.titleLabel.text;
        sub.conetLabstr = cell.contentLab.text;
        sub.subconetLabstr = cell.infoLab.text;
        sub.fkID = [NSString stringWithFormat:@"%ld",(long)cell.tag];
        sub.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sub animated:YES];
    }
}
#pragma mark - 4个按钮
- (void)pushAction:(UIButton *)btn
{
    switch (btn.tag) {
        case 1000:
        {
//            WebModel *model = [[WebModel alloc] initWithUrl:[NSString stringWithFormat:@"http://plantbox.meidp.com/Mobi/Product?UserId=%@",manger.userId]];
//            WebViewController *SVC = [[WebViewController alloc] init];
//            SVC.title = @"植物商城";
//            SVC.hidesBottomBarWhenPushed = YES;
//            [SVC setModel:model];
//            [self.navigationController pushViewController:SVC animated:YES];
            
            ShopController *subVC = [[ShopController alloc] init];
            subVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:subVC animated:YES];

        }
            break;
        case 1001:
        {
            PlantCenterController *subVC = [[PlantCenterController alloc] init];
            subVC.title = @"种植中心";
            subVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:subVC animated:YES];
        }
            break;
        case 1002:
        {
            GrowingThreeController *subVC = [[GrowingThreeController alloc] init];
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
//    WXViewController *wxVc = [WXViewController new];
//    [self presentViewController:wxVc animated:YES completion:NULL];
}
- (void)pushInfo:(UIButton *)btn
{
    NSLog(@"%ld",btn.tag);
//    HomeCell *cell = (HomeCell *)[self.tableView viewWithTag:btn.tag];
    HomeBaseController *subVC = [[HomeBaseController alloc] init];
//    //        subVC.shopID = [NSString stringWithFormat:@"%ld",cell.tag];
//    subVC.imgs = homeBaseCellImgs;
//    //        subVC.nameImgstr = cell.nameBtn.titleLabel.text;
//    subVC.heardimg = cell.userHeard.image;
//    subVC.conetLabstr = cell.contentLab.text;
//    subVC.hidesBottomBarWhenPushed = YES;
    subVC.userID = [NSString stringWithFormat:@"%ld",btn.tag];
    subVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subVC animated:YES];
    

}
- (void)pushMSG
{
    ErweimaViewController *eVC = [[ErweimaViewController alloc] init];
    eVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:eVC animated:YES];
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
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    /*
     
     http://www.kokoi.com.cn/lookbike/small/610.html
     */
//    NSLog(@"---点击了第%ld张图片 %@", (long)index,manger.m_imgLink);
    WebModel *model = [[WebModel alloc] initWithUrl:[NSString stringWithFormat:@"%@",manger.m_imgLink[index]]];
    WebViewController *SVC = [[WebViewController alloc] init];
    SVC.title = @"植物百科";
    SVC.hidesBottomBarWhenPushed = YES;
    [SVC setModel:model];
    [self.navigationController pushViewController:SVC animated:YES];

}
#pragma mark - 点赞
- (void)dianzanAction:(UIButton *) btn;
{
    manger.keyword = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    [manger loadData:RequestOfuserSubscribe];
}


#pragma mark - 分享
- (void)shareBtnAction:(UIButton *)btn
{
    [UMSocialData defaultData].extConfig.title = @"植物君邀请您加入PlantBox的世界";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://oa.meidp.com/";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57429ef6e0f55a7716000931"
                                      shareText:@"加入植物盒子，享受绿色生活，http://oa.meidp.com/"
                                     shareImage:[UIImage imageNamed:@"plantBox"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:self];
}
#pragma mark - 跳转评论
- (void)pinlunAction:(UIButton *)btn
{
//    NSLog(@"%@",btn);
    HCommentsController *subVC = [[HCommentsController alloc] init];
    subVC.hidesBottomBarWhenPushed = YES;
    subVC.shopID  = [NSString stringWithFormat:@"%ld",btn.tag];
    [self.navigationController pushViewController:subVC animated:YES];
    [self.tableView reloadData];

}

#if 0
-(void)ShareApp:(HomeViewController *)bar
{
    //    NSLog(@"url :%@",disCountDetailURL(_articleInfo.articleid)); http://viewer.maka.im/k/ORXCZ50R
    
    
    //    NSArray* imageArray = @[_articleInfo.imageUrl];
    //构造分享内容 _articleInfo.title
    NSMutableDictionary *shareParams=[NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"植物盒子的分享"
                                     images:nil
                                        url:[NSURL URLWithString:@"http://www.baidu.com"]
                                      title:@"欢迎使用植物盒子"
                                       type:SSDKContentTypeAuto];
    
    
    
    //    NSLog(@"%@ %@",_articleInfo.title,[NSURL URLWithString:disCountDetailURL(_articleInfo.articleid)]);
    __weak HomeViewController *theController = self;
    
    
    [ShareSDK showShareActionSheet:bar
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state,
                                     SSDKPlatformType platformType,
                                     NSDictionary *userData,
                                     SSDKContentEntity *contentEntity,
                                     NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           //                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           //                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                           //                                                                               message:nil
                           //                                                                              delegate:nil
                           //                                                                     cancelButtonTitle:@"确定"
                           //                                                                     otherButtonTitles:nil];
                           //                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin)
                   {
                       //                       [theController showLoadingView:NO];
                   }
                   
               }];
    
    
    [self.view endEditing:YES];

}
#endif
@end
