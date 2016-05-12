//
//  HomeCell.m
//  PlantBox
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "HomeCell.h"
#import "MenuContentViewController.h"
#import "SHMenu.h"
@interface HomeCell()
@property(nonatomic,weak) UIView *allView;
@property (nonatomic, strong) SHMenu *menu;
/** 头像*/
@property(nonatomic,weak) UIImageView *imgHeadUrl;
/** 用户名*/
@property(nonatomic,weak) UILabel *labNickname;

/** 创建时间*/
@property(nonatomic,weak) UILabel *labCreated;
/** 创建设备*/
@property(nonatomic,weak) UILabel *labDevid;
/** 地点*/
@property(nonatomic,weak) UILabel *labArea;
/** 距离*/
@property(nonatomic,weak) UILabel *labDistance;

/** 下拉按钮*/
@property(nonatomic,weak) UIButton *btnDown;

/** 文章*/
@property(nonatomic,weak) UILabel *labRemark;

/** 图片view*/
@property(nonatomic,weak) UIView *picView;
/** 图片*/
@property(nonatomic,weak) UIImageView *pic1;
@property(nonatomic,weak) UIImageView *pic2;
@property(nonatomic,weak) UIImageView *pic3;

/** 分享数量*/
@property(nonatomic,weak) UILabel *YueyouJoinCount;
/** 喜欢数量*/
@property(nonatomic,weak) UILabel *YueyouLikeCount;
/** 回复数量*/
@property(nonatomic,weak) UILabel *YueyouReplyCount;

/** 分享数量*/
@property(nonatomic,weak) UIImageView *imgYueyouJoinCount;
/** 喜欢数量*/
@property(nonatomic,weak) UIImageView *imgYueyouLikeCount;
/** 回复数量*/
@property(nonatomic,weak) UIImageView *imgYueyouReplyCount;


@end



@implementation HomeCell
// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    // Initialization code
    NSArray *btnImgs = @[@"006",@"007",@"008"];
    if (self.imgs.count == 0)
    {
        self.imgs = @[@"5.jpg",@"6.jpg",@"7.jpg"];
    }
    NSLog(@"self.img %ld",self.imgs.count);
    NSArray *btnTitles = @[@"分享",@"评论",@"点赞"];
    for (int i = 0; i < 3; i++) {
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(i *(ScreenWidth/3)+ScreenWidth*0.04,60, ScreenWidth/4, ScreenWidth/4)];
        imgv.backgroundColor = [UIColor redColor];
        imgv.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgs[i]]];
        [self.cellContentView addSubview:imgv];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button = [[UIButton alloc] initWithFrame:CGRectMake(i *(ScreenWidth/3)+ScreenWidth*0.06+10,ScreenWidth/4+65, 18, 18)];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",btnImgs[i]]] forState:UIControlStateNormal];
        [button setTitle:@"分享" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [self.cellContentView addSubview:button];
        
        UILabel *btnLab = [[UILabel alloc] initWithFrame:CGRectMake(i *(ScreenWidth/3)+ScreenWidth*0.06+35,ScreenWidth/4+65, 35, 20)];
        btnLab.text = btnTitles[i];
        btnLab.textColor = RGB(195, 195, 195);
        btnLab.font = [UIFont systemFontOfSize:11];
        [self.cellContentView addSubview:btnLab];

    }
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(8, -10, ScreenWidth-16, 75)];
//    contentLab.lineBreakMode = UILineBreakModeWordWrap;
    contentLab.numberOfLines = 3;
    contentLab.font = [UIFont systemFontOfSize:13];
    contentLab.text = @"CocoaPods是iOS项目的依赖管理工具，该项目源码在Github上管理。开发iOS项目不可避免地要使用第三方开源库，CocoaPods的出现使得我们可以节省设置和第三方开源库的时间。";
    [self.cellContentView addSubview:contentLab];
    
    [self.downBtn addTarget:self action:@selector(downMune:) forControlEvents:UIControlEventTouchDown];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMeu) name:@"touchView" object:nil];
}

- (void)downMune:(UIButton*)sender
{
    UIButton *button = (UIButton *)sender;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    CGRect rect1 = [button convertRect:button.frame fromView:self.contentView];     //获取button在contentView的位置
    CGRect rect2 = [button convertRect:rect1 toView:window];         //获取button在window的位置
    CGRect rect3 = CGRectInset(rect2, -0.5 * 8, -0.5 * 8);          //扩大热区
    //rect3就是最终结果。
//    NSLog(@"%f %f",rect3.origin.x,rect3.origin.y);
    
    if (_menu.state == MenuShow) return;
    MenuContentViewController *menuVC = [[MenuContentViewController alloc] init];
    SHMenu *menu = [[SHMenu alloc] initWithFrame:CGRectMake(0, 0, 160, 100)];
    _menu = menu;
    menu.contentVC = menuVC;
    menu.anchorPoint = CGPointMake(1, 0);
    menu.contentOrigin = CGPointMake(0, 8);
    [menu showFromPoint:CGPointMake(rect3.origin.x-120, rect3.origin.y+30)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_menu hideMenu];
}
- (void)hideMeu
{
    [_menu hideMenu];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
