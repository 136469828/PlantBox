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
#import "MyComListController.h"
#import "ShopController.h"
#import "MineCell.h"
#import "HomeBaseCell.h"
#import "ProjectModel.h"
#import "NextManger.h"
#import "UIImageView+WebCache.h"
#import "MyBaseOrPlantListController.h"
#import "KeyboardToolBar/KeyboardToolBar.h"
#import "UIImageView+WebCache.h"
#define screenWidth [[UIScreen mainScreen]bounds].size.width  //屏幕的长
#define screenHiegth [[UIScreen mainScreen]bounds].size.height //屏幕的高
@interface MyBaseViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSArray *cellArr;
    NextManger *manger;
    NSArray *titles;
    NSInteger cellCount;
    BOOL isSelet;
    NSArray *datas;
    NSArray *homeBaseCellImgs;
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
    // 添加导航右按钮
    UIBarButtonItem *rightBtuForBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMyBase)];
    self.navigationItem.rightBarButtonItem = rightBtuForBar;

    
    cellCount = 2;
    isSelet = NO;
    /*
     MineCell *mineCell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
     //            cell.textLabel.text = [NSString stringWithFormat:@"1 :%ld",indexPath.row];
     mineCell.localLab.text = manger.userAddress;
     mineCell.nameLab.text = manger.userC_Name;
     mineCell.sexLab.text = @"男";
     mineCell.retimeLab.text = manger.createTime;
     */
    titles = @[@"我的评论",@"立即种植"];
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
    NSArray *registerNibs = @[@"MineCell",@"HomeBaseCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (UIView *)drawTopview
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.40-19)];
    topView.backgroundColor = RGB(7, 115, 226);
    
    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2, topView.bounds.origin.y+10, (ScreenHeight-ScreenHeight*0.38-19-29)/3, (ScreenHeight-ScreenHeight*0.38-19-29)/3)];
    [_userImage sd_setImageWithURL:[NSURL URLWithString:manger.userPhoto]];
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = ((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2;
    [topView addSubview:_userImage];

    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, topView.bounds.size.height - 100, ScreenWidth, 30)];
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
    self.m_slideView.frame = CGRectMake(20, 35-2, labelW-40, 2);
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
    
    [self.m_scrollView setContentOffset:CGPointMake(i * screenWidth+20, 0) animated:YES];
    NSLog(@"单击label的时候scrollView滑动范围 %ld",i);
    
}



#pragma mark - UIScrollViewDelegate
// 手势滑动视图减速完成后调用方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        NSInteger i = self.m_scrollView.contentOffset.x / screenWidth;
        
        self.m_slideView.frame = CGRectMake((screenWidth/3)*i+20, 35-2,screenWidth/3-40,2);
        NSLog(@"手势滑动视图减速完成后调用方法");
    }];
}


//点击手势视图完成后调用方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        NSInteger i = self.m_scrollView.contentOffset.x / screenWidth;
        self.m_slideView.frame = CGRectMake((screenWidth/3)*i+20, 35-2,screenWidth/3-40,2);
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
    manger = [NextManger shareInstance];
    manger.keyword = manger.userId;
    [manger loadData:RequestOfgetusergoodsrecordpagelistUserID];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"getusergoodsrecordpagelist" object:nil];
}
- (void)reloadDataAction
{
    [self.tableView reloadData];
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
                return cellCount;
            }
            else
            {
                return manger.m_baseLists.count;
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
            return titles.count;
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
                return 45;
            }
            else
            {
                return 200;
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
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section // 返回组名
//{
//    if (self.tableViewTag == 0) {
//        if (section == 1) {
//            return @"我的成果";
//        }
//    }
//    return nil;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.tableViewTag == 0)
    {
        if (section == 1) {
            return 30;
        }
    }
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tableViewTag == 0) {
        if (section == 1) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
            v.backgroundColor = [UIColor whiteColor];
            UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, ScreenWidth, 30)];
            l.text = @"我的成果";
            l.font = [UIFont systemFontOfSize:17];
