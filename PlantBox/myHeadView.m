//
//  myHeadView.m
//  PlantBox
//
//  Created by admin on 16/5/28.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "myHeadView.h"

@implementation myHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    TitleLable= [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 10, 10)];
    [self addSubview:TitleLable];
}
@end
