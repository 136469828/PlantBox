//
//  HCommentsController.m
//  PlantBox
//
//  Created by admin on 16/5/24.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "HCommentsController.h"
#import "NextManger.h"
@interface HCommentsController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@end

@implementation HCommentsController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.cornerRadius = 10;
    self.textView.delegate = self;
    self.textView.text = @"请输入此时想法";
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:recognizer];
    
    self.textView.textColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedDidappear:) name:UIKeyboardWillHideNotification object:nil];
    [self.sendBtn addTarget:self action:@selector(comAction) forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)keyboaedDidShow:(NSNotification *)notif{
    //        NSLog(@"键盘出现 %@",notif);
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%d",height);
    
    [UITableView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, -100, ScreenWidth, ScreenHeight);
    }];
    self.textView.text=@"";
    _textView.textColor = [UIColor blackColor];
    
}
- (void)keyboaedDidappear:(NSNotification *)notif{
    NSLog(@"键盘消失");
    [UITableView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0,39, SCREEN_WIDTH, ScreenHeight );
    }];
}
-(void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}
- (void)comAction
{
    NextManger *manger = [NextManger shareInstance];
    manger.keyword = self.shopID; manger.content = self.textView.text;
    NSLog(@"%@",manger.keyword);
    [manger loadData:RequestOfusercomment];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
