//
//  ViewController.m
//  blockcopy
//
//  Created by 3D on 17/3/5.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"
@interface ViewController ()
@property(nonatomic,copy)void (^textBlock)();
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //weak
    [self setTextBlock:^{
    //a = asd 
        
    }];
    NSLog(@"self.block =  %@", self.textBlock);
    
    BViewController *bvc = [BViewController new];
    bvc.textBlock = self.textBlock;
    [self presentViewController:bvc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
