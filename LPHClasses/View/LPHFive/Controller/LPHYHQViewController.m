//
//  LPHYHQViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/15.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHYHQViewController.h"
#import "LPHKmagn.h"

@interface LPHYHQViewController ()
{
    UIView *view;
    UIWebView *webView;
    UIWebView *webView1;
}
@end

@implementation LPHYHQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self webView];
}
-(void)createView
{
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40)];
    view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1];
    [self.view addSubview:view];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 13, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    NSArray *array = @[@"优惠券",@"大礼包"];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.frame = CGRectMake(WIDTH/4, 5, WIDTH/2, 30);
    segment.tintColor = [UIColor redColor];
    [view addSubview:segment];
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [segment setSelectedSegmentIndex:0];
}
-(void)webView
{
    NSURL *url = [NSURL URLWithString:YANGCHEHB];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60)];
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    [webView loadRequest:request];
    
    NSURL *url1 = [NSURL URLWithString:DALIBAO];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    webView1 = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60)];
    webView1.scrollView.bounces = NO;
    [self.view addSubview:webView1];
    [webView1 loadRequest:request1];
}
-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)segmentValueChanged:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        [self.view bringSubviewToFront:webView];
        webView.frame = CGRectMake(0, 60, WIDTH, HEIGHT-60);
        webView1.frame = CGRectMake(WIDTH, 60, WIDTH, HEIGHT-60);
    }else
    {
        webView1.frame = CGRectMake(0, 60, WIDTH , HEIGHT-60);
        [self.view bringSubviewToFront:webView];
        webView.frame = CGRectMake(WIDTH, 60, WIDTH , HEIGHT-60);
    }
}
@end
