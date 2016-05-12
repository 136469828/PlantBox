//
//  MineViewController.m
//  PlantBox
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "MineViewController.h"
#import "MyBaseViewController.h"
#import "TheActivityViewController.h"
@interface MineViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UIButton *imgBtn;
}
@property (nonatomic,strong) UIImageView *userImage;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self drawTopview];
    NSArray *titles = @[@"我的基地", @"我的活动", @"我的收藏", @"我的订单", @"活动专区", @"我的分享", @"联系客服", @"我的钱包",@"设置"];
    NSArray *imageNames = @[@"mine01",@"mine02",@"mine03",@"mine04",@"mine05",@"mine06",@"mine07",@"mine08",@"mine09"];
    
    [self drawHoneViewWithAppviewW:ScreenWidth/3 AppviewH:(ScreenHeight-ScreenHeight*0.34-19-29)/3 Totalloc:3 Count:9 ImageArray:imageNames TitleArray:titles];
    
}
- (void)drawTopview
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.37-19)];
    topView.backgroundColor = RGB(7, 115, 226);
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 19, ScreenWidth, 44)];
//    titleLab.backgroundColor = [UIColor redColor];
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = @"个人中心";
    [topView addSubview:titleLab];
    
    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2, titleLab.bounds.origin.y + 60, (ScreenHeight-ScreenHeight*0.38-19-29)/3, (ScreenHeight-ScreenHeight*0.38-19-29)/3)];
    _userImage.image = [UIImage imageNamed:@"testUserImg"];
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = ((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2;
    [topView addSubview:_userImage];

    imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBtn.frame = CGRectMake(ScreenWidth/2-((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2, titleLab.bounds.origin.y + 60, (ScreenHeight-ScreenHeight*0.38-19-29)/3, (ScreenHeight-ScreenHeight*0.38-19-29)/3);
//    imgBtn.backgroundColor = [UIColor redColor];
    imgBtn.layer.borderColor = RGB(86, 168, 256).CGColor;
    imgBtn.layer.borderWidth = 1;
    imgBtn.layer.cornerRadius = ((ScreenHeight-ScreenHeight*0.38-19-29)/3)/2;
    imgBtn.layer.masksToBounds = YES;
    imgBtn.backgroundColor = [UIColor clearColor];
//    if (_userImage.image == nil)
//    {
//        [imgBtn setImage:[UIImage imageNamed:@"testUserImg"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [imgBtn setImage:_userImage.image forState:UIControlStateNormal];
//    }
    [imgBtn addTarget:self action:@selector(changeHeadViews) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:imgBtn];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, topView.bounds.size.height-35, ScreenWidth, 30)];
//    nameLab.backgroundColor = [UIColor redColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont systemFontOfSize:15];
    nameLab.text = @"用户名字";
    [topView addSubview:nameLab];
    
    [self.view addSubview:topView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:YES animated:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [super.navigationController setNavigationBarHidden:NO animated:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 创建九宫格
- (void)drawHoneViewWithAppviewW:(CGFloat)appviewWith AppviewH:(CGFloat)appviewHeght Totalloc:(int)totalloc Count:(int)count ImageArray:(NSArray *)images TitleArray:(NSArray *)titles{
    //    三列
    //    int totalloc=3;
    //    CGFloat appvieww=80;
    //    CGFloat appviewh=100;
    CGFloat margin=([UIScreen mainScreen].bounds.size.width-totalloc*appviewWith)/(totalloc+1);
    //    int count = 8;
    for (int i=0; i<count; i++) {
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        
        CGFloat appviewx=margin+(appviewWith + .5)*loc;
        CGFloat appviewy=margin+(appviewHeght + .5)*row;
        
        //创建uiview控件
        UIView *appview=[[UIView alloc]initWithFrame:CGRectMake(appviewx,appviewy+ScreenHeight*0.37-19, appviewWith, appviewHeght)];
//        appview.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:appview];
        
        // 创建按钮
        UIButton *bTn = [UIButton buttonWithType:UIButtonTypeCustom];
        bTn.frame = CGRectMake(0, 0, appviewWith,appviewHeght);
        [bTn addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchDown];
        [bTn setBackgroundColor:[UIColor whiteColor]];
        bTn.tag = 1200 + i;
        [appview addSubview:bTn];
        
        //创建uiview控件中的子视图
        UIImageView *appimageview=[[UIImageView alloc]initWithFrame:CGRectMake(appview.bounds.size.width/2 -  appviewHeght/3,10, appviewHeght/1.5,appviewHeght/1.5)];
        UIImage *appimage=[UIImage imageNamed:images[i]];
        appimageview.image=appimage;
//        appimageview.backgroundColor = [UIColor lightGrayColor];
        [appimageview setContentMode:UIViewContentModeScaleAspectFit];
        // NSLog(@"%@",self.apps[i][@"icon"]);
        [appview addSubview:appimageview];
        
        //创建文本标签
        UILabel *applable=[[UILabel alloc]initWithFrame:CGRectMake(0, appviewHeght-30, appview.bounds.size.width, 20)];
//                applable.backgroundColor = [UIColor redColor];
        [applable setText:titles[i]];
        [applable setTextAlignment:NSTextAlignmentCenter];
        [applable setFont:[UIFont systemFontOfSize:14.0]];
        [appview addSubview:applable];
        
    }
    
}
#pragma  mark 更改头像方法
// 更改头像
- (void)changeHeadViews{
//    [self closeKeyBorads];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从本地中选取", nil];
    [actionSheet showInView:self.view];
}
// 实现代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            // 拍照
            [self visitCamers];
            break;
        case 1:
            // 打开相册
            [self visitPhotos];
            break;
            
        default:
            break;
    }
}
// 访问摄像头
- (void)visitCamers{
    UIImagePickerController *pickerCamerController = [[UIImagePickerController alloc] init];
    pickerCamerController.delegate = self;
    BOOL isAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear|
                        UIImagePickerControllerCameraDeviceFront];
    if (isAvailable)
    {
        pickerCamerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSLog(@"打开相机成功");
        [self presentViewController:pickerCamerController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *camerAlert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"你的设备不支持摄像头" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [camerAlert show];
    }
}

// 访问相册
- (void)visitPhotos{
    UIImagePickerController *photoPickerController = [[UIImagePickerController alloc] init];
    photoPickerController.delegate = self;
    photoPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:photoPickerController animated:YES completion:nil];
}
// 读取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *userImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%@",info);
    _userImage.image = userImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 从相册返回
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)clickOn:(UIButton *)btn
{
    NSLog(@"click");
    switch (btn.tag) {
        case 1200:
        {
            MyBaseViewController *myBase = [[MyBaseViewController alloc] init];
            myBase.hidesBottomBarWhenPushed = YES;
            myBase.title = @"我的基地";
            [self.navigationController pushViewController:myBase animated:YES];
        }
            break;
        case 1204:
        {
            TheActivityViewController *myBase = [[TheActivityViewController alloc] init];
            myBase.hidesBottomBarWhenPushed = YES;
            myBase.title = @"活动专区";
            [self.navigationController pushViewController:myBase animated:YES];
        }
            break;
            
        default:
            break;
    }
}
@end
