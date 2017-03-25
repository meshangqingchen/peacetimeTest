//
//  ViewController.m
//  对比
//
//  Created by 3D on 16/12/11.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"
#import "SDImageCache.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SDImageCache sharedImageCache];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
