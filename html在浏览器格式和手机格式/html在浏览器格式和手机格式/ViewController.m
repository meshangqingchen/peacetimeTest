//
//  ViewController.m
//  html在浏览器格式和手机格式
//
//  Created by 3D on 17/3/24.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *aa = @"<p><span style=\"font-size: 16px;\">1）讲述工业扫描仪的工作原理及用途。<br/>2）讲述扫描仪各部件的调整及用途。<br/>3）学习使用工业扫描仪及扫描软件Geomagics。<br/>4）介绍扫描过程中可能出现的问题。<br/>5）学习使用软件Geomagic Studio、ZBrush软件对构建模型进行修复。<br/>（人像3D Vision、打印3D Craft、模型处理3D Crystal）<br/>6）工业水晶内雕机的学习和实操</span></p>";
    
//    NSString * str = [[NSString alloc]initWithFormat:@"<html><head><meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=no\"></meta><style> img{ width:%fpx !important;} body{padding-left:10px;padding-top:5px;padding-right:10px;padding-bottom:20px;} iframe{ width:%fpx; height:%fpx; webkit-playsinline;}</style></head> <body bgcolor=\"#f8f8f8\" style=\"color:#505050;font-size:17px;word-wrap:break-word;text-align:justify; text-justify:inter-ideograph;  font-family:SimHei\" ><h3 style=\"color:#333333;font-size:20px\">%@</h3><p style=\"color:#999999;font-size:14px\">资讯 &gt; %@ &nbsp;&nbsp;&nbsp;%@</p>%@</body></html>",kWindowW-40,kWindowW-40,(kWindowW-40)*0.565,model.news_title,[weakSelf newsColumnClassid:model.class_id],time,htmlStr];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    webView.delegate =self;
    //UIWebPaginationModeTopToBottom
    webView.paginationMode = UIWebPaginationModeTopToBottom;
    [webView loadHTMLString:aa baseURL:nil];
    [self.view addSubview:webView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    CGFloat sizeHeight = webView.scrollView.contentSize.height;
    NSLog(@"%lf",sizeHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
