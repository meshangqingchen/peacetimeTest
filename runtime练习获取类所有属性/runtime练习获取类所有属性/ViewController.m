//
//  ViewController.m
//  runtime练习获取类所有属性
//
//  Created by 3D on 16/12/10.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+Swizzling.h"
#import "person.h"
#import "person+Swizzling.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [@[@"value", @"value1"] mutableCopy];
//    [array wocao];
    
    person *pp = [[person alloc]init];
    [pp wocao];
  
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
