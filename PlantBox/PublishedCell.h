//
//  PublishedCell.h
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UILabel *context;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hightLine;

@end