//            l.textAlignment = kCTTextAlignmentCenter;
            l.textColor = [UIColor blackColor];
            [v addSubview:l];
            return v;
        }
        return nil;
    }

    return nil;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *infierCell = @"cell";
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    switch (self.tableViewTag) {
        case 0:
        {
            if (indexPath.section == 0)
            {

                if (indexPath.row == cellCount-1) {
                    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    addBtn.frame = CGRectMake(10, 5, ScreenWidth-20, 30);
                    addBtn.backgroundColor = [UIColor whiteColor];
                    addBtn.selected = isSelet;
                    addBtn.titleLabel.font = [UIFont systemFontOfSize:13];
                    [addBtn setTitleColor:RGB(179, 179, 179) forState:UIControlStateNormal];
                    [addBtn setTitle:@"展开" forState:UIControlStateNormal];
                    [addBtn setTitle:@"收起" forState:UIControlStateSelected];
                    [addBtn addTarget:self action:@selector(addInfoAction:) forControlEvents:UIControlEventTouchDown];
                    [cell.contentView addSubview:addBtn];

                }
                NSArray *cellTitles = @[@"地    址",@"姓    名",@"性    别",@"注册日期",@" "];
                UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth*0.28, 2, 150, 40)];
                textfield.font = [UIFont systemFontOfSize:13];
                [KeyboardToolBar registerKeyboardToolBar:textfield];
                if (cellCount == 5)
                {
                    if (indexPath.row != 4)
                    {
                        datas = @[manger.userAddress,manger.userC_Name,@"男",manger.createTime];
                        textfield.text = datas[indexPath.row];
                        [textfield setEnabled:YES];
                        [cell.contentView addSubview:textfield];
                        cell.textLabel.text = cellTitles[indexPath.row];
                    }
                    else
                    {
                        cell.textLabel.text = cellTitles[indexPath.row];
                    }
                    
                }
                else
                {
                    NSArray *datas2 = @[manger.userAddress,@" "];
                    textfield.text = datas2[indexPath.row];
                    [textfield setEnabled:NO];
                    [cell.contentView addSubview:textfield];
                    cell.textLabel.text = cellTitles[indexPath.row];
                }
                return cell;
            }
            else
            {
                HomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBaseCell"];
                ProjectModel *model = manger.m_baseLists[indexPath.row];
                cell.nameLab.text = model.baseName;
                cell.conetLab.text = model.baseCom;
                cell.subConlab.text = model.baseTime;
                [cell.nameImg sd_setImageWithURL:[NSURL URLWithString:manger.userPhoto]];
                ////        if (model.baseImg.length == 0)
                ////        {
                ////            cell.nameImg.image = [UIImage imageNamed:@"testUserImg"];
                ////        }
                ////        else
                ////        {
                //            [cell.nameImg sd_setImageWithURL:[NSURL URLWithString:model.baseImg]];
                ////        }
                for (int i = 0; i < model.baseImgLists.count; i++)
                {
                    UIImageView *image = (UIImageView *)[cell viewWithTag:505 + i];
                    image.tag = 505 + i;
                    [image sd_setImageWithURL:[NSURL URLWithString:model.baseImgLists[i]]];
                }
                cell.selectionStyle = UITableViewCellAccessoryNone;
                return cell;
            }

        }
            break;
        case 1:
        {
//            static NSString *infierCell = @"cell";
//            UITableViewCell *cell = nil;
//            if (!cell)
//            {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell];
//                
//            }
            NSArray *titles = @[@"基地植物",@"基地人物星人图"];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",titles[indexPath.row ]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
//            static NSString *infierCell = @"cell";
//            UITableViewCell *cell = nil;
//            if (!cell)
//            {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell];
//            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [NSString stringWithFormat:@"%@",titles[indexPath.row ]];
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
            if (indexPath.row == 0) {
                MyComListController *subVC = [[MyComListController alloc] init];
                subVC.hidesBottomBarWhenPushed = YES;
                subVC.title = @"我的评论";
                [self.navigationController pushViewController:subVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                ShopController *subVC = [[ShopController alloc] init];
                subVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:subVC animated:YES];
                
            }
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
#pragma mark - btnAction
- (void)addInfoAction:(UIButton *)btn
{
    isSelet = !isSelet;
    if (isSelet) {
        cellCount = 5;
        [self.tableView reloadData];
        //一个section刷新
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
//        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        NSLog(@"展开");
    }
    else
    {
        cellCount = 2;
        [self.tableView reloadData];
        //一个section刷新
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
//        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        NSLog(@"收起");
    }

}
- (void)addMyBase
{
    NSLog(@"添加我的基地");
    MyBaseOrPlantListController *sub = [[MyBaseOrPlantListController alloc] init];
    [self.navigationController pushViewController:sub animated:YES];

}
@end
