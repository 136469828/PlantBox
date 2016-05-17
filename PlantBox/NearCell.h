//
//  NearCell.h
//  PlantBox
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *disLab;
@property (weak, nonatomic) IBOutlet UILabel *friendLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@end
