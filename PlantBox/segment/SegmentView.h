//
//  SegmentView.h
//  SegmentView
//
//  Created by 房品汇 on 16/4/15.
//  Copyright © 2016年 Lukcy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    SegmentSelectLine = 0,//选中时为横线的样式
    SegmentCaver = 1,//选中时view的状态
    
}SelectType;
@interface SegmentView : UIView

@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,assign) SelectType type;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray selectType:(NSInteger)type;
@end
