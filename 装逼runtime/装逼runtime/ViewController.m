//
//  ViewController.m
//  装逼runtime
//
//  Created by 3D on 17/2/18.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "uiviViewController.h"
@interface ViewController ()
//@property(nonatomic,strong) NSString *str;
//@property(nonatomic,strong) NSMutableString *muStt;

// 1、strong
//@property (nonatomic, strong) NSString *str;
// 2、copy
//@property (nonatomic, copy) NSString *str;

//1
@property(nonatomic,strong) void (^testBlock)();
//2

@property(nonatomic,strong) NSString *asd;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 此处以NSString为例探究框架类深浅copy
    
//    // 不可变对象
//    NSString *str = @"1";
//    NSString *str1 = [str copy];
//    NSString *str2 = [str mutableCopy];
//    
//    // 可变对象
//    NSMutableString *mutableStr = [NSMutableString stringWithString:@"1"];
//    NSMutableString *mutableStr1 = [mutableStr copy];
//    NSMutableString *mutableStr2 = [mutableStr mutableCopy];
//    
//    // 打印对象的指针来确认是否创建了一个新的对象
//    // 不可变对象原始指针
//    NSLog(@"===============================");
//    NSLog(@"%p", str);
//    // 不可变对象copy后指针
//    NSLog(@"%p", str1);
//    // 不可变对象mutalbeCopy后指针
//    NSLog(@"%p", str2);
//    
//    // 可变对象原始指针
//    NSLog(@"%p", mutableStr);
//    // 可变对象copy后指针
//    NSLog(@"%p", mutableStr1);
//    // 可变对象mutalbeCopy后指针
//    NSLog(@"%p", mutableStr2);
//    NSLog(@"===============================");
    
//    // 分别对1和2执行下述代码
//    NSMutableString *mutableStr = [NSMutableString stringWithFormat:@"123"];
//    self.str = mutableStr;
//    NSLog(@"%@", mutableStr);
//    NSLog(@"%p", mutableStr);
//    [mutableStr appendString:@"456"];
//    NSLog(@"%@", self.str);
//    NSLog(@"%p", self.str);
//    NSLog(@"%@", mutableStr);
//    NSLog(@"%p", mutableStr);

//    void(^bbb)() = ^(){
//    
//    };
//    NSLog(@"%@", bbb);
//    NSLog(@"%p", bbb);
//    self.testBlock = bbb;
//    bbb = ^(){};
//    NSLog(@"%@", bbb);
//    NSLog(@"%p", bbb);
//    
//    NSLog(@"%@", self.testBlock);
//    NSLog(@"%p", self.testBlock);
   __block NSString *aaa = @"asd";
    [self setTestBlock:^{
        aaa = @"asd";
    }];
    
    NSLog(@"%@", self.testBlock);
    NSLog(@"%p", self.testBlock);
    
    
    uiviViewController *vc = [uiviViewController new];
    vc.block = self.testBlock;
    
    [self presentViewController:vc animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
