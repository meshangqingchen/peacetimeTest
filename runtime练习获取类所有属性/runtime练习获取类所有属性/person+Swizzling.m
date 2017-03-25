//
//  person+Swizzling.m
//  runtime练习获取类所有属性
//
//  Created by 3D on 16/12/11.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "person+Swizzling.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"
@implementation person (Swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleSelector:@selector(wocao) withSwizzledSelector:@selector(woshishi)];
        
    });
}

-(void)woshishi{
    NSLog(@"我试试");
}

@end
