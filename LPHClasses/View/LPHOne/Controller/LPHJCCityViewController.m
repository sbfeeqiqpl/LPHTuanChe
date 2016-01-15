//
//  LPHJCCityViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHJCCityViewController.h"
#import "LPHKmagn.h"
#import "LPHJCCityTableViewCell.h"
#import "AppDelegate.h"

@interface LPHJCCityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *app;
}
@property (strong ,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *array;

@end

@implementation LPHJCCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createTableView];
    [self createGetData];
}
-(void)createView
{
    UIView *daohangView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    daohangView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [self.view addSubview:daohangView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 13, 24);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [daohangView addSubview:button];
    UILabel *dangqianLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 44)];
    dangqianLabel.font = [UIFont systemFontOfSize:20];
    dangqianLabel.text = @"当前城市-西安";
    dangqianLabel.textAlignment = NSTextAlignmentCenter;
    [daohangView addSubview:dangqianLabel];
}
-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    [_tableView registerClass:[LPHJCCityTableViewCell class] forCellReuseIdentifier:@"LPHJCCityTableViewCell"];
}
#pragma mark 请求数据
-(void)createGetData
{
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    _cityNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:JIUCHECHENGSHI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *tempDic in dic[@"result"]) {
            LPHJCCityModel *model = [[LPHJCCityModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [_array addObject:model];
            [_cityNameArray addObject:model.city_name];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
#pragma mark tableView的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPHJCCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHCityTableViewCell"];
    if(cell == nil)
    {
        cell = [[LPHJCCityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHJCCityTableViewCell"];
        //创建位置
    }
    //刷新位置
    [cell relayoutWithModel:_array[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _block(_cityNameArray[indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)setBlock:(cityNameblock)block
{
    _block = block;
}
@end
