//
//  MenuContentViewController.m
//  SHMenu
//
//  Created by 宋浩文的pro on 16/4/15.
//  Copyright © 2016年 宋浩文的pro. All rights reserved.
//

#import "MenuContentViewController.h"

@interface MenuContentViewController ()

@property (nonatomic, strong) NSMutableArray *menuListArray;

@end

@implementation MenuContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.backgroundColor = kColor(177, 177, 177,1);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *id_cell = @"cell_menu";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id_cell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id_cell];
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"menu_recharge"];
    } else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"menu_personalCenter"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"menu_calculate"];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.imageView.image = [UIImage imageNamed:@"down01"];
        }
            break;
        case 1:
        {
            cell.imageView.image = [UIImage imageNamed:@"down02"];
        }
            break;
        case 2:
        {
            cell.imageView.image = [UIImage imageNamed:@"down03"];
        }
            break;
        case 3:
        {
            cell.imageView.image = [UIImage imageNamed:@"down04"];
        }
            break;
        case 4:
        {
            cell.imageView.image = [UIImage imageNamed:@"down05"];
        }
            break;
            
        default:
            break;
    }
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    selectedBackgroundView.backgroundColor = [UIColor colorWithRed:181/255.0 green:128/255.0 blue:67/255.0 alpha:1];
    
    cell.selectedBackgroundView = selectedBackgroundView;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.menuListArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(menuController:clickAtRow:)]) {
        [self.delegate menuController:self clickAtRow:indexPath.row];
    }
    
}

- (NSMutableArray *)menuListArray
{
    if (_menuListArray == nil) {
        
        _menuListArray = [NSMutableArray arrayWithArray:@[@"分享", @"收藏", @"隐藏此人",@"不看此人动态",@"举报"]];
    }
    return _menuListArray;
}

@end
