//
//  ViewController.m
//  openGL2三角形
//
//  Created by 3D on 17/3/14.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import "OpenGLView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    OpenGLView *openGLView = [[OpenGLView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:openGLView];
//    int a = 3;
//    int b[3] = {3 ,2 ,1}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
