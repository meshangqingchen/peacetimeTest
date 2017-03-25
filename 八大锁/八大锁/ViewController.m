//
//  ViewController.m
//  八大锁
//
//  Created by 3D on 17/2/9.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testNSLock];
//    [self testNSConditionLock];
    [self testRecursiveLock];
}

-(void)testNSLock{
    NSLock *lock = [[NSLock alloc] init];

//1
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [lock lock];
//        NSLog(@"线程1执行了");
//        sleep(10);
//        [lock unlock];
//        NSLog(@"线程1解锁成功");
//    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        sleep(1);//保证线程1执行了过了
//        [lock lock];
//        NSLog(@"线程2");
//        
//        [lock unlock];
//        NSLog(@"线程2解锁成功");
//    });

//2
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [lock lock];
//        NSLog(@"线程1执行了");
//        sleep(3);
//        [lock unlock];
//        NSLog(@"线程1解锁成功");
//    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        sleep(1);//保证线程1执行了过了
//        if ([lock tryLock]) {
//            NSLog(@"试图加锁 加锁成功就加锁成功了 加锁不成功就加锁失败了但是不会阻塞线程");
//            [lock unlock];
//        }else{
//            NSLog(@"加锁不成功");
//        }
//    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        NSLog(@"线程1执行了");
        sleep(4);
        [lock unlock];
        NSLog(@"线程1解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(1);//保证线程1执行了过了
        if ([lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:3]]) {
            NSLog(@"在时间之前加锁成功");
            [lock unlock];
        }else{
            NSLog(@"在时间之前加锁不成功");
        }
    });
}

//条件锁NSConditionLock
-(void)testNSConditionLock{
    NSConditionLock *conditionLock = [[NSConditionLock alloc]initWithCondition:0];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditionLock lockWhenCondition:1];
        NSLog(@"线程1");
        sleep(1);
        [conditionLock unlockWithCondition:2];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditionLock lockWhenCondition:0];
        NSLog(@"线程2");
        sleep(2);
        [conditionLock unlockWithCondition:2];
        NSLog(@"线程2解锁");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditionLock lockWhenCondition:2];
        NSLog(@"线程3");
        sleep(3);
        [conditionLock unlock];
        NSLog(@"线程3解锁");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditionLock lockWhenCondition:2];
        NSLog(@"线程4");
        sleep(4);
        [conditionLock unlockWithCondition:1];
        NSLog(@"线程4解锁");
    });
}

//NSRecursiveLock 递归锁
- (void)testRecursiveLock{
// 这个地方换成NSLock 就会出错
//    NSLock *recursiveLock = [[NSLock alloc]init];
    NSRecursiveLock *recursiveLock = [[NSRecursiveLock alloc]init];
    //线程1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        static void(^RecursiveBlock)(int value);
        RecursiveBlock = ^void(int value){
            [recursiveLock lock];
            if (value>0) {
                NSLog(@"%d",value);
                RecursiveBlock(value-1);
            }
            [recursiveLock unlock];
        };
        RecursiveBlock(2);
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        [recursiveLock lock];
        NSLog(@"线程2");
        [recursiveLock unlock];
    });
    
}

-(void)testNSCondition{
    NSCondition *lock = [[NSCondition alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        while (!array.count) {
            [lock wait];
        }
        [array removeAllObjects];
        NSLog(@"array removeAllObjects");
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        [lock lock];
        [array addObject:@1];
        NSLog(@"array addObject:@1");
        [lock signal];
        [lock unlock];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
