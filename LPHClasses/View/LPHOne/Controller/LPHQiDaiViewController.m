//
//  LPHQiDaiViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHQiDaiViewController.h"
#import "LPHKmagn.h"
@interface LPHQiDaiViewController ()

@end

@implementation LPHQiDaiViewController

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
    label.text = @"汽车贷款";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:label];
    NSString *string = @"http://umapi.tuanche.com/h5/loan?1=1&time=1452686015215&sign=9485604b71ab24d49c9c2cd7cde1a918";
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
