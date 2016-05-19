//
//  HomeBaseController.m
//  PlantBox
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "HomeBaseController.h"
#import "HomeBaseCell.h"
#import "UIImageView+WebCache.h"
@interface HomeBaseController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HomeBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基地信息";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawTableview];
}
- (void)drawTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-69) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    [self.view addSubview:self.tableView];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"HomeBaseCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBaseCell"];
//    NSLog(@"%@|%@|%@|%@|%@",self.imgs[0],self.imgs[1],self.imgs[2],self.nameImgstr,self.conetLabstr);
    cell.nameLab.text = self.nameImgstr;
    cell.conetLab.text = self.conetLabstr;
    for (int i = 0; i < self.imgs.count; i++)
    {
        UIImageView *image = (UIImageView *)[cell viewWithTag:505 + i];
        image.tag = 505 + i;
        [image sd_setImageWithURL:[NSURL URLWithString:self.imgs[i]]];
        //        titleLabel.text = model.title;
    }
    return cell;
}

@end
