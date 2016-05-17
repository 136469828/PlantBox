//
//  MyBaseViewController.m
//  PlantBox
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "MyBaseViewController.h"
#import "BasePlantViewController.h"
#import "BaseStarManViewController.h"
#import "MineCell.h"
#import "HomeCell.h"
#import "ProjectModel.h"
#import "NextManger.h"
#import "UIImageView+WebCache.h"
#define screenWidth [[UIScreen mainScreen]bounds].size.width  //屏幕的长
#define screenHiegth [[UIScreen mainScreen]bounds].size.height //屏幕的高
@interface MyBaseViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSArray *cellArr;
    NextManger *manger;
}
@property (nonatomic,strong) UIImageView *userImage;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIScrollView *m_scrollView;
@property (nonatomic, assign) NSInteger tableViewTag;
@property (nonatomic, strong) UIView *m_slideView;
@end

@implementation MyBaseViewController
// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewTag = 0;
    if (self.tableViewTag == 0)
    {
        [self loadData];
    }
    [self setTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
- (void)setTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = [self drawTopview];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [_tableView addGestureRecognizer:gestureRecognizer];
    //
    //    self.tableView.estimatedRowHeight = 100;
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"MineCell",@"HomeCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (UIView *)drawTopview
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.37-19)];
    topView.backgroundColor = RGB(7, 115, 226);
    
    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2, topView.bounds.origin.y, (ScreenHeight-ScreenHeight*0.38-19-29)/3, (ScreenHeight-ScreenHeight*0.38-19-29)/3)];
    _userImage.image = [UIImage imageNamed:@"testUserImg"];
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = ((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2;
    [topView addSubview:_userImage];

    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _userImage.bounds.origin.y+(ScreenHeight-ScreenHeight*0.38-19-29)/3+10, ScreenWidth, 30)];
    //    nameLab.backgroundColor = [UIColor redColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont systemFontOfSize:15];
    nameLab.text = manger.userC_Name;
    [topView addSubview:nameLab];
    
    self.m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, screenWidth, screenHiegth)];
    //手动滑动的范围
    self.m_scrollView.contentSize = CGSizeMake(screenWidth*2, 0);
    // 分页属性
    self.m_scrollView.pagingEnabled = YES;
    self.m_scrollView.delegate = self;
    [topView addSubview:self.m_scrollView];
    
    //    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHiegth)];
    //    view1.backgroundColor = [UIColor yellowColor];
    //    [self.m_scrollView addSubview:view1];
    //
    //    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, screenHiegth)];
    //    view2.backgroundColor = [UIColor blueColor];
    //    [self.m_scrollView addSubview:view2];
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(0, topView.bounds.size.height-35, screenWidth, 35);
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    NSArray *titleArray = @[@"主页", @"基地",@"成果"];
    CGFloat labelW = screenWidth / 3;  //数组里面有几个就除以几
    //遍历titleArray数组(从下标0开始) 返回obj(label的内容),idx(从下标0开始)
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(idx * labelW, 0,labelW, 35);
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
    self.m_slideView.frame = CGRectMake(0, 35-2, labelW, 2);
    self.m_slideView.backgroundColor = [UIColor blueColor];
    [backgroundView addSubview:self.m_slideView];
    
    [topView addSubview:backgroundView];


    return topView;
}
#pragma mark - 滑动条事件
//单击label的时候scrollView滑动范围
- (void)tapHandler:(UITapGestureRecognizer *)tap
{
    //view(表示当前对应的label)  获取视图对应的Tag值
    NSInteger i = tap.view.tag;
    
    [self.m_scrollView setContentOffset:CGPointMake(i * screenWidth, 0) animated:YES];
    NSLog(@"单击label的时候scrollView滑动范围 %ld",i);
    
}



#pragma mark - UIScrollViewDelegate
// 手势滑动视图减速完成后调用方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        NSInteger i = self.m_scrollView.contentOffset.x / screenWidth;
        
        self.m_slideView.frame = CGRectMake((screenWidth/3)*i, 35-2,screenWidth/3,2);
        NSLog(@"手势滑动视图减速完成后调用方法");
    }];
}


