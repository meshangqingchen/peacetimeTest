//
//  textSeftMainQueue.m
//  SDWebImageTest
//
//  Created by 3D on 17/1/8.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "textSeftMainQueue.h"


#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

@implementation textSeftMainQueue
-(instancetype)init{
    if (self = [super init]) {
        dispatch_main_sync_safe(^{
        
        })
        
        self.block();
        self.block = ^{
        
        };
    }
    return self;
}
@end
