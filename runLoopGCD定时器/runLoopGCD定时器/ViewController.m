//
//  ViewController.m
//  runLoopGCD定时器
//
//  Created by 3D on 17/3/18.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) dispatch_source_t timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    
    //创建一个事件源 DISPATCH_SOURCE_TYPE_TIMER
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 0.0001*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"---------");
    });
    dispatch_resume(self.timer);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
