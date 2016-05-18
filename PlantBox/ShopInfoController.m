//
//  ShopInfoController.m
//  PlantBox
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "ShopInfoController.h"
//#import "ShopCarNextMangerModel.h"
#import "OrderController.h"
#import "ShopInfoCell.h"
#import "ShopImgCell.h"
#import "NextManger.h"
#import "ProjectModel.h"
#import "webView/WebModel.h"
#import "WebViewController.h"
#import "UIImageView+WebCache.h"
//#import "ShopCarAdvModel.h"

//#define URL_AFWorking(shopID) [NSString stringWithFormat:@"http://app.360kad.com/Product/GetProductDetailById?kclientid=62a806ad296a30b6845b193486ab3aad&kuserid=1254695200&kzone=homeview&productId=%@&utm_idfa=3D682E5B-5293-553B-ABA1-2D154135AGC8&utm_medium=iOS&utm_ot=10&utm_source=AppStore&utm_ver=3.4.1",shopID]
@interface ShopInfoController ()<UITableViewDataSource,UITableViewDelegate>
{
    NextManger *manger;
    int count;
    NSArray *imgs;
    BOOL isCollect;
    NSString *shopName;
    NSString *shopImg;
    NSString *shopPrice;
    
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *titles;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *producerName;

@end

@implementation ShopInfoController
- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *shopID = [user objectForKey:@"id"];
    self.navigationItem.title = @"商品信息";
    //    NSLog(@"shopID - %@",URL_AFWorking(shopID));
    
//    ShopCarNextMangerModel *model = [[ShopCarNextMangerModel shareShopCarData]initWithURL:URL_AFWorking(shopID)];
//    model = nil;
//    
    manger = [NextManger shareInstance];
    manger.projectID = self.shopID;
    [manger loadData:RequestOfGetproduct];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refrshData:) name:@"getproduct" object:nil];
        [self _initTableView];
}

- (void)refrshData:(NSNotification *)obj{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    self.price = [user objectForKey:@"Price"];
//    self.titles = [user objectForKey:@"title"];
//    self.producerName = [user objectForKey:@"producerName"];
//    NSLog(@"%@",obj.object);
    imgs = obj.object;
    [self.tableView reloadData];

}
- (void)_initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -69-60) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ShopInfoCell" bundle:nil]  forCellReuseIdentifier:@"ShopInfoCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ShopImgCell" bundle:nil]  forCellReuseIdentifier:@"ShopImgCell"];
    
//    self.tableView.estimatedRowHeight = 400;
    
    UIView *shopV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 115, ScreenWidth, 60)];
    shopV.backgroundColor = [UIColor whiteColor];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imgV.image = [UIImage imageNamed:@"kadzixun.jpg"];
    [shopV addSubview:imgV];
    
    UIImageView *imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake( 50,0, 50, 50)];
    imgV2.image = [UIImage imageNamed:@"shopInfoFenxiang.jpg"];
    [shopV addSubview:imgV2];
    
//    UIImageView *imgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 200,0, 190, 50)];
//    imgV3.image = [UIImage imageNamed:@"addshop"];
//    [shopV addSubview:imgV3];
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(ScreenWidth - 180,0, 170, 40);
    buyBtn.layer.cornerRadius = 2;
    buyBtn.backgroundColor = [UIColor orangeColor];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(alerCtl) forControlEvents:UIControlEventTouchDown];
    [shopV addSubview:buyBtn];
    
    [self.view addSubview:shopV];
    
}
- (void)alerCtl{
//    UIAlertController *errorAlertV = [UIAlertController alertControllerWithTitle:@"抱歉" message:@"当前版本暂不支持该操作" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
////        [self.navigationController popToRootViewControllerAnimated:YES];
//    }];
//    [errorAlertV addAction:cancel];
//    [self presentViewController:errorAlertV animated:YES completion:nil];
    OrderController *subVC = [[OrderController alloc] init];
    subVC.orderCount = count;
    subVC.orderImg = shopImg;
    subVC.orderName = shopName;
    subVC.orderPrice = shopPrice;
    subVC.shopID = self.shopID;
    [self.navigationController pushViewController:subVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController.navigationBar setTranslucent:NO];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return imgs.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 420;
    }
    else
    {
        return 150;

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0)
    {
        ProjectModel *model = manger.m_ProductShopInfoLists[indexPath.row];
        ShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopInfoCell"];
        cell.producrName.text = model.shopInfoListName;
        shopName = cell.producrName.text;
        cell.title.text = model.shopInfoListNotice;
        cell.bayTotal.text = model.shopInfoListTotalBuy;
        cell.price.text = [NSString stringWithFormat:@"价格:%@",model.shopinfoListPrice];
        shopPrice = model.shopinfoListPrice;
        cell.countLab.text = [NSString stringWithFormat:@"%d",count];
        shopImg = imgs[0];
        [cell.cellImg sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
        cell.selectionStyle = UITableViewCellStyleDefault;
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchDown];
        [cell.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchDown];
        [cell.collectionBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchDown];
        [cell.pushBK addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchDown];
        
        return cell;
    }
    ShopImgCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ShopImgCell"];
    [cell.cellImg sd_setImageWithURL:[NSURL URLWithString:imgs[indexPath.row]]];
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell; 
    
}

- (void)pushAction
{
            WebModel *model = [[WebModel alloc] initWithUrl:[NSString stringWithFormat:@"http://plantbox.meidp.com/Mobi/Home/NoticeDetail?UserId=%@&id=%@",manger.userId,self.shopID]];
            WebViewController *SVC = [[WebViewController alloc] init];
            SVC.title = @"植物百科";
            SVC.hidesBottomBarWhenPushed = YES;
            [SVC setModel:model];
            [self.navigationController pushViewController:SVC animated:YES];
}
- (void)collectionAction:(UIButton *)btn
{
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"collect_03"]forState:UIControlStateSelected];
        btn.selected = !btn.selected;
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"unCollect.jpg"]forState:UIControlStateNormal];
        btn.selected = !btn.selected;
    }
}
- (void)deleteBtnAction
{
    if (count == 0) {
        return;
    }
    count--;

    [self.tableView reloadData];
}
- (void)addBtnAction
{
    count++;
    [self.tableView reloadData];
}
@end
