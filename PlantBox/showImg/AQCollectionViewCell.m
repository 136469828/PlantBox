//
//  AQCollectionViewCell.m
//  Picture
//
//  Created by aiqing on 16/1/10.
//  Copyright © 2016年 aiqing. All rights reserved.
//

#import "AQCollectionViewCell.h"

@implementation AQCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_imageView];
}

@end
