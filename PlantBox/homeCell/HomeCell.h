//
//  HomeCell.h
//  PlantBox
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *cellContentView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;

@property (nonatomic ,strong)   NSArray *imgs;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
- (void)configCellWithButtonModels:(NSArray *)buttonModels;
@end
