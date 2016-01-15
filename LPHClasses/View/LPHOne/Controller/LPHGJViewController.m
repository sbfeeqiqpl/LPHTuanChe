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
#import "AppDelegate.h"
#import "LPHJCCXTableViewCell.h"
#import "MJExtension.h"

@interface LPHGJViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    LPHCheXingModel *model;
    AppDelegate *app;
    UIView *ceView;
    UILabel *titleLabel;
//    NSMutableArray *modelArray;
}
@property (weak, nonatomic) UIButton *cover;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) UITableView *ceTableView;

@property (strong,nonatomic) NSMutableArray *array;

@property (strong,nonatomic) NSMutableArray *nameArray;

@property (strong,nonatomic) NSMutableArray *cheArray;

@property (strong,nonatomic) NSMutableArray *modelArr;

@property long ID;

@end

@implementation LPHGJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createCeView];
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
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 40)];
    titleLabel.text = @"选择品牌";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:titleLabel];
}
#pragma mark 返回上页面
-(void)fanhuiBtn
{
    [self quxiaoBtnClick];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark 抽屉view
-(void)createCeView
{
    ceView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH, 60, WIDTH/6*5, HEIGHT-60)];
    ceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ceView];
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
    _tableView.tag = 400;
    [_tableView registerClass:[LPHCheXingTableViewCell class] forCellReuseIdentifier:@"LPHCheXingTableViewCell"];
    [self.view addSubview:_tableView];
    
    _ceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/6*5, HEIGHT-60)];
    _ceTableView.delegate = self;
    _ceTableView.dataSource = self;
    _ceTableView.showsHorizontalScrollIndicator = NO;
    _ceTableView.showsVerticalScrollIndicator = NO;
    _ceTableView.bounces = NO;
    _ceTableView.tag = 401;
    [_ceTableView registerClass:[LPHJCCXTableViewCell class] forCellReuseIdentifier:@"LPHJCCXTableViewCell"];
    [ceView addSubview:_ceTableView];
}
#pragma mark tableView的行数和行高
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 401){
        return _modelArr.count;
    }
    return _array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark 请求数据
-(void)createGetData
{
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:JIUCHEGUJIA parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for(char i = 'A';i <= 'Z';i++){
        NSString *str = [NSString stringWithFormat:@"%c",i];
            for (NSDictionary *tempDic in dic[@"result"][str])
            {
                model = [[LPHCheXingModel alloc]init];
                [model setValuesForKeysWithDictionary:tempDic];
                [_array addObject:model];
            }
            [_tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
-(void)createGetCheData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"TuanChe" ofType:@"plist"];
    _cheArray = [[NSMutableArray alloc]initWithArray:[NSArray arrayWithContentsOfFile:path]];
    _modelArr = [[NSMutableArray alloc]initWithCapacity:0];
    _nameArray = [[NSMutableArray alloc]initWithCapacity:0];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_cheArray[_ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSString *str in dic[@"result"]) {
            NSArray *dict45 = dic[@"result"][str];
            for(NSDictionary *tempDic in dict45){
                LPHJCCXModel *model1 = [[LPHJCCXModel alloc]initWithDic:tempDic];
                [_nameArray addObject:model1.series_name];
                [_modelArr addObject:model1];
            }
        }
        [_ceTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark 请求的数据加载到cell上
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 401){
        LPHJCCXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHJCCXTableViewCell"];
        if(cell == nil){
            cell = [[LPHJCCXTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHJCCXTableViewCell"];
        }
        [cell relayoutWithModel:_modelArr[indexPath.row]];
        return cell;
    }
    LPHCheXingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHCheXingTableViewCell"];
    if(cell == nil)
    {
        cell = [[LPHCheXingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHCheXingTableViewCell"];
    }
    [cell relayoutWithModel:_array[indexPath.row]];
    return cell;
}
#pragma mark cell 的监听
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 401){
        _block(_nameArray[indexPath.row]);
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
    _ID = indexPath.row;
    NSLog(@"%ld",_ID);
    UIButton *cover =[[UIButton alloc]init];
    cover.frame = CGRectMake(0, 60, WIDTH, HEIGHT-60);
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(quxiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    self.cover = cover;
    [self.view bringSubviewToFront:_cover];
    [self.view bringSubviewToFront:ceView];
    [UIView animateWithDuration:0.5 animations:^{
        titleLabel.text = @"选择车型";
        //3.1.阴影慢慢显示出来
        cover.alpha = 0.2;
        ceView.frame = CGRectMake(WIDTH/6, 60, WIDTH/6*5, HEIGHT-60);
    }];
    [self createGetCheData];
}
-(void)quxiaoBtnClick
{
    [UIView animateWithDuration:0.3 animations:^{
        //存放需要执行动画代码
        ceView.frame = CGRectMake(WIDTH, 60, WIDTH/6*5, HEIGHT-60);
        self.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        //动画执行完毕会自动调用这个block内部的代码
        titleLabel.text = @"选择品牌";
        [self.cover removeFromSuperview];
        self.cover = nil;
    }];
}
-(void)setBlock:(carNameblock)block
{
    _block = block;
}
@end
