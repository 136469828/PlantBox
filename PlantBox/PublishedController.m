//
//  PublishedController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "PublishedController.h"
#import "PublishedCell.h"
#import "KeyboardToolBar.h"
#import "ZLPhotoActionSheet.h"
#import "ZLShowBigImage.h"
#import "KeyboardToolBar/KeyboardToolBar.h"
#import "ProjectModel.h"
#import "NextManger.h"
#import "UIImageView+WebCache.h"
@interface PublishedController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
//    NSInteger count;
    UIButton *addImg;
    ZLPhotoActionSheet *actionSheet;
    NextManger *manger;
    UITextField *timeLab;
    UITextView *contextView;
//    UILabel *titlelab;
}
@property (nonatomic, strong) UIView *fV;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation PublishedController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.goodsID);
    if (self.goodsID.length == 0)
    {
        self.goodsID = @"0";
    }
    // Do any additional setup after loading the view.
    // 设置导航默认标题的颜色及字体大小
//    count = 1;
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
    
    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 3;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 10;
    if ([self.sType isEqualToString:@"2"])
    {
        if ([self.goodsID isEqualToString:@"0"])
        {
            return;
        }
        manger = [NextManger shareInstance];
        manger.keyword = self.goodsID;
        [manger loadData:RequestOfgetusercourse];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDatas) name:@"getusercourse" object:nil];
    }
   
}
- (void)reloadDatas
{
    [self.tableView reloadData];
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
    self.tableView.estimatedRowHeight = 160;
    self.tableView.tableFooterView = [self setFootView];
    self.tableView.separatorStyle = NO;;
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
//    titlelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
//    timeLab.textAlignment = kCTTextAlignmentCenter;
//    timeLab.font = [UIFont systemFontOfSize:15];
//    timeLab.textColor = [UIColor blackColor];
//    [v addSubview:timeLab];
//    
//    self.tableView.tableHeaderView = v;
    
//    UISwipeGestureRecognizer *recognizer;
//    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
//    [self.tableView addGestureRecognizer:recognizer];
    [self.view addSubview:_tableView];
    [self registerNib];
}
- (UIView *)setFootView
{
    _fV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight/2)];

    if (![self.goodsID isEqualToString:@"0"])
    {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        l.text = @"继续编辑";
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor lightGrayColor];
        l.font = [UIFont systemFontOfSize:11];
        [_fV addSubview:l];
    }

    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.layer.cornerRadius = 5;
    addBtn.frame = CGRectMake(10, _fV.bounds.size.height-35,ScreenWidth-20, 30);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@"提    交" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addDay) forControlEvents:UIControlEventTouchDown];
    [_fV addSubview:addBtn];
    
    addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    addImg.frame = CGRectMake(10,_fV.bounds.size.height-35-60-8, 60, 60);
//    addImg.backgroundColor = [UIColor redColor];
    [addImg setImage:[UIImage imageNamed:@"AlbumAddBtn@2x"]  forState:UIControlStateNormal];
    [addImg addTarget:self action:@selector(addImgAction) forControlEvents:UIControlEventTouchDown];
    [_fV addSubview:addImg];
    
    timeLab = [[UITextField alloc] initWithFrame:CGRectMake(10, 18, ScreenWidth-20, 30)];
    timeLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
    timeLab.layer.borderWidth = 1;
    timeLab.layer.cornerRadius = 5;
    timeLab.font = [UIFont systemFontOfSize:13];
    timeLab.placeholder = @"请输入标题";
    [KeyboardToolBar registerKeyboardToolBar:timeLab];
    [_fV addSubview:timeLab];
    
    contextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 56, ScreenWidth-20, 100)];
    contextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    contextView.layer.borderWidth = 1;
    contextView.layer.cornerRadius = 5;
    contextView.delegate = self;
    contextView.font = [UIFont systemFontOfSize:13];
    contextView.text = @"请输入教程内容";
    
    [_fV addSubview:contextView];
    
    return _fV;
}
#pragma mark - textViewdelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    contextView.text=@"";
    contextView.textColor = [UIColor blackColor];
    return YES;
    
}
- (void)addDay
{
//    count++;
//    [self.tableView reloadData];
    manger = [NextManger shareInstance];
    manger.goodsID = self.goodsID;
    manger.goodComImgLists = nil;
//    NSLog(@"%@",self.array);
    manger.goodComImgLists = self.array;
    manger.goodsHeadTitle = timeLab.text;
    manger.goodsCom = contextView.text;
//    NSLog(@"%@",self.sType);
    manger.keyword = self.sType;
    if (self.newgoodsID.length == 0)
    {
        manger.newgoodsID = @"0";
    }
    else
    {
        manger.newgoodsID = self.newgoodsID;
    }
    [manger loadData:RequestOfsendgoodrecord];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifAction:) name:@"sendgoodrecord" object:nil];
