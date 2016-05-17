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
@interface OrderController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    NextManger *manger;
}
@property (nonatomic, strong) UIView *closeV;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSLog(@"%@ %@ %d %@",self.orderImg,self.orderName,self.orderCount,self.orderPrice);
    [self drawTableView];
    
    UIView *shopV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 115, ScreenWidth, 60)];
    shopV.backgroundColor = [UIColor whiteColor];
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 80, 50)];
    countLab.text = [NSString stringWithFormat:@"合计 :￥%d",[self.orderPrice intValue]*self.orderCount];
    countLab.font = [UIFont systemFontOfSize:15];
    [shopV addSubview:countLab];

    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(ScreenWidth - 150,15, 140, 30);
    buyBtn.layer.cornerRadius = 2;
    buyBtn.backgroundColor = [UIColor orangeColor];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buybuybuy) forControlEvents:UIControlEventTouchDown];
    [shopV addSubview:buyBtn];
    
    [self.view addSubview:shopV];
    
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
    
    NSArray *registerNibs = @[@"OrderCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }

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
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.orderImg]];
    cell.textLabel.text = self.orderName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"数量:%d",self.orderCount];
    
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
    _closeV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-49-258, ScreenWidth, 40)];
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
    manger.orderPEId = @"1";
    manger.orderProID = self.shopID;
    manger.orderQty = [NSString stringWithFormat:@"%d",self.orderCount];
    manger.orderPrice = self.orderPrice;
//    NSLog(@"%@%@%@%@",manger.orderName,manger.orderMobile,manger.orderAddress,manger.orderQty);
    [manger loadData:RequestOforderSaveorder];
}

@end
