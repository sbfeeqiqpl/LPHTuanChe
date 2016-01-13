//
//  LPHOneViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 李鹏辉. All rights reserved.
//

#import "LPHOneViewController.h"
#import "LPHTableViewCell.h"
#import "LPHKmagn.h"
#import "LPHFirstViewController.h"
#import "AppDelegate.h"
#import "LPHCityViewController.h"
#import "LPHQiDaiViewController.h"
#import "LPHThreeViewController.h"
#import "LPHJCViewController.h"
#import "LPHTuanGouViewController.h"
#import "LPHWeiZhangViewController.h"

@interface LPHOneViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    AppDelegate *app;
    UIView *_view;
    UIView *shouyeView;
    UIButton *hunyingBtn;
    NSArray *jsonArr;
    UILabel *label1;
    UILabel *cityLabel;
}
@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *array;

@property (strong,nonatomic)UITextField *textField;

@end

@implementation LPHOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createButton];
    [self createTableView];
    [self createUI];
    [self createImage];
    [self createButtons];
    [self createLink];
    [self createGetData];
}
#pragma mark 状态栏下得快速导航
-(void)createView
{
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40)];
    _view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_view];
}
#pragma mark 导航了上的按钮和搜索框
-(void)createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, 5, 50, 30);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cityClick:) forControlEvents:UIControlEventTouchDown];
    [_view addSubview:button];
    cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    cityLabel.text = @"西安";
    [button addSubview:cityLabel];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(60, 5, WIDTH - 120, 30)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"请输入品牌、车型";
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    [_view addSubview:_textField];
    
    UIButton *saoma = [UIButton buttonWithType:UIButtonTypeCustom];
    saoma.frame = CGRectMake(WIDTH-40, 5, 30, 30);
    [saoma setBackgroundImage:[UIImage imageNamed:@"icon_top_icon_saomiao"] forState:UIControlStateNormal];
    [saoma addTarget:self action:@selector(saomaClick) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:saoma];
}
#pragma mark 城市按钮的监听
-(void)cityClick:(UIButton *)sender
{
    
    LPHCityViewController *LPHCith = [[LPHCityViewController alloc]init];
    [LPHCith setBlock:^(NSString *city) {
        cityLabel.text = city;
    }];
    [self presentViewController:LPHCith animated:YES completion:^{
    }];
}
#pragma mark 扫码按钮的监听
-(void)saomaClick
{
//    NSLog(@"请将你的脸放入扫描区");
    ZBarReaderController* zbarController = [[ZBarReaderController alloc] init];
    zbarController.delegate = self;
    [self presentViewController:zbarController animated:YES completion:^{
        
    }];
    
}
#pragma mark 最后得到的结果
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    //最后得到的结果
    NSLog(@"%@",symbol.data);
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT - 109)];
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
#pragma mark tableView的头部
-(void)createUI
{
    shouyeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/10*9)];
    _tableView.tableHeaderView = shouyeView;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/5)];
    [shouyeView addSubview:imageView];
    NSString *str = TOUTIAO;
    [imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    UIButton *toutiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/5)];
    [toutiaoBtn addTarget:self action:@selector(toutiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shouyeView addSubview:toutiaoBtn];
    
    NSArray *arr = @[DIJIA,DAIKUAN,ZUIXIN,JIAYOU,BAOXIAN,WEIZHANG,GUJIA,QIDAI];
    NSArray *labelArr = @[@"底价购车",@"汽车贷款",@"最新车型",@"加油充值",@"保险比价",@"违章查询",@"旧车估价",@"敬请期待"];
    for(int i = 0;i < 8;i++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake((WIDTH)/4 * (i%4)+(WIDTH - (HEIGHT/2-HEIGHT/14))/4, HEIGHT/5 + HEIGHT/100 + HEIGHT/8 * (i / 4), HEIGHT/14, HEIGHT/14);
        [shouyeView addSubview:imageView];
        NSString *str = arr[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:str]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH)/4 * (i%4)+(WIDTH-280)/8, HEIGHT/5+HEIGHT/8-20 + HEIGHT/8 * (i / 4), 70, 20)];
        label.text = labelArr[i];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [shouyeView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((WIDTH)/4 * (i%4), HEIGHT/5 + HEIGHT/8 * (i / 4), WIDTH/4, HEIGHT/8);
        button.tag = 100 + i;
        [button addTarget:self action:@selector(createButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [shouyeView addSubview:button];
    }
    UILabel *colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT/5+HEIGHT/4,WIDTH , HEIGHT/120)];
    colorLabel.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [shouyeView addSubview:colorLabel];
}
-(void)toutiaoBtnClick
{
    LPHThreeViewController *lphtvc = [[LPHThreeViewController alloc]init];
    [self presentViewController:lphtvc animated:YES completion:^{
    }];
}
#pragma mark 几个热门的链接
-(void)createImage
{
    NSData *data = [[NSData alloc]initWithContentsOfFile:XINBANBEN];
    jsonArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, HEIGHT/5 + HEIGHT/4+HEIGHT/120+HEIGHT/14, WIDTH/2-1, HEIGHT/8)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:jsonArr[0][@"iconUrl"]]];
    [shouyeView addSubview:imageView];
    UILabel *hunyingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,  HEIGHT/5 + HEIGHT/4+HEIGHT/120, WIDTH/2, HEIGHT/24)];
    hunyingLabel.font = [UIFont systemFontOfSize:HEIGHT/30];
    hunyingLabel.text = @"婚姻座驾";
    hunyingLabel.textColor = [UIColor orangeColor];
    hunyingLabel.textAlignment = NSTextAlignmentCenter;
    [shouyeView addSubview:hunyingLabel];
    hunyingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hunyingBtn.frame = CGRectMake(0, HEIGHT/5 + HEIGHT/4+HEIGHT/120, WIDTH/2, HEIGHT/5);
    hunyingBtn.tag = 1000;
    [hunyingBtn setTitle:@"给她最好的" forState:UIControlStateNormal];
    hunyingBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT/40];
    [hunyingBtn setTitleColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1] forState:UIControlStateNormal];
    hunyingBtn.titleEdgeInsets = UIEdgeInsetsMake(-HEIGHT/10, 0, 0, 0);
    [hunyingBtn addTarget:self action:@selector(createBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shouyeView addSubview:hunyingBtn];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-1, HEIGHT/5 + HEIGHT/4 + HEIGHT/120, 2, HEIGHT/5)];
    lab.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [shouyeView addSubview:lab];
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, hunyingBtn.frame.origin.y + HEIGHT/5, WIDTH, 1)];
    label1.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [shouyeView addSubview:label1];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, hunyingBtn.frame.origin.y + HEIGHT/10, WIDTH/2, 1)];
    label2.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [shouyeView addSubview:label2];
    
    UILabel *hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, shouyeView.bounds.size.height - HEIGHT/40*3 - 1, WIDTH, HEIGHT/40*3)];
    hotLabel.text = @"热门车型";
    hotLabel.font = [UIFont boldSystemFontOfSize:20];
    hotLabel.textColor = [UIColor blackColor];
    [shouyeView addSubview:hotLabel];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, hotLabel.frame.origin.y + HEIGHT/120, WIDTH, HEIGHT/120)];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [shouyeView addSubview:label];
    
    UILabel *labelXia = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT/10*9-1, WIDTH, 1)];
    labelXia.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.1];
    [shouyeView addSubview:labelXia];
}
-(void)createButtons
{
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/4*3, hunyingBtn.frame.origin.y, WIDTH/4, HEIGHT/10)];
    [imageView2 sd_setImageWithURL:[NSURL URLWithString:jsonArr[1][@"iconUrl"]]];
    [shouyeView addSubview:imageView2];
    UILabel *mamiLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2+10, imageView2.frame.origin.y + HEIGHT/50, WIDTH/4, HEIGHT/30)];
    mamiLabel.text = @"妈咪购车";
    mamiLabel.font = [UIFont systemFontOfSize:HEIGHT/36];
    mamiLabel.textColor = [UIColor redColor];
    [shouyeView addSubview:mamiLabel];
    UIButton *mamiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mamiBtn.frame = CGRectMake(WIDTH/2, hunyingBtn.frame.origin.y, WIDTH/2, HEIGHT/10);
    [mamiBtn setTitle:@"温馨驾道" forState:UIControlStateNormal];
    mamiBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT/40];
    [mamiBtn setTitleColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1] forState:UIControlStateNormal];
    mamiBtn.titleEdgeInsets = UIEdgeInsetsMake(HEIGHT/40, -WIDTH/4, 0, 0);
    mamiBtn.tag = 1001;
    [mamiBtn addTarget:self action:@selector(createBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shouyeView addSubview:mamiBtn];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/4*3, hunyingBtn.frame.origin.y + HEIGHT/10, WIDTH/4, HEIGHT/10)];
    [imageView3 sd_setImageWithURL:[NSURL URLWithString:jsonArr[5][@"iconUrl"]]];
    [shouyeView addSubview:imageView3];
    UILabel *zijiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2+10, imageView3.frame.origin.y + HEIGHT/50, WIDTH/4, HEIGHT/30)];
    zijiaLabel.text = @"自驾旅行";
    zijiaLabel.font = [UIFont systemFontOfSize:HEIGHT/36];
    zijiaLabel.textColor = [UIColor blueColor];
    [shouyeView addSubview:zijiaLabel];
    UIButton *zijiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zijiaBtn.frame = CGRectMake(WIDTH/2, hunyingBtn.frame.origin.y + HEIGHT/10, WIDTH/2, HEIGHT/10);
    [zijiaBtn setTitle:@"说走就走" forState:UIControlStateNormal];
    zijiaBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT/40];
    [zijiaBtn setTitleColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1] forState:UIControlStateNormal];
    zijiaBtn.titleEdgeInsets = UIEdgeInsetsMake(HEIGHT/40, -WIDTH/4, 0, 0);
    zijiaBtn.tag = 1002;
    [zijiaBtn addTarget:self action:@selector(createBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shouyeView addSubview:zijiaBtn];
}
-(void)createLink
{
    for(int i = 0;i < 3;i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/3 * (i%3) + WIDTH/24, label1.frame.origin.y + HEIGHT/15, WIDTH/4, HEIGHT/10)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:jsonArr[2 + i][@"iconUrl"]]];
        [shouyeView addSubview:imageView];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3 * (i%3), imageView.frame.origin.y-HEIGHT/15, WIDTH/3, HEIGHT/20)];
        label.text = jsonArr[i+2][@"bigTitle"];
        label.font = [UIFont boldSystemFontOfSize:HEIGHT/36];
        label.textAlignment = NSTextAlignmentCenter;
        [shouyeView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH/3 * (i%3), label1.frame.origin.y+1, WIDTH/3, HEIGHT/240*41);
        [button setTitle:jsonArr[2 + i][@"subTitle"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(-HEIGHT/15, 0, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:HEIGHT/40];
        button.tag = 1003 + i;
        [button addTarget:self action:@selector(createBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [shouyeView addSubview:button];
    }
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3, label1.frame.origin.y, 1, HEIGHT/120*21)];
    lab1.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [shouyeView addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3*2, label1.frame.origin.y, 1, HEIGHT/120*21)];
    lab2.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [shouyeView addSubview:lab2];
}
#pragma mark 几个热门按钮的监听
-(void)createBtnClick:(UIButton *)sender
{
    app = [UIApplication sharedApplication].delegate;
    app.chioce = sender.tag;
    LPHFirstViewController *LPHFirst = [[LPHFirstViewController alloc]init];
    [self presentViewController:LPHFirst animated:YES completion:^{
    }];
}
#pragma mark tableView头部的几个按钮的监听
-(void)createButtonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
        {
            LPHThreeViewController *lphtvc = [[LPHThreeViewController alloc]init];
            [self presentViewController:lphtvc animated:YES completion:^{
            }];
            break;
        }
        case 101:
                {
                    LPHQiDaiViewController *lphDaiKuan = [[LPHQiDaiViewController alloc]init];
                    [self presentViewController:lphDaiKuan animated:YES completion:^{
                    }];
                    break;
                }
        case 102:
            NSLog(@"%ld",sender.tag);
            break;
        case 103:
        case 104:
        case 105:
        {
            app = [UIApplication sharedApplication].delegate;
            app.tagId = sender.tag;
            LPHWeiZhangViewController *lphwz = [[LPHWeiZhangViewController alloc]init];
            [self presentViewController:lphwz animated:YES completion:^{
            }];
            break;
        }
        case 106:
                {
                    LPHJCViewController *lphjcgj = [[LPHJCViewController alloc]init];
                    [self presentViewController:lphjcgj animated:YES completion:^{
                        
                    }];
                    break;
                }
        case 107:
            NSLog(@"%ld",sender.tag);
            break;
            
        default:
            break;
    }
}
#pragma mark 请求数据
-(void)createGetData
{
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:SHOUYE parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
#pragma mark 将数据加载到cell上
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
#pragma mark 收起键盘
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击屏幕其他地方就可以收起键盘
    [_textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
#pragma mark cell的监听
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPHTuanGouViewController *lphtg = [[LPHTuanGouViewController alloc]init];
    [self presentViewController:lphtg animated:YES completion:^{
    }];
}
@end
