//
//  ShopInfoCell.m
//  No.1 Pharmacy
//
//  Created by JCong on 15/12/14.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "ShopInfoCell.h"
//#import "ShopCarModel.h"
//#import "ShopScorllView.h"

@implementation ShopInfoCell
{
    BOOL isCollect;
    int count;
}
- (void)awakeFromNib {
//    _advScorll = [[ShopScorllView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
//    [self.topView addSubview:_advScorll];
    isCollect = NO;
    self.deleteBtn.layer.borderWidth = 1;
    self.addBtn.layer.borderWidth = 1;
    self.countLab.layer.borderWidth = 1;
    self.countLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.deleteBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.addBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.countLab.layer.cornerRadius = 2;
    self.addBtn.layer.cornerRadius = 2;
    self.deleteBtn.layer.cornerRadius = 2;
//    [self.deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchDown];
//    [self.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchDown];
    
}
//- (void)deleteBtnAction
//{
//    count--;
//}
//- (void)addBtnAction
//{
//    count++;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cklickBtn:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://13202601163"]]; // 打电话
//
//    // 1.创建本地推送通知
//    
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    
//    // 2.设置一些属性
//    
//    // 通知发出的时间(5秒后)
//    
//    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//    
//    // 设置时区（跟随手机的时区）
//    
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];
//    
//    // 音乐文件名
//    
//    localNotification.soundName = nil;
//    
//    // 通知的内容
//    
//    localNotification.alertBody = @"内容";
//    
//    // 锁屏界面显示的标题 如下面的写法将显示：滑动来查看内容   格式："滑动来" + 标题
//    
//    localNotification.alertAction = @"查看内容";
//    
//    // 设置app图标数字
//    
//    localNotification.applicationIconBadgeNumber = 10;
//    
//    // 设置通知的其他信息
//    
//    localNotification.userInfo = @{
//                                   
//                                   @"title" : @"好消息"
//                                   
//                                   };//可随意添加
//    
//    // 设置启动图片
//    
//    localNotification.alertLaunchImage = @"checkOrder1";
//    
//    // 设置重复发出通知的时间间隔
//    
//    //    localNotification.repeatInterval = NSCalendarUnitMinute;
//    
//    // 3.发通知
//    
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//    if (application.applicationState == UIApplicationStateActive) return;
//}
@end
