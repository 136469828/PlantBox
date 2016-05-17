//
//  OrderController.h
//  PlantBox
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderController : UIViewController
@property (nonatomic, copy) NSString *orderName;
@property (nonatomic, assign) int orderCount;
@property (nonatomic, copy) NSString *orderImg;
@property (nonatomic, copy) NSString *orderPrice;
@property (nonatomic, copy) NSString *shopID;
@end
