//
//  BillCell.m
//  PlantBox
//
//  Created by admin on 16/5/14.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "BillCell.h"

@implementation BillCell

- (void)awakeFromNib {
    // Initialization code
    self.img.layer.cornerRadius = 43/2;
    self.img.image = [UIImage imageNamed:@"testUserImg"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
