//
//  ViewController.m
//  五星评价View
//
//  Created by 3D on 17/1/12.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import "KDFiveStarView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    KDFiveStarView *starView = [[KDFiveStarView alloc] initWithStarSelectedImgName:@"star_selected" unselectImgName:@"star_unselect" starWH:20.f starPadding:10];
//    [starView setStarDisabledAndCount:5];
    [starView setKDFiveStarViewResult:^(int t) {
        NSLog(@"%d",t);
    }];
    starView.backgroundColor = [UIColor redColor];
    starView.frame = CGRectMake(100, 100, 200, 30);
    [self.view addSubview:starView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
