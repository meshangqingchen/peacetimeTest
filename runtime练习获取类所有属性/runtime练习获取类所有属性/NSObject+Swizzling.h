//
//  NSObject+Swizzling.h
//  runtime练习获取类所有属性
//
//  Created by 3D on 16/12/11.
//  Copyright © 2016年 3D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)
+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;
@end
