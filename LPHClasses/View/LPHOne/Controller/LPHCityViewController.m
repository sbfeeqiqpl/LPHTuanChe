//
//  LPHCityViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHCityViewController.h"
#import "LPHCityTableViewCell.h"
#import "LPHKmagn.h"
#import "AppDelegate.h"

@interface LPHCityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *app;
    NSArray *hotCityArray;
}
@property (strong ,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *array;

@end

@implementation LPHCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self createTableView];
    [self createHeadView];
    [self createView];
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
#pragma mark 热门城市按钮的创建
-(void)createHeadView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/3)];
    headView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1];
    _tableView.tableHeaderView = headView;
    
    UILabel *dingwei = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH, headView.bounds.size.height/5)];
    dingwei.text = @"定位城市";
    dingwei.font = [UIFont boldSystemFontOfSize:headView.bounds.size.height/12];
    [headView addSubview:dingwei];
    
    UILabel *dingweiCity = [[UILabel alloc]initWithFrame:CGRectMake(0, headView.bounds.size.height/5, WIDTH, headView.bounds.size.height/5)];
    dingweiCity.backgroundColor = [UIColor whiteColor];
    dingweiCity.text = @"   西安";
    dingweiCity.textColor = [UIColor redColor];
    dingweiCity.font = [UIFont systemFontOfSize:headView.bounds.size.height/12];
    [headView addSubview:dingweiCity];
    
    UILabel *hotCity = [[UILabel alloc]initWithFrame:CGRectMake(10, headView.bounds.size.height/5*2, WIDTH, headView.bounds.size.height/5)];
    hotCity.text = @"热门城市";
    hotCity.font = [UIFont boldSystemFontOfSize:headView.bounds.size.height/12];
    [headView addSubview:hotCity];
    
    hotCityArray = @[@"北京",@"天津",@"成都",@"上海",@"广州",@"沈阳",@"武汉",@"南京"];
    for(int i = 0;i < 8;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH/4 * (i%4), headView.bounds.size.height/5* (3 +i/4), WIDTH/4, headView.bounds.size.height/5);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:hotCityArray[i] forState:UIControlStateNormal];
        button.tag = i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:button];
    }
    
    for(int i = 0;i < 6;i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4 * (i % 3 + 1), headView.bounds.size.height/5*(3 + i/3)+HEIGHT/150, 1, HEIGHT/75*4)];
        label.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
        [headView addSubview:label];
    }
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, headView.bounds.size.height/5*4, WIDTH, 1)];
    lab1.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [headView addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, headView.bounds.size.height-1, WIDTH, 1)];
    lab2.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [headView addSubview:lab2];
    
}
#pragma mark 热门城市的监听
-(void)cityButtonClick:(UIButton *)button
{
    _block(hotCityArray[button.tag]);
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
    [_tableView registerClass:[LPHCityTableViewCell class] forCellReuseIdentifier:@"LPHCityTableViewCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#pragma mark 请求数据
-(void)createGetData
{
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    _cityArray = [[NSMutableArray alloc]initWithCapacity:0];
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:CITY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *tempDic in dic[@"result"]) {
            LPHCityModel *model = [[LPHCityModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [_array addObject:model];
            [_cityArray addObject:model.name];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPHCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHCityTableViewCell"];
    if(cell == nil)
    {
        cell = [[LPHCityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHTableViewCell"];
        //创建位置
    }
    //刷新位置
    [cell relayoutWithModel:_array[indexPath.row]];
    return cell;
}
#pragma mark cell的监听
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _block(_cityArray[indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)setBlock:(cityblock)block
{
    _block = block;
}
@end
