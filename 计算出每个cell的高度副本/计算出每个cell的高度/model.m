//
//  model.m
//  计算出每个cell的高度
//
//  Created by 3D on 16/7/9.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "model.h"

@implementation model

-(instancetype)initWith:(NSString *)string{
    if (self = [super init]) {
        _name = string;
    }

    return self;
}

@end
