//
//  TheOfficialTutorialListController.m
//  PlantBox
//
//  Created by admin on 16/5/24.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "TheOfficialTutorialListController.h"
#import "TheOfficialTutorialController.h"
#import "KeyboardToolBar/KeyboardToolBar.h"
#import "PlantBKCell.h"
@interface TheOfficialTutorialListController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView *hearView;
    UITextField *seachTextField;
    NSArray *datas;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TheOfficialTutorialListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    datas = @[@"多肉植物",@"观花植物",@"观叶植物",@"草本植物",@"木本植物",@"水生植物",@"室内植物",@"水培植物"];
    [self setTableView];
}
#pragma mark -
- (void)setTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 69) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self hearView];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)hearView{
    
    hearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    hearView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:hearView];
    seachTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 80, 30)];
    seachTextField.delegate = self;
    seachTextField.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    seachTextField.layer.borderWidth = 1.0; // set borderWidth as you want.
    seachTextField.layer.cornerRadius=8.0f;
    seachTextField.layer.masksToBounds=YES;
    [KeyboardToolBar registerKeyboardToolBar:seachTextField];
    [hearView addSubview:seachTextField];
    
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seachBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    seachBtn.frame = CGRectMake(SCREEN_WIDTH - 55, 5, 30, 30);
    [seachBtn addTarget:self action:@selector(seachAction) forControlEvents:UIControlEventTouchDown];
    [hearView addSubview:seachBtn];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(8, hearView.bounds.size.height - 1, ScreenWidth - 16, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [hearView addSubview:line];
    return hearView;
    
}
#pragma mark - tableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PlantBKCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlantBKCell"];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.titleLab.text = datas[indexPath.row];
//    cell.contentLab.text = model.summary;
//    cell.tag = [model.projectIDofModel integerValue];
//    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.author]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheOfficialTutorialController *sub = [[TheOfficialTutorialController alloc] init];
    sub.title = @"官方教程";
    sub.count = indexPath.row;
    [self.navigationController pushViewController:sub animated:YES];
}

@end
