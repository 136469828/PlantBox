//
//  HomeCollectionViewCell.h
//  No.1 Pharmacy
//
//  Created by JCong on 15/11/4.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameAndSpecifltion;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (nonatomic, copy) NSString *shopID;

- (void)configStopModel:(NSArray *)stopModels;
@end
