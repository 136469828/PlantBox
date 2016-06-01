//
//  OrderController.m
//  PlantBox
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "OrderController.h"
#import "OrderCell.h"
#import "AddressController.h"
#import "UIImageView+WebCache.h"
#import "KeyboardToolBar/KeyboardToolBar.h"
#import "NextManger.h"
#import "WebModel.h"
#import "WebViewController.h"
@interface OrderController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    NextManger *manger;
}
@property (nonatomic, strong) UIView *closeV;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OrderController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSLog(@"%@ %@ %d %@",self.orderImg,self.orderName,self.orderCount,self.orderPrice);
    [self drawTableView];
    
    UIView *shopV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 115, ScreenWidth, 60)];
    shopV.backgroundColor = [UIColor whiteColor];
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    countLab.text = [NSString stringWithFormat:@"合计 :￥%.2f",[self.orderPrice doubleValue]*self.orderCount];
    NSLog(@"%@",countLab.text);
    countLab.font = [UIFont systemFontOfSize:15];
    [shopV addSubview:countLab];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(ScreenWidth - (ScreenWidth/2-60)-10,0, ScreenWidth/2-60, 40);
    buyBtn.layer.cornerRadius = 2;
    buyBtn.backgroundColor = [UIColor orangeColor];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buybuybuy) forControlEvents:UIControlEventTouchDown];
    [shopV addSubview:buyBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushPay:) name:@"orderSaveorder" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedDidappear:) name:UIKeyboardWillHideNotification object:nil];
    [self.view addSubview:shopV];
    
}
- (void)pushPay:(NSNotification *)obj
{
    WebModel *model = [[WebModel alloc] initWithUrl:[NSString stringWithFormat:@"http://plantbox.meidp.com/Mobi/Pay/PayChoose/%@",manger.orderID]];
    WebViewController *SVC = [[WebViewController alloc] init];
    SVC.title = @"支付";
    SVC.hidesBottomBarWhenPushed = YES;
    [SVC setModel:model];
    [self.navigationController pushViewController:SVC animated:YES];
    
}
- (void)keyboaedDidShow:(NSNotification *)notif{
    //        NSLog(@"键盘出现 %@",notif);
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%d",height);
    
}
- (void)keyboaedDidappear:(NSNotification *)notif{
    NSLog(@"键盘消失");
    [_closeV removeFromSuperview];
    _tableView.frame = CGRectMake(0,0, SCREEN_WIDTH, ScreenHeight - 69);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-69) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.estimatedRowHeight = 180;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [_tableView addGestureRecognizer:gestureRecognizer];
    
    NSArray *registerNibs = @[@"OrderCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
-(void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}
#pragma  mark - tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 180;
    }
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
        NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
        cell.addreText.text = [user objectForKey:@"ShippingAddress"];
        cell.addreText.tag = 666;
        cell.addreText.delegate = self;
        cell.phoneTF.text = [NextManger shareInstance].userMobile;
        cell.phoneTF.delegate= self;
        cell.phoneTF.tag = 777;
        cell.nameTF.text = [NextManger shareInstance].userC_Name;
        cell.nameTF.delegate = self;
        cell.nameTF.tag = 888;
        [KeyboardToolBar registerKeyboardToolBar:cell.nameTF];
        [KeyboardToolBar registerKeyboardToolBar:cell.phoneTF];
        return cell;
    }
    static NSString *infierCell = @"cell";
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:infierCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    cell.imageView.image = [UIImage imageNamed:self.orderImg];
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 80-16, 80-16)];
    [imgv sd_setImageWithURL:[NSURL URLWithString:self.orderImg]];
    [cell.contentView addSubview:imgv];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(85, 8, ScreenWidth-90, 40)];
    l.numberOfLines = 0;
    l.text = self.orderName;
    l.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:l];
    
    UILabel *sl = [[UILabel alloc] initWithFrame:CGRectMake(85, 40, ScreenWidth-90, 40)];
    sl.numberOfLines = 1;
    sl.font = [UIFont systemFontOfSize:13];
    sl.text = [NSString stringWithFormat:@"数量:%d",self.orderCount];
    [cell.contentView addSubview:sl];
    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.orderImg]];
//    cell.textLabel.text = self.orderName;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"数量:%d",self.orderCount];
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        AddressController *subVC = [[AddressController alloc] init];
//        [self.navigationController pushViewController:subVC animated:YES];
//    }
//}
#pragma mark - textFileddelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //  667 - 313
    UITextView *txv = (UITextView *)[self.view viewWithTag:666];
    _closeV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-69-258, ScreenWidth, 40)];
    _closeV.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *colseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colseBtn.frame = CGRectMake(ScreenWidth-45, 5, 40, 25);
    [colseBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [colseBtn addTarget:self action:@selector(leaveEditMode) forControlEvents:UIControlEventTouchDown];
    [_closeV addSubview:colseBtn];
    [self.view addSubview:_closeV];
    
    //    [UITableView animateWithDuration:0.25 animations:^{
    //        _tableView.frame = CGRectMake(0, -238+30+59, ScreenWidth, ScreenHeight);
    //    }];
    //    txv.text=@"";
    txv.textColor = [UIColor blackColor];
    return YES;
    
}
- (void)leaveEditMode {
    UITextView *txv = (UITextView *)[self.view viewWithTag:666];
    [txv resignFirstResponder];
    [_closeV removeFromSuperview];
    _closeV = nil;
}
- (void)buybuybuy
{
    manger = [NextManger shareInstance];
    UITextView *txv = (UITextView *)[self.view viewWithTag:666];
    UITextField *nameTF = (UITextField *)[self.view viewWithTag:888];
    UITextField *phone = (UITextField *)[self.view viewWithTag:777];
    manger.orderName = nameTF.text;
    manger.orderMobile = phone.text;
    manger.orderAddress = txv.text;
//    manger.orderPEId = @"1"; // 产品型号ID
    NSLog(@"%@",self.shopID);
    manger.orderProID = self.shopID;
    manger.orderQty = [NSString stringWithFormat:@"%d",self.orderCount];
    manger.orderPrice = self.orderPrice;
    //    NSLog(@"%@%@%@%@",manger.orderName,manger.orderMobile,manger.orderAddress,manger.orderQty);
    [manger loadData:RequestOforderSaveorder];
    
    
}

@end
