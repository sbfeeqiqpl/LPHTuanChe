//
//  LPHWeiZhangViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/13.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHWeiZhangViewController.h"
#import "LPHKmagn.h"
@interface LPHWeiZhangViewController ()
{
    UIView *bigview;
}
@end

@implementation LPHWeiZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createButton];
    [self createChaXubBtn];
}
#pragma mark 导航栏创建
-(void)createView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 13, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 40)];
    label.text = @"违章查询";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:label];
}
-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)createButton
{
    bigview = [[UIView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60)];
    bigview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bigview];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    label.text = @"  请按照《机动车行驶证》认真填写以下信息";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    label.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [bigview addSubview:label];
    
    UIButton *diquBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    diquBtn.backgroundColor = [UIColor whiteColor];
    [diquBtn setTitle:@"查询地区" forState:UIControlStateNormal];
    [diquBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    diquBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -WIDTH/4*3, 0, 0);
    diquBtn.frame = CGRectMake(0, 30, WIDTH, 40);
    [diquBtn addTarget:self action:@selector(diquBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UILabel *diquLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-70, 0, 60, 40)];
    diquLabel.text = @"西安 >";
    diquLabel.font = [UIFont systemFontOfSize:18];
    [diquBtn addSubview:diquLabel];
    [bigview addSubview:diquBtn];
    for(int i = 0;i < 4;i++)
    {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30 + 40*i, WIDTH, 1)];
        lab.backgroundColor = [UIColor lightGrayColor];
        [bigview addSubview:lab];
    }
    UILabel *chepaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, WIDTH/4, 40)];
    chepaiLabel.text = @"车牌查询";
    chepaiLabel.font = [UIFont systemFontOfSize:18];
    [bigview addSubview:chepaiLabel];
    
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, WIDTH/4, 40)];
    numLabel.text = @"发动机号";
    numLabel.font = [UIFont systemFontOfSize:18];
    [bigview addSubview:numLabel];
}
-(void)createChaXubBtn
{
    UIButton *chaxunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chaxunBtn.frame = CGRectMake(10, 170, WIDTH-20, 35);
    chaxunBtn.backgroundColor = [UIColor redColor];
    [chaxunBtn setTitle:@"立即查询" forState:UIControlStateNormal];
    chaxunBtn.layer.cornerRadius = 5;
    [chaxunBtn addTarget:self action:@selector(chaxunClick) forControlEvents:UIControlEventTouchUpInside];
    [bigview addSubview:chaxunBtn];
}
#pragma mark 地区按钮的监听
-(void)diquBtnClick
{
    NSLog(@"选择地区");
}
-(void)chaxunClick
{
    NSLog(@"立即查询");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
