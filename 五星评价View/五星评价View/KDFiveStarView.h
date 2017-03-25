//
//  KDFiveStarView.h
//  PetAnimals
//
//  Created by mac on 2016/11/23.
//  Copyright © 2016年 petle. All rights reserved.
//  五星评价

#import <UIKit/UIKit.h>

@interface KDFiveStarView : UIView

- (instancetype)initWithStarSelectedImgName:(NSString *)selectedImgName
                            unselectImgName:(NSString *)unselectImgName
                                     starWH:(CGFloat)starWH
                                starPadding:(CGFloat)starPadding;

@property (nonatomic, assign, readonly) int count;
@property (nonatomic, copy) void (^KDFiveStarViewResult) (int count);


/**
 禁用选择 设置星数
 */
- (void)setStarDisabledAndCount:(int)count;

@end
