//
//  MainViewController.m
//  TestViewList
//
//  Created by JCong on 15/10/24.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "DropDownListView.h"
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

@implementation DropDownListView


- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        currentExtendSection = -1;
        self.dropDownDataSource = datasource;
        self.dropDownDelegate = delegate;
        
        NSInteger sectionNum =0;
        if ([self.dropDownDataSource respondsToSelector:@selector(numberOfSections)] ) {
            
            sectionNum = [self.dropDownDataSource numberOfSections];
        }
        
        if (sectionNum == 0) {
            self = nil;
        }
        
        //初始化默认显示view
        CGFloat sectionWidth = 40;
        for (int i = 0; i <sectionNum; i++) {
            UIButton *sectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(sectionWidth*i, 1, sectionWidth + 20, frame.size.height-2)];
            sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i;
            sectionBtn.backgroundColor = [UIColor clearColor];
            [sectionBtn addTarget:self action:@selector(sectionBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
            NSString *sectionBtnTitle = @"--";
            if ([self.dropDownDataSource respondsToSelector:@selector(titleInSection:index:)]) {
                sectionBtnTitle = [self.dropDownDataSource titleInSection:i index:[self.dropDownDataSource defaultShowSection:i]];
            }
            [sectionBtn  setTitle:sectionBtnTitle forState:UIControlStateNormal];
            [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            sectionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
            [self addSubview:sectionBtn];
            
            UIImageView *sectionBtnIv = [[UIImageView alloc] initWithFrame:CGRectMake(sectionWidth*i +(sectionWidth +5), (self.frame.size.height-12)/2, 12, 12)];
            [sectionBtnIv setImage:[UIImage imageNamed:@"icon_homepage_navArrow"]];
            [sectionBtnIv setContentMode:UIViewContentModeScaleToFill];
            sectionBtnIv.tag = SECTION_IV_TAG_BEGIN + i;
            
            [self addSubview: sectionBtnIv];
            
            if (i<sectionNum && i != 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(sectionWidth*i, frame.size.height/4, 1, frame.size.height/2)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:lineView];
            }
            
        }
        
    }
    return self;
}

-(void)sectionBtnTouch:(UIButton *)btn
{
    NSInteger section = btn.tag - SECTION_BTN_TAG_BEGIN;
    
    UIImageView *currentIV= (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN +currentExtendSection)];
    
    [UIView animateWithDuration:0.3 animations:^{
        currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
    }];
    
    if (currentExtendSection == section) {
        [self hideExtendedChooseView];
    }else{
        currentExtendSection = section;
        currentIV = (UIImageView *)[self viewWithTag:SECTION_IV_TAG_BEGIN + currentExtendSection];
        [UIView animateWithDuration:0.3 animations:^{
            currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
        }];
        
        [self showChooseListViewInSection:currentExtendSection choosedIndex:[self.dropDownDataSource defaultShowSection:currentExtendSection]];
    }

}

- (void)setTitle:(NSString *)title inSection:(NSInteger) section
{
    UIButton *btn = (id)[self viewWithTag:SECTION_BTN_TAG_BEGIN +section];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:title forState:UIControlStateNormal];
}

- (BOOL)isShow
{
    if (currentExtendSection == -1) {
        return NO;
    }
    return YES;
}
-  (void)hideExtendedChooseView
{
    if (currentExtendSection != -1) {
        currentExtendSection = -1;
        
        CGRect rect = self.mView.frame;
//        CGRect rect = self.mTableView.frame;
        rect.size.height = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.mTableBaseView.alpha = 1.0f;
            
            self.mView.alpha = 1.0f;
//            self.mTableView.alpha = 1.0f;
            
            self.mTableBaseView.alpha = 0.2f;
            
            self.mView.alpha = 0.2f;
//            self.mTableView.alpha = 0.2;
            
            self.mView.frame = rect;
//            self.mTableView.frame = rect;
        }completion:^(BOOL finished) {
            
            [self.mView removeFromSuperview];
//            [self.mTableView removeFromSuperview];
            [self.mTableBaseView removeFromSuperview];
        }];
    }
}

-(void)showChooseListViewInSection:(NSInteger)section choosedIndex:(NSInteger)index
{
    // 修改阴影视图的大小
    if (!self.mView) {
        self.mTableBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.mSuperView.frame.size.height*0.3)];
        self.mTableBaseView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
        
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [self.mTableBaseView addGestureRecognizer:bgTap];
        
//        self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 240) style:UITableViewStylePlain];
//        self.mTableView.delegate = self;
//        self.mTableView.dataSource = self;
        
        self.mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 240)];
        // 选择城市
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drownList"]];
        UIView *cicyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.mSuperView.frame.size.height*0.3)];
        cicyView.backgroundColor = [UIColor whiteColor];
        [self.mView addSubview:cicyView];

    }
    
    //修改tableview的frame
    int sectionWidth = (self.frame.size.width)/[self.dropDownDataSource numberOfSections];
    
    CGRect rect = self.mView.frame;
//    CGRect rect = self.mTableView.frame;
    rect.origin.x = sectionWidth *section ;
    rect.size.width = [UIScreen mainScreen].bounds.size.width; // 修改下拉的视图的宽度
    rect.size.height = 0;
    
    self.mView.frame = rect;
//    self.mTableView.frame = rect;
    [self.mSuperView addSubview:self.mTableBaseView];
    
    
    [self .mSuperView addSubview:self.mView];
//    [self.mSuperView addSubview:self.mTableView];
    
    //动画设置位置
    rect .size.height = 240;
    [UIView animateWithDuration:0.3 animations:^{
        self.mTableBaseView.alpha = 0.2;
        
        self.mView.alpha = 0.2;
        
        self.mView.alpha = 0.2;
//        self.mTableView.alpha = 0.2;
        
        self.mTableBaseView.alpha = 1.0;
        
        self.mView.alpha = 1.0;
        self.mView.frame =  rect;
//        self.mTableView.alpha = 1.0;
//        self.mTableView.frame =  rect;
    }];
    [self.mTableView reloadData];
}

-(void)bgTappedAction:(UITapGestureRecognizer *)tap
{
    UIImageView *currentIV = (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN + currentExtendSection)];
    [UIView animateWithDuration:0.3 animations:^{
        currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
    }];
    [self hideExtendedChooseView];
}

@end
