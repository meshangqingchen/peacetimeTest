//
//  ARCLayout.m
//  日历环形CollectionView布局
//
//  Created by 3D on 17/3/11.
//  Copyright © 2017年 3D. All rights reserved.
//

#define W_width (([UIScreen mainScreen].bounds.size.width))
#define ITEM_WH W_width*2/31

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


#import "ARCLayout.h"
@interface ARCLayout()
@property(nonatomic,strong) NSMutableArray *arrAttrs;
@end

@implementation ARCLayout


//保存布局项
- (NSMutableArray *)arrAttrs {
    if(_arrAttrs == nil) {
        _arrAttrs = [[NSMutableArray alloc] init];
    }
    return _arrAttrs;
}



-(void)prepareLayout{
    [super prepareLayout];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.arrAttrs addObject:attr];
    }
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat CenterX = 0;
    CenterX = indexPath.row*ITEM_WH + ITEM_WH/2;
//    centerY = W_width * sin(radians*indexPath.row);
    attr.center = CGPointMake(CenterX, ITEM_WH/2);
    attr.size = CGSizeMake(ITEM_WH, ITEM_WH);
    
    [_arrAttrs addObject:attr];
    return attr;
}


-(CGSize)collectionViewContentSize{
   
    return CGSizeMake(W_width*2, W_width/2+ITEM_WH);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSLog(@"%@",NSStringFromCGRect(rect));
   

    //计算可见范围内 collectionView 在屏幕中的 中心点位置.
    CGFloat centerX = self.collectionView.frame.size.width/2.0 + self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes *attr in self.arrAttrs) {
        CGFloat distance = ABS(attr.center.x - centerX);
        //根据cell 距离中心点的这个动态 变化的距离制造一个缩放比例.
        if (distance <= self.collectionView.frame.size.width/2) {
            CGFloat scale = 1 - distance / (self.collectionView.frame.size.width /2.0);
            //attr的centerY的位置 self.view.frame.size.width*(1-cos(M_PI/6)
            CGFloat attrCentrY = (self.collectionView.frame.size.height-ITEM_WH)*scale;
            CGPoint center = attr.center;
            attr.center = CGPointMake(center.x, attrCentrY);
        }
        
    }
    return self.arrAttrs;
}

@end

















































