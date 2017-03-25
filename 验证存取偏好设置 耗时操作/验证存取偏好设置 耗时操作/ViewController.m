//
//  ViewController.m
//  验证存取偏好设置 耗时操作
//
//  Created by 3D on 17/2/16.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
NSString *test = @"------asda=================================================================================das";
    [[NSUserDefaults standardUserDefaults] setObject:test forKey:@"asd"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"asd"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"asd"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"asd"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"asd"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"asd"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
