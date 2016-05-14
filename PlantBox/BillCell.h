//
//  BillCell.h
//  PlantBox
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UILabel *subInfoLab;

@end
