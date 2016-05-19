//
//  JieshaoController.m
//  PlantBox
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "JieshaoController.h"
#define ScreenSizeWidth [[UIScreen mainScreen] applicationFrame].size.width
#define ScreenSizeHeigth [[UIScreen mainScreen] applicationFrame].size.height
@interface JieshaoController ()<UIScrollViewDelegate>
{
    BOOL isFromStart;
}
@property(nonatomic,copy)    UIScrollView *scroll;
@property(nonatomic,copy)    UIPageControl *pageControl;
@property(nonatomic,strong)  NSArray *arr;

@end

@implementation JieshaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _initStarVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_initStarVC{
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, ScreenSizeWidth, ScreenSizeHeigth)];
    _scroll.contentSize = CGSizeMake(3*ScreenSizeWidth, ScreenSizeHeigth);
    _scroll.backgroundColor = [UIColor clearColor];
    _scroll.bounces = YES;
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    UIImage *image1 = [UIImage imageNamed:@"donghua2.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"donghua1.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"donghua3.jpg"];
    self.arr = @[image2,image1,image3];
    for (NSInteger i = 0; i<self.arr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.arr[i]];
        NSLog(@"i = = = =%ld",i);
        imageView.frame = CGRectMake(i*ScreenSizeWidth, 0, ScreenSizeWidth, ScreenSizeHeigth-39);
        [_scroll addSubview:imageView];
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(145, 548, 320, 10)];
    
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = 3;
    //    _pageControl.alpha = 0.5;
    //    _pageControl.tag = 100;
    [_pageControl addTarget:self action:@selector(change:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_scroll];
//    [self.view addSubview:_pageControl];
//    UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [but setTitle:@"立即体验" forState:UIControlStateNormal];
//    but.frame = CGRectMake(ScreenSizeWidth*3-ScreenWidth/2-50,ScreenHeight - ScreenHeight*0.19, 100, 30);
//    but.backgroundColor = [UIColor clearColor];
//    but.layer.cornerRadius = 10;
//    but.layer.borderWidth = 3;
//    but.layer.borderColor = [UIColor whiteColor].CGColor;
//    [but setTintColor:[UIColor whiteColor]];
//    [but addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchDown];
//    [_scroll addSubview:but];
    
    
}

- (void)change:(UIPageControl *)pageControl{
    NSLog(@"%ld",pageControl.currentPage);
    
    switch (pageControl.currentPage) {
        case 0:
            [_scroll setContentOffset:CGPointMake(0,0) animated:YES];
            
            break;
        case 1:
            [_scroll setContentOffset:CGPointMake(320,0) animated:YES];
            
            break;
        case 2:
            [_scroll setContentOffset:CGPointMake(320*2,0) animated:YES];
            
            break;
            
        default:
            break;
    }
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/320;
    _pageControl.currentPage = page;
}

- (void)pushVC{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
