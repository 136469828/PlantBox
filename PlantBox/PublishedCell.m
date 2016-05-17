//
//  PublishedCell.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "PublishedCell.h"

@implementation PublishedCell

- (void)awakeFromNib {
    // Initialization code

    self.textView.layer.borderWidth = 2;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.contentTextview.textColor = [UIColor lightGrayColor];
    self.textView.layer.cornerRadius = 10;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
