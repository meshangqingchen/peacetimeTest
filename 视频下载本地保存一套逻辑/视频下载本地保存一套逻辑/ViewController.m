//
//  ViewController.m
//  视频下载本地保存一套逻辑
//
//  Created by 3D on 16/12/24.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"++++++= == = = = %@ ",path);//totalLength.plist
    NSString *plistPath = [path stringByAppendingPathComponent:@"totalLength.plist"];
    
    
    NSDictionary *dicios0 = @{@"url":@"http://baobab.wdjcdn.com/1455861661073g.mp4",
                             @"title":@"ios我是对个视频0"};
    NSDictionary *dicios1 = @{@"url":@"",
                             @"title":@"http://baobab.wdjcdn.com/14557771465491(9).mp4"};

    NSDictionary *dicios2 = @{@"url":@"",
                             @"title":@"ios我是对个视频2"};

    NSDictionary *dicios3 = @{@"url":@"",
                             @"title":@"ios我是对个视频3"};
    NSArray *arriOS = @[dicios0,dicios1,dicios2,dicios3];
    
    NSDictionary *dicaz0 = @{@"url":@"",
                             @"title":@"az我是一个视频0"};
    NSDictionary *dicaz1 = @{@"url":@"",
                             @"title":@"az我是一个视频1"};

    NSDictionary *dicaz2 = @{@"url":@"",
                             @"title":@"az我是一个视频2"};

    NSDictionary *dicaz3 = @{@"url":@"",
                             @"title":@"az我是一个视频3"};
    NSArray *arraZ = @[dicaz0,dicaz1,dicaz2,dicaz3];

    NSMutableArray *finishArr = [NSMutableArray arrayWithContentsOfFile:plistPath];
    NSLog(@"===  %@",finishArr);
    if (!finishArr) finishArr = [NSMutableArray array];
    [finishArr addObject:arriOS];
    [finishArr addObject:arraZ];
    
    [finishArr writeToFile:plistPath atomically:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
