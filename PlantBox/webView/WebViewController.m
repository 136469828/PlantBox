//
//  SellViewController.m
//  No.1 Pharmacy
//
//  Created by JCong on 15/11/4.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "WebViewController.h"
#import "WebModel.h"
#import "MBProgressHUD.h"
#import <unistd.h>
@interface WebViewController ()<UIWebViewDelegate,MBProgressHUDDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebViewController
{
    NSString *URL_Web;
    
    MBProgressHUD *HUD;
    long long expectedLength;
    long long currentLength;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"webStar");
    // 设置导航默认标题的颜色及字体大小
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-69)];
//    _webView.backgroundColor = [UIColor whiteColor];
    // iOS中表示请求的类
//    NSLog(@"%@",URL_Web);
    NSURL *url = [NSURL URLWithString:URL_Web];
    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView.scalesPageToFit =YES;
    _webView.delegate =self;
    // 加载请求(c/s模式)
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
//    
//    //异步并发队列
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 1.子线程
//        
//        
//        // 2.回到主线程刷新
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            
//        });
//    });
    /*
     dispatch_async(dispatch_get_global_queue(0, 0), ^
     {
     [NSThread sleepForTimeInterval:0.1];
     dispatch_sync(dispatch_get_main_queue(), ^
     {
     [_webView loadRequest:request];
     HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
     [self.navigationController.view addSubview:HUD];
     
     HUD.delegate = self;
     HUD.labelText = @"Loading";
     
     [HUD show:YES];
     });
     });
     */

    NSLog(@"webEnd");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"Loading";

    [HUD show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    self.title = title;
    NSLog(@"完成了web加载");
    [HUD removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    UIAlertController *errorAlertV = [UIAlertController alertControllerWithTitle:@"抱歉" message:@"演示版本暂不支持该操作" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [errorAlertV addAction:cancel];
    [self presentViewController:errorAlertV animated:YES completion:nil];
}


- (void)setModel:(WebModel *)model{
    _model = model;
    URL_Web = model.url;
}


@end
