//
//  model.h
//  计算出每个cell的高度
//
//  Created by 3D on 16/7/9.
//  Copyright © 2016年 3D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface model : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)CGFloat cellHight;

-(instancetype)initWith:(NSString *)string;
@end
