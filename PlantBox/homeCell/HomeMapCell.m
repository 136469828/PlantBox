//
//  HomeMapCell.m
//  PlantBox
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "HomeMapCell.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface HomeMapCell()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@end


@implementation HomeMapCell
{
    BMKMapView * _mapview;
    BMKLocationService *_locService;
    CLLocationCoordinate2D _touchMapCoordinate;  //  点击后那一点的经纬度
}
- (void)awakeFromNib {
    // Initialization code
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapview = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-16, _mapView.bounds.size.height-8)];
    [self.mapView addSubview: _mapview];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapview viewWillAppear];
    _mapview.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapview viewWillDisappear];
    _mapview.delegate = nil; // 不用时，置nil
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
    
    if(_mapview.isUserLocationVisible == YES)
    {
        return;
    }
    
    
    CLLocationCoordinate2D theCoordinate;
    CLLocationCoordinate2D theCenter;
    
    theCoordinate.latitude = userLocation.location.coordinate.latitude;
    theCoordinate.longitude= userLocation.location.coordinate.longitude;
    
     //将定位的点居中显示
    BMKCoordinateRegion theRegin;
    theCenter.latitude =userLocation.location.coordinate.latitude;
    theCenter.longitude = userLocation.location.coordinate.longitude;
    theRegin.center=theCenter;
   
    BMKCoordinateSpan theSpan;
    theSpan.latitudeDelta = 0.01;
    theSpan.longitudeDelta = 0.01;
    theRegin.span = theSpan;
    
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    double lat = userLocation.location.coordinate.latitude;
    double lon = userLocation.location.coordinate.longitude;
    [user setObject:[NSString stringWithFormat:@"%f",lat] forKey:@"userLat"];
    [user setObject:[NSString stringWithFormat:@"%f",lon]  forKey:@"userLon"];
    
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    annotation.coordinate = coor;
    annotation.title = @"我在这里";
    [_mapview addAnnotation:annotation];
    
    BMKGeoCodeSearch *_geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    _geoCodeSearch.delegate = self;
    //初始化逆地理编码类
    BMKReverseGeoCodeOption *reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    //需要逆地理编码的坐标位置
    reverseGeoCodeOption.reverseGeoPoint = coor;
    [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    
    [_mapview setRegion:theRegin animated:YES];
    [_mapview regionThatFits:theRegin];
    [_locService stopUserLocationService];
}
/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //BMKReverseGeoCodeResult是编码的结果，包括地理位置，道路名称，uid，城市名等信息
    if (error) {
        NSLog(@"%u",error);
    }
    else
    {
        NSLog(@"%@ 详细地址：%@%@",result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName);
//        NSString *cccc = [result.addressDetail.city substringToIndex:[result.addressDetail.city length] - 1];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:result.addressDetail.city forKey:@"city"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"city" object:nil];

        [user setObject:[NSString stringWithFormat:@"%@%@%@",result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName] forKey:@"ShippingAddress"];
    }
    
}

@end
