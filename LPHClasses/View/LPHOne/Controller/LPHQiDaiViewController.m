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

@property (strong,nonatomic) UIView *myView;

@end

@implementation LPHQiDaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createScrollView];
    [self createImage];
}
#pragma mark 导航栏
-(void)createView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40)];
    headView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1];
    [self.view addSubview:headView];
    UIButton *fanhuiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhuiBtn.frame = CGRectMake(15, 10, 10, 20);
    [fanhuiBtn setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [fanhuiBtn addTarget:self action:@selector(fanhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:fanhuiBtn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 40)];
    label.text = @"汽车贷款";
    label.font = [UIFont boldSystemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label];
}
#pragma mark 返回按钮的监听
-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)createScrollView
{
    _myView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT)];
    _myView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_myView];
}
#pragma mark 添加图片在scrollView上
-(void)createImage
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/3*2)];
    imageView.image = [UIImage imageNamed:@"fenqi"];
    [_myView addSubview:imageView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT/3*2+20, WIDTH, 16)];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"买爱车，超低首付，超低手续费，就能开回家";
    [_myView addSubview:label];
    
    UIImageView *textImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/10, label.frame.origin.y+26, WIDTH/10*8, WIDTH/10)];
    textImage.image = [UIImage imageNamed:@"fenqi_tit"];
    [_myView addSubview:textImage];
    
    
}
@end
