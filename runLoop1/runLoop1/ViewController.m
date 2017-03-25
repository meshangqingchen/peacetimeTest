//
//  ViewController.m
//  runLoop1
//
//  Created by 3D on 17/3/18.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import "LCThread.h"
@interface ViewController ()
@property(nonatomic,assign) BOOL finishd;
@property(nonatomic,strong) NSThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    /*
     NSDefaultRunLoopMode 默认模式(时钟 网络 不处理用户的的操作操作)
     UITrackingRunLoopMode (用户操作 各种事件 只处理用户交互下的事情 这个模式下不能有延迟 因为可能会卡主ui)
     NSRunLoopCommonModes 站位模式(站位模式是系统控制 当一条线程有用户操作的时候run就跑的 UITrackingRunLoopMode这个时候runloop的模式就是交互模式 当用户没有用户操作的时候runloop就跑到NSDefaultRunLoopMode 模式下 所以当用户滚动界面的时候这个时候是UITrackingRunLoopMode 模式下但是如果这个模式下有耗时操作就会卡主ui)
     
     一次循环 runloop转一圈 其实是在NSDefaultRunLoopMode模式下和UITrackingRunLoopMode做切换这种切换是系统做的 不受开发者控制
     当用户有 交互 runloop就跑到交互模式下默认模式下就不管了 交互完成就睡觉 当默认模式下有事情就跑到默认模式下
     */
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    //如果开启一条线程那么这条线程就会有一个runloop
    //默认子线程runloop是没有开启的
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSTimer *timer = [NSTimer timerWithTimeInterval:.1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//        while (!_finishd) {
//            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
//        }
//    });
    
    
    //一个线程里面的runloop没有别开启 这个线程运行完就会 "挂掉"即使被强引用
    LCThread *thread = [[LCThread alloc]initWithBlock:^{
        NSLog(@"----");
        NSTimer *timer = [NSTimer timerWithTimeInterval:.1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

        while (!_finishd) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
        }
    }];
    [thread start];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _finishd = YES;
//    [self.thread start];
}
- (void)timeRun{
//    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"开始了");
}

@end
