//
//  HomeCell.m
//  PlantBox
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "HomeCell.h"
@interface HomeCell()
@property(nonatomic,weak) UIView *allView;

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

- (void)awakeFromNib {
    // Initialization code
    NSArray *btnImgs = @[@"006",@"007",@"008"];
    NSArray *imgs = @[@"5.jpg",@"6.jpg",@"7.jpg"];
    NSArray *btnTitles = @[@"分享",@"评论",@"点赞"];
    for (int i = 0; i < 3; i++) {
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(i *(ScreenWidth/3)+ScreenWidth*0.04,80, ScreenWidth/4, ScreenWidth/4)];
        imgv.backgroundColor = [UIColor redColor];
        imgv.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgs[i]]];
        [self.cellContentView addSubview:imgv];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button = [[UIButton alloc] initWithFrame:CGRectMake(i *(ScreenWidth/3)+ScreenWidth*0.06+10,ScreenWidth/4+85, 20, 20)];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",btnImgs[i]]] forState:UIControlStateNormal];
        [button setTitle:@"分享" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [self.cellContentView addSubview:button];
        
        UILabel *btnLab = [[UILabel alloc] initWithFrame:CGRectMake(i *(ScreenWidth/3)+ScreenWidth*0.06+40,ScreenWidth/4+85, 28, 20)];
        btnLab.text = btnTitles[i];
        btnLab.textColor = RGB(195, 195, 195);
        btnLab.font = [UIFont systemFontOfSize:13];
        [self.cellContentView addSubview:btnLab];

     
    }
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, ScreenWidth-16, 75)];
//    contentLab.lineBreakMode = UILineBreakModeWordWrap;
    contentLab.numberOfLines = 0;
    contentLab.font = [UIFont systemFontOfSize:15];
    contentLab.text = @"CocoaPods是iOS项目的依赖管理工具，该项目源码在Github上管理。开发iOS项目不可避免地要使用第三方开源库，CocoaPods的出现使得我们可以节省设置和第三方开源库的时间。";
    [self.cellContentView addSubview:contentLab];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
