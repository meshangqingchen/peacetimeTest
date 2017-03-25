//
//  ViewController.m
//  点击按钮弹出键盘
//
//  Created by 3D on 16/12/22.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic) BOOL bbb;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
    self.textView = textView;
    textView.backgroundColor = [UIColor yellowColor];
    [view addSubview:textView];
    
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 100, 50)];
    bt.backgroundColor = [UIColor redColor];
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.bbb = YES;
}

-(void)click:(UIButton *)sender{
    
    if (self.bbb) {
        [self.textView becomeFirstResponder];
    }else{
        [self.textView resignFirstResponder];
    }
    
    self.bbb = !self.bbb;
    NSLog(@"-----------");
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
