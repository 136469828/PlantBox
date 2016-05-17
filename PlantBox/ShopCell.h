//
//  ShopCell.h
//  PlantBox
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImg;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopShow;
@property (weak, nonatomic) IBOutlet UILabel *shopBuy;

@end
