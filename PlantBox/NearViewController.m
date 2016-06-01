//
//  NearViewController.m
//  PlantBox
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "NearViewController.h"
#import "NearMapController.h"
#import "UserBaseController.h"
#import "KeyboardToolBar/KeyboardToolBar.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "NextManger.h"
#import "ProjectModel.h"
//#import "HomeCollectionViewCell.h"
#import "NearCell.h"
#import "UIImageView+WebCache.h"
@interface NearViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    BMKMapView* _mapView;
    BMKLocationService *_locService;
    NextManger *manger;
    CLLocationCoordinate2D _touchMapCoordinate;  //  点击后那一点的经纬度
    NSArray *datas;
    UITextField *seachTextField;
}
@property (nonatomic, strong) NSMutableArray *m_titleDatas;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation NearViewController
// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"附近";
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    
    UIView *mapBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    [self.view addSubview:mapBgView];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, 200)];
//    self.view = _mapView;
    [mapBgView addSubview:_mapView];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
    UIButton *meassageBut = ({
        UIButton *meassageBut = [UIButton buttonWithType:UIButtonTypeCustom];
        meassageBut.frame = CGRectMake(0, 0, 23, 8);
        [meassageBut addTarget:self action:@selector(showActionsheet) forControlEvents:UIControlEventTouchDown];
        [meassageBut setImage:[UIImage imageNamed:@"附近"]forState:UIControlStateNormal];
        meassageBut;
    });
    
    UIBarButtonItem *rBtn = [[UIBarButtonItem alloc] initWithCustomView:meassageBut];
    self.navigationItem.rightBarButtonItem = rBtn;

    
    [self setTableView];
    
}
- (void) viewDidAppear:(BOOL)animated
{
    
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    if(_mapView.isUserLocationVisible == YES)
    {
        return;
    }
    
    
    CLLocationCoordinate2D theCoordinate;
    CLLocationCoordinate2D theCenter;
    
    theCoordinate.latitude = userLocation.location.coordinate.latitude;
    theCoordinate.longitude= userLocation.location.coordinate.longitude;
    
    
    BMKCoordinateRegion theRegin;
    theCenter.latitude =userLocation.location.coordinate.latitude;
    theCenter.longitude = userLocation.location.coordinate.longitude;
    theRegin.center=theCenter;
    
    BMKCoordinateSpan theSpan;
    theSpan.latitudeDelta = 0.1;
    theSpan.longitudeDelta = 0.1;
    theRegin.span = theSpan;
    
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    annotation.coordinate = coor;
    annotation.title = @"我在这里";
    [_mapView addAnnotation:annotation];
    
    
    [_mapView setRegion:theRegin animated:YES];
    [_mapView regionThatFits:theRegin];
    [_locService stopUserLocationService];
    
    manger = [NextManger shareInstance];
    manger.nearLat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    manger.nearLon = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    [manger loadData:RequestOfgetusergoodnear];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"getusergoodnear" object:nil];
    
}
- (void)refreshData
{
//    NSLog(@"%ld",manger.nearDatas.count);
    datas = manger.nearDatas;
    [self.m_titleDatas removeAllObjects];
    if (manger.nearDatas.count != 0) {
        for (int i = 0;i < manger.nearDatas.count; i++)
        {
//            NSLog(@"%f",[manger.nearDatas[10][0] doubleValue]);
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [manger.nearDatas[i][0] doubleValue];
            coor.longitude = [manger.nearDatas[i][1] doubleValue];
            annotation.coordinate = coor;
            ProjectModel *model = manger.m_nears[i];
            annotation.title =[NSString stringWithFormat:@"%@ %@",model.nearName,model.nearDistance];
            [_mapView addAnnotation:annotation];
            
            if (self.m_titleDatas.count == 0) {
                self.m_titleDatas = [[NSMutableArray alloc] initWithCapacity:0];
            }
            [self.m_titleDatas addObject:annotation.title];
        }
    }
    
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 创建 UICollectionView
- (void)setTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 208, ScreenWidth, ScreenHeight -208-118) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    
//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    gestureRecognizer.cancelsTouchesInView = NO;
//    
//    [_tableView addGestureRecognizer:gestureRecognizer];
//    //
//    //    self.tableView.estimatedRowHeight = 100;
    [self registerNib];
}

#pragma mark - 搜索
- (void)seachAction
{
//    manger = [NextManger shareInstance];
//    manger.keyword = seachTextField.text;
//    [manger loadData:RequestOfGetproductlist];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getproductlist" object:nil];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"NearCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
#pragma mark - tableviewdelegete
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (manger.m_nears.count == 0) {
        return 0;
    }
    return manger.m_nears.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *infierCell = @"cell";
//    UITableViewCell *cell = nil;
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infierCell];
//    }
    ProjectModel *model = manger.m_nears[indexPath.row];
    NearCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearCell"];
    if ([model.nearImg isEqualToString:@"kong"])
    {
        cell.img.image = [UIImage imageNamed:@"1138bb6d96b8709ba6028a89c95006bc.jpg"];
    }
    else
    {
        [cell.img sd_setImageWithURL:[NSURL URLWithString:model.nearImg]];
    }
    cell.nameLab.text = model.nearName;
    cell.disLab.text = model.nearDistance;
    cell.friendLab.text = [NSString stringWithFormat:@"位置: %@",model.nearAddress];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = [model.nearID integerValue];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UserBaseController *subV = [[UserBaseController alloc] init];
    subV.userID = [NSString stringWithFormat:@"%ld",cell.tag];
    subV.userName = cell.nameLab.text;
    subV.userTime = cell.disLab.text;
    subV.userAddress = cell.friendLab.text;
    subV.userImg = cell.img.image;
    subV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subV animated:YES];
}
#pragma mark-
- (void)showActionsheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"身边", @"广场",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",buttonIndex);
//
    if (buttonIndex == 0)
    {
        NearMapController *subVC = [[NearMapController alloc] init];
        subVC.hidesBottomBarWhenPushed = YES;
        subVC.title = @"身边";
        subVC.titles = self.m_titleDatas;
        subVC.datas = datas;
        [self.navigationController pushViewController:subVC animated:YES];
    }
    else if(buttonIndex == 1)
    {
        NearMapController *subVC = [[NearMapController alloc] init];
        subVC.hidesBottomBarWhenPushed = YES;
        subVC.title = @"广场";
        subVC.titles = self.m_titleDatas;
        subVC.datas = datas;
        [self.navigationController pushViewController:subVC animated:YES];
    }
//    else if(buttonIndex == 2) {
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
