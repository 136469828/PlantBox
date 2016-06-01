//
//  AQCollectionVC.m
//  Picture
//
//  Created by aiqing on 16/1/10.
//  Copyright © 2016年 aiqing. All rights reserved.
//

#import "AQCollectionVC.h"
#import "AQCollectionViewCell.h"
#import "AQTool.h"
#import "UIImageView+WebCache.h"
#import "myHeadView.h"
#import "HomeBaseComCell.h"
#import "UIImageView+WebCache.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "UIImageView+WebCache.h"

@interface AQCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
{
    NextManger *manger;
    CGFloat l_hight;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) myHeadView *headerView;
@end

@implementation AQCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 加载数据
//    manger = [NextManger shareInstance];
//    manger.keyword = self.userID;
//    [manger loadData:RequestOfgetusergoodsrecordpagelistUserID];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getusergoodsrecordpagelist" object:nil];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableView];
    manger = [NextManger shareInstance];
//    NSLog(@"%@",self.fkID);
    manger.keyword = self.fkID;
    [manger loadData:RequestOfuserGetcommentlist];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getcommentlist" object:nil];
}
- (void)reloadDatas
{
    [self.tableView reloadData];
    [self.collectionView reloadData];
}
#pragma mark -
- (void)setTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight -90) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 70;
    self.tableView.tableHeaderView = [self setTopView];
    [self.view addSubview:self.tableView];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self registerNib];
}
#pragma mark - 注册Cell

- (void)registerNib{
    NSArray *registerNibs = @[@"HomeBaseComCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
#pragma mark - 
- (UIView *)setTopView  // 返回一个UIView作为头视图
{
    UIView *topV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.3)];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 7, 1,7);
    flowLayout.itemSize =  CGSizeMake(ScreenWidth/3-13 ,ScreenWidth/3-13);
    flowLayout.minimumLineSpacing = 1;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //cell注册
    [_collectionView registerClass:[myHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeadView"];             //注册头视图
    [_collectionView registerClass:[AQCollectionViewCell class] forCellWithReuseIdentifier:@"JDYCollectionViewCell"];
    _collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,ScreenHeight*0.3);
    [topV addSubview: _collectionView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(8, topV.bounds.size.height - 2, ScreenWidth-16, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [topV addSubview:line];

    return topV;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (manger.m_comLists.count == 0) {
        return 1;
    }
    else
    {
        return manger.m_comLists.count;
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (manger.m_comLists.count == 0) {
        static NSString *allCell = @"cell";
        UITableViewCell *cell = nil;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCell];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = @"暂无评论!";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        return cell;
    }
    else
    {
        ProjectModel *model = manger.m_comLists[indexPath.row];
        HomeBaseComCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBaseComCell"];
        [cell.img sd_setImageWithURL:[NSURL URLWithString:model.comImg]];
        cell.timeLab.text = model.comTime;
        cell.titleLab.text = model.comment;
        cell.nameLab.text = model.comName;
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (manger.m_baseLists.count == 0)
//    {
//        return 0;
//    }
//    {
//        return manger.m_baseLists.count;
//    }
    return _smallUrlArray.count;
}
//
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {       //头视图
        _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeadView" forIndexPath:indexPath];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
//        img.backgroundColor = [UIColor redColor];
        img.layer.cornerRadius = 25;
        img.image = self.heardimg;
        [_headerView addSubview:img];
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(75,0, ScreenWidth-85, 20)];
        l.text = self.nameLabstr;
        l.font = [UIFont systemFontOfSize:15];
//        l.backgroundColor = [UIColor lightGrayColor];
        [_headerView addSubview:l];
        
        UILabel *ssl = [[UILabel alloc] initWithFrame:CGRectMake(75,25, ScreenWidth-85, 20)];
        ssl.text = self.subconetLabstr;
        ssl.font = [UIFont systemFontOfSize:12];
        ssl.numberOfLines = 0;
        [_headerView addSubview:ssl];
        
//        UILabel *sl = [[UILabel alloc] initWithFrame:CGRectMake(10,50, ScreenWidth-30, 20)];
//        sl.text = self.conetLabstr;
//        sl.font = [UIFont systemFontOfSize:13];
//        sl.numberOfLines = 0;
//        [_headerView addSubview:sl];
        //准备工作
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont systemFontOfSize:13];
        NSString *str = self.conetLabstr;
        textLabel.text = str;
//        textLabel.backgroundColor = [UIColor redColor];
        textLabel.numberOfLines = 0;//根据最大行数需求来设置
        textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(ScreenWidth-30, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        textLabel.frame = CGRectMake(10,55, ScreenWidth-20, expectSize.height);
        NSLog(@"expectSize.height %f",expectSize.height);
        l_hight = expectSize.height;
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults removeObjectForKey:@"l_hight"];
//        [userDefaults setObject:[NSString stringWithFormat:@"%f",expectSize.height] forKey:@"l_hight"];
        [_headerView addSubview:textLabel];
        
        reusableView = _headerView;
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    l_hight = [[userDefaults objectForKey:@"l_hight"] floatValue];
    NSLog(@"l_hight%f",l_hight);
//    [userDefaults removeObjectForKey:@"l_hight"];
    return CGSizeMake(ScreenWidth,60+l_hight);
}
//定义展示的Section的个数
-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AQCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JDYCollectionViewCell" forIndexPath:indexPath];
    if (cell)
    {
        cell.imageView.image = _smallUrlArray[indexPath.row];
        cell.imageView.tag = indexPath.row + 100;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.clipsToBounds = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView *myimageView = (UIImageView*)[self.view viewWithTag:indexPath.row + 100];
    
    [AQTool showImage:myimageView];//调用方法
    
    
}

- (void)btnClick
{
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
        [_collectionView reloadData];
    }];
}


@end
