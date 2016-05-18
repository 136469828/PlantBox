//
//  ShopInfoCell.h
//  No.1 Pharmacy
//
//  Created by JCong on 15/12/14.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class ShopScorllView;
@interface ShopInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *producrName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *bayTotal;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIImageView *cellImg;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *pushBK;

//@property (nonatomic, strong) ShopScorllView *advScorll;
@end
