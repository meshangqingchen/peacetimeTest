//
//  ViewController.m
//  子视图动画变高使改变父视图高动画改变
//
//  Created by 3D on 16/12/15.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scroView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scroView];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor yellowColor];
    [scroView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width);
    }];
    
    UIView *aa = [UIView new];
    aa.backgroundColor = [UIColor orangeColor];
    [contentView addSubview:aa];
    [aa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(100);
    }];
    
    UIView *cc = [UIView new];
    cc.backgroundColor = [UIColor orangeColor];
    [contentView addSubview:cc];
    [cc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(100);
    }];

    
    UIButton *bb = [UIButton new];
    [bb addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    bb.backgroundColor = [UIColor orangeColor];
    [contentView addSubview:bb];
    [bb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(aa.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(cc.mas_top).mas_equalTo(-10);
        make.height.mas_equalTo(200);
    }];

    
    
    
    
    
}

-(void)click:(UIButton*)bt{
    bt.selected = !bt.selected;
    if (bt.selected) {
        [bt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(600);
        }];
    }else{
        [bt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
        }];
        
    }
    [UIView animateWithDuration:3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
