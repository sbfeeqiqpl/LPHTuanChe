//
//  LPHHBBZViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/15.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHHBBZViewController.h"
#import "LPHKmagn.h"

@interface LPHHBBZViewController ()

@end

@implementation LPHHBBZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40)];
    view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1];
    [self.view addSubview:view];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 13, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 40)];
    label.text = @"如何使用我的红包";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:label];
    NSString *string = HONGBAOBZ;
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60)];
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
