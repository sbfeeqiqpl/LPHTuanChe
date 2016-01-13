//
//  LPHGJViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHGJViewController.h"
#import "LPHKmagn.h"
#import "LPHCheXingTableViewCell.h"

@interface LPHGJViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    LPHCheXingModel *model;
}
@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *array;

@property (strong,nonatomic) NSMutableArray *nameArray;

@end

@implementation LPHGJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createTableView];
    [self createGetData];
}
-(void)createView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40)];
    view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1];
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 13, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhuiBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 40)];
    label.text = @"选择品牌";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:label];
}
#pragma mark 返回上页面
-(void)fanhuiBtn
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark 创建tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    [_tableView registerClass:[LPHCheXingTableViewCell class] forCellReuseIdentifier:@"LPHCheXingTableViewCell"];
    [self.view addSubview:_tableView];
    
}
#pragma mark tableView的行数和行高
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)createGetData
{
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    _nameArray = [[NSMutableArray alloc]initWithCapacity:0];
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:JIUCHEGUJIA parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for(char i = 'A';i < 'Z';i++){
        NSString *str = [NSString stringWithFormat:@"%c",i];
            for (NSDictionary *tempDic in dic[@"result"][str])
            {
                model = [[LPHCheXingModel alloc]init];
                [model setValuesForKeysWithDictionary:tempDic];
                [_nameArray addObject:model.brand_name];
                [_array addObject:model];
            }
            [_tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPHCheXingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHCheXingTableViewCell"];
    if(cell == nil)
    {
        cell = [[LPHCheXingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHCheXingTableViewCell"];
    }
    [cell relayoutWithModel:_array[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",_nameArray[indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
