//
//  JCAlertView.m
//  LCAlerterView
//
//  Created by 3D on 16/12/15.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "JCAlertView.h"
#import "jCSingleTon.h"
#import "JCViewController.h"

#import "AppDelegate.h"
#define JCScreenWidth [UIScreen mainScreen].bounds.size.width
#define JCScreenHeight [UIScreen mainScreen].bounds.size.height
@interface JCAlertView ()

@property (nonatomic, weak) JCViewController *vc;
@property (nonatomic, getter=isCustomAlert) BOOL customAlert;
@property (nonatomic, getter=isDismissWhenTouchBackground) BOOL dismissWhenTouchBackground;

@end

@implementation JCAlertView


- (instancetype)initWithCustomView:(UIView *)customView dismissWhenTouchedBackground:(BOOL)dismissWhenTouchBackground{
    if (self = [super initWithFrame:customView.bounds]) {
        [self addSubview:customView];
        self.center = CGPointMake(JCScreenWidth / 2, JCScreenHeight / 2);
        self.customAlert = YES;
        self.dismissWhenTouchBackground = dismissWhenTouchBackground;
    }
    return self;
}

- (void)show{
    [[jCSingleTon shareSingleTon].alertStack addObject:self];
    
    [self showAlert];
}


- (void)showAlert{
    NSInteger count = [jCSingleTon shareSingleTon].alertStack.count;
    JCAlertView *previousAlert = nil;
    if (count > 1) {
        NSInteger index = [[jCSingleTon shareSingleTon].alertStack indexOfObject:self];
        previousAlert = [jCSingleTon shareSingleTon].alertStack[index - 1];
    }
    [self showAlertHandle];
}

- (void)showAlertHandle{
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;//就是appdelegate的Window
    NSLog(@"keywindow = %@",keywindow);
    NSLog(@"keywindow.windowLevel = %lf",keywindow.windowLevel);
    
    NSLog(@"window = %@",(AppDelegate *)[UIApplication sharedApplication].delegate.window);
    
    NSLog(@"backgroundWindow = %@",[jCSingleTon shareSingleTon].backgroundWindow);
    NSLog(@"backgroundWindow.windowLevel = %lf",[jCSingleTon shareSingleTon].backgroundWindow.windowLevel);
    
    
    if (keywindow != [jCSingleTon shareSingleTon].backgroundWindow) {
        [jCSingleTon shareSingleTon].oldKeyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    JCViewController *vc = [[JCViewController alloc] init];
    self.vc = vc;
    
    [jCSingleTon shareSingleTon].backgroundWindow.frame = [UIScreen mainScreen].bounds;
    [[jCSingleTon shareSingleTon].backgroundWindow makeKeyAndVisible];
    [jCSingleTon shareSingleTon].backgroundWindow.rootViewController = self.vc;
    
    [self.vc showAlert];
}


@end
