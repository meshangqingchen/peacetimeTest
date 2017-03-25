//
//  ViewController.m
//  分组队列
//
//  Created by 3D on 17/2/24.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_group_t groupQueue=dispatch_group_create();
    dispatch_queue_t globalQueue=dispatch_get_global_queue(0, 0);

    dispatch_group_async(groupQueue, globalQueue, ^{
        sleep(30);
        
        NSLog(@"thread1 %@", [NSThread currentThread]);
        
    });
    
    dispatch_group_async(groupQueue, globalQueue, ^{
        sleep(10);
        NSLog(@"thread2 %@", [NSThread currentThread]);
    });
    
    dispatch_group_notify(groupQueue, dispatch_get_main_queue(), ^{
        NSLog(@"thread3 %@", [NSThread currentThread]);
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
