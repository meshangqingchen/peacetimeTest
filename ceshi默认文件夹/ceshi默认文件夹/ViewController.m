//
//  ViewController.m
//  ceshi默认文件夹
//
//  Created by 3D on 16/12/23.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"
#import "HTStorageSpaceView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"++++++++   %@", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES));
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"lcc"] = @"lcchengcheng";
    NSLog(@"%@",dic);
    
    HTStorageSpaceView *view = [[HTStorageSpaceView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:view];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
