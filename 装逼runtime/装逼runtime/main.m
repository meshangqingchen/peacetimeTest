//
//  main.m
//  装逼runtime
//
//  Created by 3D on 17/2/18.
//  Copyright © 2017年 3D. All rights reserved.
//

//#import <UIKit/UIKit.h>
//#import "AppDelegate.h"
typedef int (^Block)(void);
int main(int argc, char * argv[]) {
    
    // block实现
    Block block = ^{
        return 0;
    };
    // block调用
    block();
    return 0;
    
}
