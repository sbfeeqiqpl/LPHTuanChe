//
//  LPHTuanGouViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/13.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHTuanGouViewController.h"
#import "LPHKmagn.h"
#import "LPHTableViewCell.h"

@interface LPHTuanGouViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *array;

@end

@implementation LPHTuanGouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createTableView];
    [self createGetData];
    [self createHeadView];
}
#pragma mark 创建导航栏
-(void)createView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40)];
    view.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 13, 20);
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 40)];
    label.text = @"团购详情";
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
}
#pragma mark 返回
-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark tableView的创建
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    [_tableView registerClass:[LPHTableViewCell class] forCellReuseIdentifier:@"LPHTableViewCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
#pragma mark 创建tableView的头部
-(void)createHeadView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH/4*3)];
    _tableView.tableHeaderView = headView;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, headView.bounds.size.height - 30)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic.tuanche.com/car/20151009/14443523111362854_o.jpg"] placeholderImage:[UIImage imageNamed:@"default_special_3"]];
    [headView addSubview:imageView];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageView.bounds.size.height-30, WIDTH, 30)];
    image.image = [UIImage imageNamed:@"beijing.jpg"];
    [imageView addSubview:image];
    
    UIImageView *logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 2, 50, 50)];
    logoImage.layer.borderWidth = 1;
    [logoImage sd_setImageWithURL:[NSURL URLWithString:@"http://pic.tuanche.com/car/20160108/14522483127019860_s.jpg"]];
    [image addSubview:logoImage];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 200, 20)];
    nameLabel.text = @"东风本田 本田CR-V";
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textColor = [UIColor whiteColor];
    [image addSubview:nameLabel];
    
    UILabel *jiageLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, headView.bounds.size.height - 25, 200, 20)];
    jiageLabel.text = @"累计为团友节省57.81万元";
    jiageLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:jiageLabel];
}
#pragma mark 请求数据
-(void)createGetData
{
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:TUANGOU parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *tempDic in dic[@"result"]) {
            LPHOneModel *model = [[LPHOneModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [_array addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark 加载数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHTableViewCell"];
    if(cell == nil)
    {
        cell = [[LPHTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHTableViewCell"];
        //创建位置
    }
    //刷新位置
    [cell relayoutWithModel:_array[indexPath.row]];
    return cell;
}
@end
