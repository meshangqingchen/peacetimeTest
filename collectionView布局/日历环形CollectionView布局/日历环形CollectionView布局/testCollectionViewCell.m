//
//  testCollectionViewCell.m
//  collectionView瀑布流参差不齐
//
//  Created by 3D on 16/7/19.
//  Copyright © 2016年 3D. All rights reserved.
//
#define W_width (([UIScreen mainScreen].bounds.size.width))
#define ITEM_WH W_width*2/31
#import "testCollectionViewCell.h"

@implementation testCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ITEM_WH, ITEM_WH)];
        self.lable.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_lable];
    }
    return self;
}
@end
