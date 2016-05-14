//
//  PlantBKController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "PlantBKController.h"
#import "PlantBKCell.h"
@interface PlantBKController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation PlantBKController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)setTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.estimatedRowHeight = 75;
    [self.view addSubview:_tableView];
    [self registerNib];
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"PlantBKCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlantBKCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlantBKCell"];
    cell.titleLab.text = @"多肉植物";
    cell.contentLab.text = @"    多肉植物是指植物营养器官肥大的高等植物，通常具根、茎、叶三种营养器官和花、果实、种子三种繁殖器官。在园艺上，又称多浆植物或多肉花卉，但以多肉植物这个名称最为常用。全世界共有多肉植物一万余种，它们都属于高等植物(绝大多数是被子植物)。在植物分类上隶属几十个科，个别专家认为有67个科中含有多肉植物，但大多数专家认为只有50余科";
    return cell;
}

@end
