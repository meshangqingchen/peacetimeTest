//
//  CustomNormalContentViewController.m
//  Animations
//
//  Created by YouXianMing on 15/12/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomNormalContentViewController.h"

@interface CustomNormalContentViewController ()

@end

@implementation CustomNormalContentViewController

- (void)setup {
    
    [super setup];
    
    [self buildBackgroundView];//self.view第一次加的view 一个白色的viewCGRectMake(0, 0, self.width, self.height)
    [self buildContentView];   //又加的一个View 就是在导航下面的View。
    [self buildTitleView];     //导航的View 高64那个
    [self buildLoadingView];   //又加的一个View 就是在导航下面的View。
    [self buildWindowView];    //和WindowView大小一样的View
    
    self.loadingView.userInteractionEnabled = NO;
    self.windowView.userInteractionEnabled  = NO;
}

- (void)buildBackgroundView {
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.view addSubview:self.backgroundView];
}

- (void)buildTitleView {
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64)];
    [self.view addSubview:self.titleView];
}

- (void)buildContentView {
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.width, self.height - 64)];
    [self.view addSubview:self.contentView];
}

- (void)buildLoadingView {
    
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.width, self.height - 64)];
    [self.view addSubview:self.loadingView];
}

- (void)buildWindowView {
    
    self.windowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.view addSubview:self.windowView];
}

@end
