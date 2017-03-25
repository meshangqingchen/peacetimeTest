//
//  ViewController.m
//  SDWebImageTest
//
//  Created by 3D on 17/1/7.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>





@interface ViewController ()

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%lu",(unsigned long)SDWebImageRetryFailed1);
//    NSLog(@"%lu",(unsigned long)SDWebImageLowPriority1);
//    NSLog(@"%lu",(unsigned long)SDWebImageCacheMemoryOnly1);
//    NSLog(@"%lu",(unsigned long)SDWebImageProgressiveDownload1);
//    NSLog(@"%lu",(unsigned long)SDWebImageRefreshCached1);
//    NSLog(@"%lu",(unsigned long)SDWebImageContinueInBackground1);
//    NSLog(@"%lu",(unsigned long)SDWebImageHandleCookies1);
//    NSLog(@"%lu",(unsigned long)SDWebImageAllowInvalidSSLCertificates1);
//    NSLog(@"%lu",(unsigned long)SDWebImageHighPriority1);
//    NSLog(@"%lu",(unsigned long)SDWebImageDelayPlaceholder1);
//    NSLog(@"%lu",(unsigned long)SDWebImageTransformAnimatedImage1);
    //http://588ku.com/sucai/5025365.html
//    http://588ku.com/sucai/1099.html
    //http://upload-images.jianshu.io/upload_images/3654745-a942bbb02c950dcd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
    UIImageView *imageView = [UIImageView new];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/3430760-a937cf2913de577e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"] placeholderImage:nil options:SDWebImageDelayPlaceholder];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
