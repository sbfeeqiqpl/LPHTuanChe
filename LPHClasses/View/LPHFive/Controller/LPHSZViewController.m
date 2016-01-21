//
//  LPHSZViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/15.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHSZViewController.h"
#import "LPHKmagn.h"

@interface LPHSZViewController ()
{
    UIView *diView;
}
@end

@implementation LPHSZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    diView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT-20)];
    diView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [self.view addSubview:diView];
    [self createView];
}
-(void)createView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [diView addSubview:view];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 13, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 40)];
    label.text = @"更多";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:label];
}
-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
