//
//  LPHThreeViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 李鹏辉. All rights reserved.
//

#import "LPHThreeViewController.h"
#import "LPHKmagn.h"
#import "LPHThreeTableViewCell.h"
#import "LPHSanTableViewCell.h"
#import "UIButton+WebCache.h"
#import "LPHThreeCeTableViewCell.h"

@interface LPHThreeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIView *headView;
    UIView *shoubuView;
    UIView *weibuView;
    NSArray *bosArr;
}
@property (strong,nonatomic) UIScrollView *scrollView;

@property (weak, nonatomic) UIButton *cover;

@property (strong,nonatomic) UIView *ceView;
/**侧边抽屉上的scrollView*/
@property (strong,nonatomic) UIScrollView *ceScrollView;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) UITableView *tableView1;

@property (strong,nonatomic) UITableView *ceTableView;

@property (strong,nonatomic) UITableView *ceTableView1;

@property (strong,nonatomic)NSMutableArray *array;

@property (strong,nonatomic)NSMutableArray *ceArray;

@property (assign,nonatomic)BOOL isQufan;

@end

@implementation LPHThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    [self createCeView];
    [self createHead];
    [self createScrollView];
    [self createTableView];
    [self createUI];
    [self createShoubu];
    [self createWeibu];
    [self createGetData];
}
-(void)createView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
}
/**侧边的抽屉*/
-(void)createCeView
{
    _ceView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*2, 60, WIDTH/6*5, HEIGHT-109)];
    _ceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_ceView];
    UIButton *remenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    remenBtn.frame = CGRectMake(0, 0, _ceView.bounds.size.width/2, 40);
    [remenBtn setTitle:@"热门" forState:UIControlStateNormal];
    [remenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    remenBtn.tag = 200;
    [remenBtn addTarget:self action:@selector(ceButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [_ceView addSubview:remenBtn];
    UIButton *jiageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jiageBtn.frame = CGRectMake(_ceView.bounds.size.width/2, 0, _ceView.bounds.size.width/2, 40);
    [jiageBtn setTitle:@"价格" forState:UIControlStateNormal];
    [jiageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jiageBtn.tag = 201;
    [jiageBtn addTarget:self action:@selector(ceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_ceView addSubview:jiageBtn];
    _ceScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, _ceView.bounds.size.width, HEIGHT-149)];
    _ceScrollView.delegate = self;
    _ceScrollView.showsHorizontalScrollIndicator = NO;
    _ceScrollView.showsVerticalScrollIndicator = NO;
    [_ceView addSubview:_ceScrollView];
    _ceScrollView.contentSize = CGSizeMake(0, 0);
    
}
/**抽屉上的两个按钮的监听时间*/
-(void)ceButtonClick:(UIButton *)button
{
    if(button.tag == 200)
    {
        _ceScrollView.contentOffset = CGPointZero;
    }else if(button.tag == 201)
    {
        _ceScrollView.contentOffset = CGPointMake(WIDTH, 0);
    }
}
/**顶部的两个选择按钮*/
-(void)createHead
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    NSArray *array = @[@"品牌选车",@"条件选车"];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.frame = CGRectMake(WIDTH/4, 5, WIDTH/2, 30);
    segment.tintColor = [UIColor redColor];
    [view addSubview:segment];
    
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    //设置默认选中下标
    [segment setSelectedSegmentIndex:0];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, WIDTH, 1)];
    lab.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lab];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}
