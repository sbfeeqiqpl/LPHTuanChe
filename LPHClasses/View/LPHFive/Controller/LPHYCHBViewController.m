//
//  LPHYCHBViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/15.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHYCHBViewController.h"
#import "LPHKmagn.h"
#import "LPHHBBZViewController.h"

@interface LPHYCHBViewController ()
{
    UIView *view;
    UIWebView *webView;
}
@property (strong,nonatomic) UIView *hbView;
@end

@implementation LPHYCHBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self webView];
    
    UIButton *bangzhu = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50, 10, 40, 20)];
    [bangzhu setTitle:@"帮助" forState:UIControlStateNormal];
    [bangzhu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bangzhu addTarget:self action:@selector(bangzhu) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bangzhu];
}
#pragma mark 帮助
-(void)bangzhu
{
    LPHHBBZViewController *lphhbbz = [[LPHHBBZViewController alloc]init];
    [self presentViewController:lphhbbz animated:YES completion:^{
    }];
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
    
    NSArray *array = @[@"买车红包",@"养车红包"];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.frame = CGRectMake(WIDTH/4, 5, WIDTH/2, 30);
    segment.tintColor = [UIColor redColor];
    [view addSubview:segment];
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [segment setSelectedSegmentIndex:0];
}
#pragma mark webView创建
-(void)webView
{
    _hbView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60)];
    _hbView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_hbView];
    
    NSString *string = YANGCHEHB;
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(WIDTH, 60, WIDTH, HEIGHT-60)];
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    [webView loadRequest:request];
}
#pragma mark 返回按钮监听
-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)segmentValueChanged:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        [self.view bringSubviewToFront:_hbView];
        _hbView.frame = CGRectMake(0, 60, WIDTH , HEIGHT-60);
        webView.frame = CGRectMake(WIDTH, 60, WIDTH, HEIGHT-60);
    }else
    {
        [self.view bringSubviewToFront:webView];
        _hbView.frame = CGRectMake(WIDTH, 60, WIDTH, HEIGHT-60);
        webView.frame = CGRectMake(0, 60, WIDTH , HEIGHT-60);
    }
    
}
@end
