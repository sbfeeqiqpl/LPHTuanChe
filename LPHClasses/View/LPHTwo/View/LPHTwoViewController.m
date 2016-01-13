//
//  LPHTwoViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 李鹏辉. All rights reserved.
//

#import "LPHTwoViewController.h"
#import "LPHKmagn.h"
@interface LPHTwoViewController ()<UIScrollViewDelegate>
{
    UIButton *button;
    UIButton *button1;
    UIButton *button2;
    UIView *colorView;
}
@property (strong,nonatomic) UIScrollView *scrollView;

@end

@implementation LPHTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createButton];
    [self createScroll];
}
-(void)createView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    view.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [self.view addSubview:view];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    label.text = @"买车订单";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:label];
}
-(void)createButton
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 64, WIDTH/3, 40);
    [button setTitle:@"询价订单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.tag = 100;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, WIDTH, 2)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    colorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/3, 2)];
    colorView.backgroundColor = [UIColor redColor];
    [view addSubview:colorView];
    
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(WIDTH/3, 64, WIDTH/3, 40);
    [button1 setTitle:@"报名订单" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor whiteColor];
    button1.tag = 101;
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(WIDTH/3*2, 64, WIDTH/3, 40);
    [button2 setTitle:@"商城订单" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor whiteColor];
    button2.tag = 102;
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}
-(void)createScroll
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 106, WIDTH, HEIGHT - 155)];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(WIDTH, 0);
    
    for(int i = 0;i < 3;i++)
    {
        UIImage *image = [UIImage imageNamed:@"loading_nodata"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectMake(WIDTH*i+(WIDTH/3), HEIGHT/5, WIDTH/3, _scrollView.bounds.size.height/5);
        [_scrollView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, HEIGHT/2, WIDTH/2, 30)];
        label.text = @"暂无数据";
        label.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:label];
    }
}
-(void)buttonClick:(UIButton *)sender
{
    if(sender.tag == 100)
    {
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        colorView.frame = CGRectMake(0, 0, WIDTH/3, 2);
    }
    if(sender.tag == 101)
    {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        colorView.frame = CGRectMake(WIDTH/3, 0, WIDTH/3, 2);
    }
    if(sender.tag == 102)
    {
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        colorView.frame = CGRectMake(WIDTH/3*2, 0, WIDTH/3, 2);
    }
}
@end