-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
/**顶部两个选择按钮的监听*/
-(void)segmentValueChanged:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        _scrollView.contentOffset = CGPointZero;
    }else
    {
        _scrollView.contentOffset = CGPointMake(WIDTH, 0);
    }
}
/**tableView头部的热门车型*/
-(void)createUI
{
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT/5*2)];
    _tableView.tableHeaderView = headView;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, headView.bounds.size.height/5)];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    label.text = @"  热门";
    label.font = [UIFont boldSystemFontOfSize:20];
    [headView addSubview:label];
    
    NSData *data = [[NSData alloc]initWithContentsOfFile:Json];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    for(int i = 0;i < 8;i++)
    {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/16 + WIDTH/4 * (i%4), headView.bounds.size.height/5 * (1 + i/4 * 2), WIDTH/8, headView.bounds.size.height/5)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:jsonArr[i][@"logo"]]];
        [headView addSubview:imageView];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4 * (i%4), headView.bounds.size.height/5 * (2 + i/4*2), WIDTH/4, headView.bounds.size.height/9)];
        label.font = [UIFont systemFontOfSize:18];
        label.text = jsonArr[i][@"name"];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [headView addSubview:label];
    }
    
    for(int i = 0;i < 8;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH/4 * (i%4), headView.bounds.size.height/5 * (i/4 * 2 + 1), WIDTH/4, headView.bounds.size.height/5*2);
        button.tag = i;
        [button addTarget:self action:@selector(createButton:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:button];
    }
}
/**条件选车的TableView的头部*/
-(void)createShoubu
{
    shoubuView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT/3*2)];
    _tableView1.tableHeaderView = shoubuView;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, shoubuView.bounds.size.height/30*29, WIDTH, shoubuView.bounds.size.height/30)];
    lab.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [shoubuView addSubview:lab];
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, shoubuView.bounds.size.height/15*4, WIDTH, shoubuView.bounds.size.height/30)];
    lab1.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [shoubuView addSubview:lab1];
    UILabel *jibieLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, shoubuView.bounds.size.height/10*3, 40, shoubuView.bounds.size.height/21*2)];
    jibieLabel.text = @"级别";
    jibieLabel.font = [UIFont systemFontOfSize:20];
    [shoubuView addSubview:jibieLabel];
    
    NSData *data = [[NSData alloc]initWithContentsOfFile:TIAOJIANXUANCHE];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    bosArr = dic[@"bos"];
    for(int i = 0;i < 9;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[NSString stringWithString:bosArr[i][@"name"]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(WIDTH/3 * (i%3),(i/3)* (shoubuView.bounds.size.height/21*4) + shoubuView.bounds.size.height/210*83, WIDTH/3, shoubuView.bounds.size.height/21*4);
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:bosArr[i][@"defIcon"]] forState:UIControlStateNormal];
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:bosArr[i][@"icon"]] forState:UIControlStateSelected];
        button.titleEdgeInsets = UIEdgeInsetsMake(shoubuView.bounds.size.height/21*3, 0, 0, 0);
        button.tag = 300 + i;
        [button addTarget:self action:@selector(jiebieButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [shoubuView addSubview:button];
    }
}
/**条件选车中的级别选车按钮的状态*/
-(void)jiebieButtonClick:(UIButton *)button
{
    if(_isQufan == NO){
        button.selected = YES;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }else
    {
        button.selected = NO;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    _isQufan = !_isQufan;
}
/**条件选车的TableView的尾部*/
-(void)createWeibu
{
    weibuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/3)];
    _tableView1.tableFooterView = weibuView;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, weibuView.bounds.size.height/15)];
    lab.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [weibuView addSubview:lab];
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, weibuView.bounds.size.height/15*11, WIDTH, weibuView.bounds.size.height/15)];
    lab1.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [weibuView addSubview:lab1];
    
    UIButton *chongzhiBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    chongzhiBtn.frame = CGRectMake(5, weibuView.bounds.size.height/5*4+5, WIDTH/4, weibuView.bounds.size.height/5 - 10);
    chongzhiBtn.backgroundColor = [UIColor colorWithRed:0.23f green:0.7f blue:1 alpha:1];
    [chongzhiBtn setTitle:@"重置" forState:UIControlStateNormal];
    [chongzhiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    chongzhiBtn.layer.cornerRadius = 5;
    chongzhiBtn.tag = 100;
    [chongzhiBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weibuView addSubview:chongzhiBtn];
    
    UIButton *chakanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    chakanBtn.frame = CGRectMake(WIDTH/4+10, chongzhiBtn.frame.origin.y, WIDTH - WIDTH/4 - 15, chongzhiBtn.bounds.size.height);
    chakanBtn.backgroundColor = [UIColor redColor];
    [chakanBtn setTitle:@"查看" forState:UIControlStateNormal];
    [chakanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    chakanBtn.layer.cornerRadius = 5;
    chakanBtn.tag = 101;
    [chakanBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weibuView addSubview:chakanBtn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, weibuView.bounds.size.height/15, WIDTH, weibuView.bounds.size.height/6)];
    label.text = @"排量";
    label.font = [UIFont systemFontOfSize:20];
    [weibuView addSubview:label];
    
    NSData *data = [[NSData alloc]initWithContentsOfFile:TIAOJIANXUANCHE];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    bosArr = dic[@"levle"];
    for(int i = 0;i < 6;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH/3 * (i%3), weibuView.bounds.size.height/30*7 * (i/3 + 1), WIDTH/3, weibuView.bounds.size.height/4);
        [button setBackgroundImage:[UIImage imageNamed:@"icon_select_large_nor"] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithString:bosArr[i][@"name"]] forState:UIControlStateNormal];
        button.tag = 500 + i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(jiebieButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [weibuView addSubview:button];
    }
}
/**条件选车中‘重置’和‘查看’按钮的监听*/
-(void)buttonClick:(UIButton *)button
{
    if(button.tag == 100)
    {
        NSLog(@"重置");
    }else
    {
        NSLog(@"查看");
    }
}
/**点击热门选车中的按钮，弹出侧边抽屉*/
-(void)createButton:(UIButton *)sender
{
    UIButton *cover =[[UIButton alloc]init];
    cover.frame = CGRectMake(0, 60, WIDTH, HEIGHT-60);
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(yuyemian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    self.cover = cover;
    [self.view bringSubviewToFront:_cover];
    [self.view bringSubviewToFront:_ceView];
    
    [UIView animateWithDuration:0.5 animations:^{
        //3.1.阴影慢慢显示出来
        cover.alpha = 0.5;
        _ceView.frame = CGRectMake(WIDTH/6, 60, WIDTH/6*5, HEIGHT-109);
    }];
    [self createGetCeData:sender.tag];
}
/**点击阴影，让抽屉弹回去*/
-(void)yuyemian
{
    [UIView animateWithDuration:0.5 animations:^{
        //存放需要执行动画代码
        _ceView.frame = CGRectMake(WIDTH*2, 60, WIDTH/6*5, HEIGHT-109);
        self.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        //动画执行完毕会自动调用这个block内部的代码
        [self.cover removeFromSuperview];
        self.cover = nil;
    }];
    
}
/**底部的scrollView*/
-(void)createScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, WIDTH , HEIGHT-109)];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(0, 0);
}
/**创建tableView*/
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 109)];
    [_scrollView addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.tag = 100;
    [_tableView registerClass:[LPHThreeTableViewCell class] forCellReuseIdentifier:@"LPHThreeTableViewCell"];
    
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 109)];
    [_scrollView addSubview:_tableView1];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.showsHorizontalScrollIndicator = NO;
    _tableView1.showsVerticalScrollIndicator = NO;
    _tableView1.bounces = NO;
    _tableView1.tag = 101;
    [_tableView1 registerClass:[LPHSanTableViewCell class] forCellReuseIdentifier:@"LPHSanTableViewCell"];
    
    _ceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/6*5, _ceScrollView.bounds.size.height)];
    [_ceScrollView addSubview:_ceTableView];
    _ceTableView.delegate = self;
    _ceTableView.dataSource = self;
    _ceTableView.showsHorizontalScrollIndicator = NO;
    _ceTableView.showsVerticalScrollIndicator = NO;
    _ceTableView.bounces = NO;
    _ceTableView.tag = 102;
    [_ceTableView registerClass:[LPHThreeCeTableViewCell class] forCellReuseIdentifier:@"LPHThreeCeTableViewCell"];
    
    _ceTableView1 = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH/6*5, _ceScrollView.bounds.size.height)];
    [_ceScrollView addSubview:_ceTableView1];
    _ceTableView1.delegate = self;
    _ceTableView1.dataSource = self;
    _ceTableView1.showsHorizontalScrollIndicator = NO;
    _ceTableView1.showsVerticalScrollIndicator = NO;
    _ceTableView1.bounces = NO;
    _ceTableView1.tag = 103;
    [_ceTableView1 registerClass:[LPHThreeCeTableViewCell class] forCellReuseIdentifier:@"LPHThreeCeTableViewCell"];
}
/**返回行数*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 101){
        return 1;
    }else if(tableView.tag == 102 || tableView.tag == 103)
    {
        return _ceArray.count;
    }
    return _array.count;
}
/**返回行高*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 101){
        return 210;
    }else if (tableView.tag == 102 || tableView.tag == 103)
    {
        return 70;
    }
    return 60;
}
/**给第一页请求数据*/
-(void)createGetData
{
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:PINPAIXUANCHE parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *tempDic in dic[@"result"]) {
            LPHThreeModel *model = [[LPHThreeModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [_array addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
/**给第一页的cell的点击跳转页请求数据*/
-(void)createGetCeData:(NSInteger)num
{
    _ceArray = [NSMutableArray array];
    NSData *data = [[NSData alloc]initWithContentsOfFile:REMENXUANCHE];
    NSArray *dicArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = dicArr[num];
    for(NSDictionary *tempDic in dic[@"styleList"])
    {
        LPHSanModel *model = [[LPHSanModel alloc]init];
        [model setValuesForKeysWithDictionary:tempDic];
        [_ceArray addObject:model];
    }
    [_ceTableView reloadData];
}
/**将请求到得数据加载到cell上*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 100){
        LPHThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHThreeTableViewCell"];
        if(cell == nil)
        {
            cell = [[LPHThreeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHThreeTableViewCell"];
            //创建位置
        }
        //刷新位置
        [cell relayoutWithModel:_array[indexPath.row]];
        return cell;
    }else if (tableView.tag == 102 || tableView.tag == 103){
        LPHThreeCeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHThreeCeTableViewCell"];
        if(cell == nil)
        {
            cell = [[LPHThreeCeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHThreeCeTableViewCell"];
        }
        [cell relayoutWithModel:_ceArray[indexPath.row]];
        return cell;
    }
    LPHSanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHSanTableViewCell"];
    if(cell == nil)
    {
        cell = [[LPHSanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHSanTableViewCell"];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, WIDTH, 40)];
    label.text = @"国别";
    label.font = [UIFont systemFontOfSize:20];
    [cell addSubview:label];
    NSData *data = [[NSData alloc]initWithContentsOfFile:TIAOJIANXUANCHE];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    bosArr = dic[@"series"];
    for(int i = 0;i < 7;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5 + (WIDTH-5)/3* (i %3), 45 + 55 * (i / 3), (WIDTH-20)/3, 50);
        [button setBackgroundImage:[UIImage imageNamed:@"icon_select_large_nor"] forState:UIControlStateNormal];
        [button setTitle:bosArr[i][@"name"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 700 + i;
        [button addTarget:self action:@selector(jiebieButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(button.bounds.size.width/3*2, 30, button.bounds.size.width/3, 20)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:bosArr[i][@"icon"]]];
        [button addSubview:imageView];
    }
    return cell;
}
/**第一页cell的点击监听*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 100){
        UIButton *cover =[[UIButton alloc]init];
        cover.frame = CGRectMake(0, 60, WIDTH, HEIGHT-60);
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.0;
        [cover addTarget:self action:@selector(yuyemian) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cover];
        self.cover = cover;
        [self.view bringSubviewToFront:_cover];
        [self.view bringSubviewToFront:_ceView];
        
        [UIView animateWithDuration:0.5 animations:^{
            //3.1.阴影慢慢显示出来
            cover.alpha = 0.5;
            _ceView.frame = CGRectMake(WIDTH/6, 60, WIDTH/6*5, HEIGHT-109);
        }];
        [self createGetCeData:indexPath.row+8];
    }
}
@end
