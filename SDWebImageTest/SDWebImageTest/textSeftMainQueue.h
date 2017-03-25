//
//  textSeftMainQueue.h
//  SDWebImageTest
//
//  Created by 3D on 17/1/8.
//  Copyright © 2017年 3D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface textSeftMainQueue : NSObject
@property(nonatomic,copy) void (^block)();

@end
