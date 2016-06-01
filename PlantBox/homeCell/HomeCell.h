//
//  HomeCell.h
//  PlantBox
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userHeard;


@property (weak, nonatomic) IBOutlet UIView *cellContentView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;

@property (nonatomic ,strong)   NSArray *imgs;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UIButton *pinlunBtn;

@property (weak, nonatomic) IBOutlet UIButton *dianzanBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;

//- (void)configCellWithButtonModels:(NSArray *)buttonModels;
@end
