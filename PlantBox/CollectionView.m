//
//  collectionView.m
//  No.1 Pharmacy
//
//  Created by JCong on 15/11/7.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "CollectionView.h"
#import "HomeCollectionViewCell.h"
//#import "ShopModel.h"
//#import "NextManger.h"
//#import "UIImageView+WebCache.h"
//#import "ShopCarModel.h"
//#import "ShopCarViewController.h"

@implementation CollectionView
// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame ];
    if (self) {
        [self _initCollectionView];
    }
    return self;
}
#pragma mark - 创建 UICollectionView
- (void)_initCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置对齐方式
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //cell间距
    layout.minimumInteritemSpacing = 5.0f;
    //cell行距
    layout.minimumLineSpacing = 5.0f;

    //需要layout 否则崩溃：UICollectionView must be initialized with a non-nil layout parameter
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    //注册Cell类，否则崩溃: must register a nib or a class for the identifier or connect a prototype cell in a storyboard
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    [_collectionView setScrollEnabled:NO];
    [self addSubview:_collectionView];
}
//required
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
//    ShopModel *model = [NextManger shareInstance].shopDatas[indexPath.row];
//    if ([NextManger shareInstance].shopDatas.count == 0) {
//        cell.hidden = YES;
//    }
//    else
//    {
//        cell.shopID = model.shopID;
////        NSLog(@"model id is %@",model.shopID);
//
//        cell.nameAndSpecifltion.text = [NSString stringWithFormat:@"%@ %@",model.shopName,model.shopSpecification];
//        cell.price.text = [NSString stringWithFormat:@"￥%.2f",[model.shopPrice doubleValue]];
//        [cell.image sd_setImageWithURL:[NSURL URLWithString:model.image]];
//    }
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return [NextManger shareInstance].shopDatas.count;
    return 10;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width/2)-10 ,180);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 7, 5, 7);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
#if 0
    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    NSData *data = UIImageJPEGRepresentation(cell.image.image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"ID is %@ ",cell.shopID);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:encodedImageStr forKey:@"img"];
    [user setObject:cell.nameAndSpecifltion.text forKey:@"name"];
    [user setObject:cell.price.text forKey:@"price"];
    [user setValue:cell.shopID forKey:@"id"];
    [user synchronize];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"CommodityViewControllerView" object:nil];
#endif
}

@end
