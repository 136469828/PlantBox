//
//  MainViewController.m
//  TestViewList
//
//  Created by JCong on 15/10/24.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DropDownChooseDelegate <NSObject>

@optional

-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index;
@end

@protocol DropDownChooseDataSource <NSObject>
-(NSInteger)numberOfSections;
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;
-(NSInteger)defaultShowSection:(NSInteger)section;

@end



