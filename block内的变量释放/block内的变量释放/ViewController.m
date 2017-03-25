//
//  ViewController.m
//  block内的变量释放
//
//  Created by 3D on 17/2/15.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,copy) void (^blockTest)();
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak ViewController *wself = self;
    self.blockTest = ^{
        __strong __typeof(wself) sself = wself; // 强引用一次
        ViewController *ssself = wself;
        
        
        ssself.view.backgroundColor = [UIColor yellowColor];
        
    };
    self.blockTest();
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
