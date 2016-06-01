//
//  MyOrderListCellCell.h
//  PlantBox
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderListCellCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderName;
@property (weak, nonatomic) IBOutlet UILabel *orderAddress;

@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@end
