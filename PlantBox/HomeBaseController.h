//
//  HomeBaseController.h
//  PlantBox
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBaseController : UIViewController
@property (copy, nonatomic)  NSString *nameImg;
@property (copy, nonatomic)  NSString *nameLabstr;
@property (strong, nonatomic)  NSArray *imgs;
@property (strong, nonatomic)  NSString *conetLabstr;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, strong) UIImage *heardimg;
@end
