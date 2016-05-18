
//
//  TheOfficialTutorialController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "TheOfficialTutorialController.h"
#import "TLDisplayView.h"
@interface TheOfficialTutorialController ()<TLDisplayViewDelegate>

@property (nonatomic, strong) TLDisplayView *displayView;

@end

@implementation TheOfficialTutorialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _displayView = [[TLDisplayView alloc] init];
    _displayView.delegate = self;
    _displayView.backgroundColor = [UIColor whiteColor];
    _displayView.numberOfLines = 5;
    [_displayView setText:@"    成千的植物物种被种植用来美化环境、提供绿荫、调整温度、降低风各种观赏植物各种观赏植物减少噪音、提供隐私和防止水土流失。人们会在室内放置切花、干燥花和室内盆栽；室外则会设置草坪、荫树、观景树、灌木、藤蔓、多年生草本植物和花坛花草；植物的意像通常被使用于美术、建筑、性情、语言、照像、纺织、钱币、邮票、旗帜和臂章上头；活植物可用于绿雕、盆景、插花和树墙等。观赏植物有时会影响到历史，如郁金香狂热。植物是每年有数十亿美元的旅游产业的基本，包括到植物园、历史园林、国家公国、郁金香花田、雨林以及有多彩秋叶的森林等地的旅行"];
    [_displayView setOpenString:@"［查看全文］" closeString:@"［点击收起］" font:[UIFont systemFontOfSize:16] textColor:[UIColor blueColor]];
    CGSize size = [_displayView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT)];
    _displayView.frame = CGRectMake(10, 0, size.width, size.height);
    [self.view addSubview:_displayView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -
#pragma mark TLDisplayViewDelegate
- (void)displayView:(TLDisplayView *)label closeHeight:(CGFloat)height {
    CGRect frame = _displayView.frame;
    frame.size.height = height;
    self.displayView.frame = frame;
}

- (void)displayView:(TLDisplayView *)label openHeight:(CGFloat)height {
    CGRect frame = _displayView.frame;
    frame.size.height = height;
    self.displayView.frame = frame;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