//    NSLog(@"%ld",(unsigned long)self.array.count);
    self.goodsID = nil;
}
- (void)notifAction:(NSNotification *)obj
{
//    NSLog(@"obj %@",obj.object);
    if ([obj.object isEqualToString:@"1001"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)addImgAction
{
    [self.array removeAllObjects];
    __weak typeof(self) weakSelf = self;
    
    [actionSheet showWithSender:self animate:YES completion:^(NSArray<UIImage *> * _Nonnull selectPhotos) {
//        [weakSelf.fV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        CGFloat width = 60;
        NSString *strImg = nil;
        NSLog(@"开始处理图片");
        [self.array removeAllObjects];
        for (int i = 0; i < selectPhotos.count; i++)
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i%4*(width+4)+10,_fV.bounds.size.height-35-60-8, width, width)];
            imgView.image = selectPhotos[i];
//            UIImage *croppedImg = [self resizeImage:imgView.image withWidth:101 withHeight:101];
//            UIImage *croppedImg = nil;
//            CGRect cropRect = CGRectMake(0 ,0,131,131); // set frame as you need
//            croppedImg = [self croppIngimageByImageName:imgView.image toRect:cropRect];
            
            if (self.array.count == 0)
            {
                self.array = [[NSMutableArray alloc] initWithCapacity:0];
            }
//            imgdata = [self image2DataURL:imgView.image];
            strImg = [self image2DataURL:imgView.image];
            [self.array addObject:strImg];
//            NSLog(@"%@",strImg);
            [weakSelf.fV addSubview:imgView];

            addImg.frame = CGRectMake(_fV.bounds.size.width-60-10,_fV.bounds.size.height-35-60-8, width, width);
            
        }
        NSLog(@"结束处理图片");
    }];

}
- (UIImage*)resizeImage:(UIImage*)image withWidth:(CGFloat)width withHeight:(CGFloat)height
{
    CGSize newSize = CGSizeMake(width, height);
    CGFloat widthRatio = newSize.width/image.size.width;
    CGFloat heightRatio = newSize.height/image.size.height;
    
    if(widthRatio > heightRatio)
    {
        newSize=CGSizeMake(image.size.width*heightRatio,image.size.height*heightRatio);
    }
    else
    {
        newSize=CGSizeMake(image.size.width*widthRatio,image.size.height*widthRatio);
    }
    
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

// 图片转64

- (NSString *) image2DataURL: (UIImage *) image
{
    NSLog(@"开始");
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    NSString *pictureDataString=[data base64Encoding];
    NSLog(@"结束");
    return pictureDataString;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    for (UIView *view in self.fV.subviews) {
        CGRect convertRect = [self.fV convertRect:view.frame toView:self.view];
        if ([view isKindOfClass:[UIImageView class]] &&
            CGRectContainsPoint(convertRect, point)) {
            [ZLShowBigImage showBigImage:(UIImageView *)view];
            break;
        }
    }
}
#pragma mark - 注册Cell
- (void)registerNib{
    NSArray *registerNibs = @[@"PublishedCell"];
    for (int i = 0 ; i < registerNibs.count; i++) {
        [_tableView registerNib:[UINib nibWithNibName:registerNibs[i] bundle:nil] forCellReuseIdentifier:registerNibs[i]];
    }
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return count;
    if ([self.goodsID isEqualToString:@"0"])
    {
        return 0;
    }
    return manger.m_rcourses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishedCell"];
    ProjectModel *model = manger.m_rcourses[indexPath.row];
    cell.dayLab.text = model.recourseTime;
    cell.context.text = model.rcourseCom;
//    titlelab.text = model.rcourseTitle;
    for (int i = 0; i < model.rcourseImgLists.count; i++)
    {
        UIImageView *image = (UIImageView *)[cell viewWithTag:700 + i];
        image.tag = 700 + i;
        [image sd_setImageWithURL:[NSURL URLWithString:model.rcourseImgLists[i]]];
        //        titleLabel.text = model.title;
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hideKeyboard];
}
-(void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
    
}
@end
