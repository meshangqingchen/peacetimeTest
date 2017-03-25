//
//  ViewController.m
//  UIbution分类
//
//  Created by 3D on 16/12/1.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UIButton+ImageTitleStyle.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *testBT = [UIButton new];
    [self.view addSubview:testBT];
    testBT.backgroundColor = [UIColor redColor];
    [testBT setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
    [testBT setTitle:@"我是个锁" forState:0];
    [testBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(100);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(50);
    }];
    /*
     ButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
     ButtonImageTitleStyleLeft  = 0,         //图片在左，文字在右，整体居中。
     ButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
     ButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
     ButtonImageTitleStyleBottom    = 4,     //图片在下，文字在上，整体居中。
     ButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上距离按钮顶部。
     ButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
     ButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
     ButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
     ButtonImageTitleStyleRightLeft = 9,     //图片在右，文字在左，距离按钮两边边距
     ButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
     */
    [testBT setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:20];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
