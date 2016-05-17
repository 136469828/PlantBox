//
//  OrderCell.m
//  PlantBox
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    // Initialization code
    self.addreText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.addreText.layer.borderWidth = 1;
    self.addreText.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
