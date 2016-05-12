//
//  MainViewController.m
//  TestViewList
//
//  Created by JCong on 15/10/24.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"

#define SECTION_BTN_TAG_BEGIN   1000
#define SECTION_IV_TAG_BEGIN    3000
@interface DropDownListView : UIView
{
    NSInteger currentExtendSection;     //当前展开的section ，默认－1时，表示都没有展开
}

@property (nonatomic, assign) id<DropDownChooseDelegate> dropDownDelegate;
@property (nonatomic, assign) id<DropDownChooseDataSource> dropDownDataSource;

@property (nonatomic, strong) UIView *mSuperView;
@property (nonatomic, strong) UIView *mTableBaseView;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) UIView *mView;

- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate;
- (void)setTitle:(NSString *)title inSection:(NSInteger) section;

- (BOOL)isShow;
- (void)hideExtendedChooseView;

@end
