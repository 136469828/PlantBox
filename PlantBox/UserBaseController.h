//
//  UserBaseController.h
//  PlantBox
//
//  Created by admin on 16/5/20.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserBaseController : UIViewController
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userTime;
@property (nonatomic, copy) NSString *userAddress;
@property (nonatomic, strong) UIImage *userImg;
@end
