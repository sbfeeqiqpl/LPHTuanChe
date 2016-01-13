//
//  LPHFouthViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 李鹏辉. All rights reserved.
//

#import "LPHFouthViewController.h"
#import "LPHKmagn.h"
#import "UIImageView+WebCache.h"

@interface LPHFouthViewController ()

@end

@implementation LPHFouthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLabel];
    [self createView];
}

-(void)createLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40 )];
    label.backgroundColor = [UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1];
    label.text = @"客服";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
}
-(void)createView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, self.view.bounds.size.height-60)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/3, HEIGHT/3, WIDTH/3, WIDTH/3)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:KEFU]];
    
    [view addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH/5, view.bounds.size.height/4*3, WIDTH/5*3, 30);
    [button setTitle:@"拨打客服热线 400-6969-123" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 6;
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, view.bounds.size.height - 100, WIDTH, 20)];
    label.text = @"客服工作时间:周一到周日09:00-18:00";
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    [view addSubview:label];
}
-(void)buttonClick
{
    NSLog(@"111");
}
@end
