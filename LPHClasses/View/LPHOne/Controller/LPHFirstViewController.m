//
//  LPHFirstViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHFirstViewController.h"
#import "LPHFirstTableViewCell.h"
#import "LPHKmagn.h"
#import "LPHOneViewController.h"
#import "AppDelegate.h"

@interface LPHFirstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger number;
    AppDelegate *app;
    NSArray *lianjieArray;
    NSMutableArray *arr;
}
@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *array;

@end

@implementation LPHFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    app = [UIApplication sharedApplication].delegate;
    number = app.chioce;
    lianjieArray = [NSArray array];
    lianjieArray = @[HUNYINGZUOJIA,MAMIGOUCHE,ZIJIALVYOU,SHANGWU,BAILING,DAIBU];
    [self createTableView];
    [self createHeadView];
    [self createGetData];
    [self createView];

}
#pragma mark 导航栏上的按钮
-(void)createView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIButton *fanhuiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhuiBtn.frame = CGRectMake(10, 10, 10, 20);
    [fanhuiBtn setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [fanhuiBtn addTarget:self action:@selector(fanhuiBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fanhuiBtn];
    
    UIButton *fenxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fenxiangBtn.frame = CGRectMake(WIDTH-40, 10, 20, 20);
    [fenxiangBtn setBackgroundImage:[UIImage imageNamed:@"icon_fenxiang"] forState:UIControlStateNormal];
    [fenxiangBtn  addTarget:self action:@selector(fenxiangBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fenxiangBtn];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 40)];
    titleLabel.text = arr[number - 1000][@"adpTitle"];
    titleLabel.font = [UIFont boldSystemFontOfSize:24];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
}
#pragma mark 返回上一页
-(void)fanhuiBtn
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)fenxiangBtn
{
    
}
-(void)createHeadView
{
    NSData *data = [[NSData alloc]initWithContentsOfFile:WUZHANGTUPIAN];
    arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT/5)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:arr[number - 1000][@"adpLogo"]]];
    _tableView.tableHeaderView = imageView;
    
}
#pragma mark tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,60, WIDTH, HEIGHT-60)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    [_tableView registerClass:[LPHFirstTableViewCell class] forCellReuseIdentifier:@"LPHFirstTableViewCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
#pragma mark 请求数据
-(void)createGetData
{
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    NSData *data = [[NSData alloc]initWithContentsOfFile:lianjieArray[number - 1000]];
    NSArray *arra = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *tempDic in arra) {
        LPHFirstModel *model = [[LPHFirstModel alloc]init];
        [model setValuesForKeysWithDictionary:tempDic];
        [_array addObject:model];
    }
    [_tableView reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPHFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHFirstTableViewCell"];
    if(cell == nil)
    {
        cell = [[LPHFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHFirstTableViewCell"];
        //创建位置
    }
    //刷新位置
    [cell relayoutWithModel:_array[indexPath.row]];
    return cell;
}
@end
