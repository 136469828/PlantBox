//
//  FunctionViewController.m
//  PlantBox
//
//  Created by admin on 16/5/27.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "FunctionViewController.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(10, -ScreenHeight*0.2, ScreenWidth-20, ScreenHeight-100)];
    l.font = [UIFont systemFontOfSize:15];
    l.numberOfLines = 0;
//    l.backgroundColor = [UIColor redColor];
    l.text = @"        关于我们的版块信息参考：东莞市中实创半导体照明有限公司，作为北京大学东莞光电研究院下属孵化企业，以自然、科技、希望为发展方向，拥有多年的植物生长光源研发经验，领先的植物无土栽培技术，致力于将安全高效的微农业种植技术和设备引入万千家庭，创建家庭微农业生态体系。\n       “植物盒子”系列智能种植机，分别面向孩子、老人、情人和家庭食用等方向，全方位融入家庭，在解决家庭食用无公害蔬菜的同时，发掘室内植物种植的乐趣，打造种植兴趣交流社区，建立家庭绿色基地。";
    
    [self.view addSubview:l];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-80, ScreenHeight-250, 160, 160)];
    imgv.image = [UIImage imageNamed:@"perweima_App"];
    [self.view addSubview:imgv];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
