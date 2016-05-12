//
//  collectionView.h
//  No.1 Pharmacy
//
//  Created by JCong on 15/11/7.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;


@end
