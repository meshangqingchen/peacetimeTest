//
//  ViewController.m
//  运行时test
//
//  Created by 3D on 16/6/5.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"
//#import <>
#import <objc/runtime.h>
@interface ViewController ()<UIAlertViewDelegate>

@end
static char kRepresentedObject;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *interestingString = @"My Interesting Thing";
    //将数据和控件绑定
    UIAlertView *alert          = [[UIAlertView alloc] initWithTitle:@"Alert" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    
    objc_setAssociatedObject(self, &kRepresentedObject, interestingString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    

    [alert show];

    double a = 1.01;
    double b =0.25;
    double c = fmod(a, b);
    NSLog(@"%f",c);

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *interestingString = objc_getAssociatedObject(self, &kRepresentedObject);
    NSLog(@"%@", interestingString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