//点击手势视图完成后调用方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        NSInteger i = self.m_scrollView.contentOffset.x / screenWidth;
        self.m_slideView.frame = CGRectMake((screenWidth/3)*i, 35-2,screenWidth/3,2);
            NSLog(@"点击手势视图完成后调用方法 %ld",i);
        _tableViewTag = i;
        if (self.tableViewTag == 0)
        {
            [self loadData];
        }
        [self.tableView reloadData];
    }];
}
- (void)loadData
{
    manger= [NextManger shareInstance];
    manger.isKeyword = NO;
    [manger loadData:RequestOfGetprojectlist];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"GetprojectlistWithKeyword" object:nil];
}
- (void)reloadDataAction
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma maek - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.tableViewTag) {
        case 0:
        {
            if (section == 0)
            {
                return 1;
            }
            else
            {
                return manger.m_ProductLists.count;
            }
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return 0;
        }
            break;
            
        default:
            break;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView // 一个表视图里面有多少组
{
    switch (self.tableViewTag) {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.tableViewTag) {
        case 0:
        {
            if (indexPath.section == 0) {
                return 145;
            }
            else
            {
                return 240;
            }
        }
            break;
        case 1:
        {
            return 44;
        }
            break;
        case 2:
        {
            return 44;
        }
            break;
            
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.tableViewTag) {
        case 0:
        {
            if (indexPath.section == 0) {
                MineCell *mineCell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
                //            cell.textLabel.text = [NSString stringWithFormat:@"1 :%ld",indexPath.row];
                mineCell.localLab.text = manger.userAddress;
                mineCell.nameLab.text = manger.userC_Name;
                mineCell.sexLab.text = @"男";
                mineCell.retimeLab.text = manger.createTime;
                mineCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return mineCell;
            }
            else
            {
                HomeCell *homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
                ProjectModel *model = manger.m_ProductLists[indexPath.row];
                //        NSLog(@"%ld",model.productListImgs.count);
                homeCell.nameLab.text = model.productName;
                homeCell.contentLab.text = @"CocoaPods是iOS项目的依赖管理工具，该项目源码在Github上管理。开发iOS项目不可避免地要使用第三方开源库，CocoaPods的出现使得我们可以节省设置和第三方开源库的时间。";
                //        [homeCell configCellWithButtonModels:manger.m_ProductLists];
                //        [homeCell.downBtn addTarget:self action:@selector(downMune:) forControlEvents:UIControlEventTouchDown];
                for (int i = 0; i < model.productListImgs.count; i++)
                {
                    NSLog(@"%d",i);
                    UIImageView *image = (UIImageView *)[homeCell viewWithTag:500 + i];
                    image.tag = 500 + i;
                    [image sd_setImageWithURL:[NSURL URLWithString:model.productListImgs[i]]];
                    //        titleLabel.text = model.title;
                }
                homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return homeCell;
            }

        }
            break;
        case 1:
        {
            static NSString *infierCell = @"cell";
            UITableViewCell *cell = nil;
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell];
            }
            NSArray *titles = @[@"基地植物",@"基地人物星人图"];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",titles[indexPath.row ]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            static NSString *infierCell = @"cell";
            UITableViewCell *cell = nil;
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell];
            }
             cell.textLabel.text = [NSString stringWithFormat:@"3 :%ld",indexPath.row];
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.tableViewTag) {
        case 0: // 主页
        {
            NSLog(@"主页");
        }
            break;
        case 1: // 基地
        {
            NSLog(@"基地");
            if (indexPath.row == 0) {
                BasePlantViewController *subVC = [[BasePlantViewController alloc] init];
                subVC.hidesBottomBarWhenPushed = YES;
                subVC.title = @"基地植物";
                [self.navigationController pushViewController:subVC animated:YES];
            }
            else
            {
                BaseStarManViewController *subVC = [[BaseStarManViewController alloc] init];
                subVC.hidesBottomBarWhenPushed = YES;
                subVC.title = @"基地人物星人图";
                [self.navigationController pushViewController:subVC animated:YES];

            }
            
        }
            break;
        case 2: // 成果
        {
            NSLog(@"成果");
        }
            break;
            
        default:
            break;
    }

}
- (void)hideKeyboard
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touchView" object:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touchView" object:nil];
}

@end
