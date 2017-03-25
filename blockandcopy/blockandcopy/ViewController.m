//
//  ViewController.m
//  blockandcopy
//
//  Created by 3D on 17/1/3.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) NSString *bb;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"self = %@",self);
    NSLog(@"self指向内容的地址 = %p",self);
    NSLog(@"self指针的内存地址 = %p",&self);
    
    self.bb = @"bb";
    NSLog(@"_bb = %@",_bb);
    NSLog(@"_bb指向内容的地址 = %p",_bb);
    NSLog(@"_bb指针的内存地址 = %p",&_bb);
    
    NSString *aa = @"ad";
    NSLog(@"aa = %@",aa);
    NSLog(@"aa指向内容的地址 = %p",aa);
    NSLog(@"aa指针的内存地址 = %p",&aa);

    NSLog(@"==================");
    
    id x = self;
    

    [self setBlockceshi:^(NSString *str) {
//        NSLog(@"self = %@",x);
//        NSLog(@"self指向内容的地址 = %p",x);
//        NSLog(@"self指针的内存地址 = %p",&x);
       
        NSLog(@"_bb = %@",_bb);
        NSLog(@"_bb指向内容的地址 = %p",_bb);
        NSLog(@"_bb指针的内存地址 = %p",&_bb);
        
//        NSString *aa = @"ad";
//        NSLog(@"aa = %@",aa);
//        NSLog(@"aa指向内容的地址 = %p",aa);
//        NSLog(@"aa指针的内存地址 = %p",&aa);
    }];
    self.blockceshi(@"");
    
//    NSLog(@"self.blockceshi = %@",self.blockceshi );
//    NSLog(@"self.blockceshi指向内容的地址 = %p",self.blockceshi );
//    NSLog(@"self.blockceshi指针的内存地址 = %p",&(_blockceshi));
//    id a = [self.blockceshi copy];
//    NSLog(@"===============");
//    NSLog(@"===============");
//    NSLog(@"a = %@",a);
//    NSLog(@"a指向内容的地址 = %p",a);
//    NSLog(@"a指针的内存地址 = %p",&a);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
