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
#import "ProjectModel.h"
#import "UIImageView+WebCache.h"
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

- (void)awakeFromNib
{
    self.downBtn.selected = YES;
    [self.downBtn addTarget:self action:@selector(downMune:) forControlEvents:UIControlEventTouchDown];
//
//    [self.pinlunBtn addTarget:self action:@selector(pinlunAction) forControlEvents:UIControlEventTouchDown];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMeu) name:@"touchView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMeu) name:@"touchDownMenu" object:nil];
    
}

- (void)downMune:(UIButton*)sender
{
//    NSLog(@"%ld",sender.selected);
    if (sender.selected)
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
        [menu showFromPoint:CGPointMake(rect3.origin.x-120+8, rect3.origin.y+40)];
        sender.selected = !sender.selected;
        
    }
    else
    {
        [_menu hideMenu];
        sender.selected = !sender.selected;
    }
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [_menu hideMenu];
//}
- (void)hideMeu
{
    [_menu hideMenu];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
