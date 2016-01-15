//
//  LPHJCViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHJCViewController.h"
#import "LPHKmagn.h"
#import "LPHGJViewController.h"
#import "LPHJCCityViewController.h"
#import "AppDelegate.h"

@interface LPHJCViewController ()<UIPickerViewDelegate,UITextFieldDelegate>
{
    UIView *view;
    UIView *timerView;
    UITextField *timerField;
    UITextField *journey;
    UITextField *cityField;
    UITextField *_textField;
}

@property (weak, nonatomic) UIButton *cover;

@property (strong,nonatomic) UIDatePicker *datePicker;

@property (copy,nonatomic) NSString *destDateString;

@end

@implementation LPHJCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self createView];
    [self createbutton];
    [self createCityButton];
    [self createTimerViewBtn];
}
-(void)createView
{
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT-20)];
    view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1];
    [self.view addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2, 40)];
    titleLabel.text = @"旧车估价";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, WIDTH, 1)];
    lab.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lab];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 13, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    timerView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, HEIGHT/3)];
    [self.view addSubview:timerView];
    timerView.backgroundColor = [UIColor whiteColor];
}
-(void)createTimerViewBtn
{
    UIButton *quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiaoBtn.frame = CGRectMake(10, 0, WIDTH/8, HEIGHT/21);
    [quxiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
    [quxiaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [quxiaoBtn addTarget:self action:@selector(quxiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [timerView addSubview:quxiaoBtn];
    
    UIButton *quedingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quedingBtn.frame = CGRectMake(WIDTH/8*7-10, 0, WIDTH/8, HEIGHT/21);
    [quedingBtn setTitle:@"确定" forState:UIControlStateNormal];
    [quedingBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [quedingBtn addTarget:self action:@selector(quedingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [timerView addSubview:quedingBtn];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, quedingBtn.frame.origin.y + HEIGHT/21, WIDTH, 1)];
    lab.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1];
    [timerView addSubview:lab];
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, timerView.bounds.size.height/7, WIDTH, HEIGHT/21*6)];
    [_datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    _datePicker.datePickerMode=UIDatePickerModeDate;
    _datePicker.layer.cornerRadius=10;
    _datePicker.backgroundColor=[UIColor colorWithRed:235/255.0f green:231/255.0f blue:213/255.0f alpha:0.3];
    [timerView addSubview:_datePicker];
}
-(void)fanhuiBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)createCityButton
{
    cityField = [[UITextField alloc]initWithFrame:CGRectMake(10, 185, WIDTH-20, 30)];
    cityField.placeholder = @"请选择所在城市";
    cityField.borderStyle = UITextBorderStyleRoundedRect;
    [view addSubview:cityField];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:@"icon_arraw_right"];
    cityField.rightViewMode = UITextFieldViewModeAlways;
    cityField.rightView = imageView;
    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cityBtn.frame = CGRectMake(10, 185, WIDTH-20, 30);
    [cityBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cityBtn];
    /**行驶总里程*/
    journey = [[UITextField alloc]initWithFrame:CGRectMake(10, 235, WIDTH-20, 30)];
    journey.placeholder = @"请输入里程数";
    journey.borderStyle = UITextBorderStyleRoundedRect;
    journey.delegate = self;
    [view addSubview:journey];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    label.text = @"万公里";
    journey.rightViewMode = UITextFieldViewModeAlways;
    journey.rightView = label;
    
    UIButton *guzhiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    guzhiBtn.frame = CGRectMake(10, 305, WIDTH-20, 40);
    guzhiBtn.backgroundColor = [UIColor redColor];
    guzhiBtn.layer.cornerRadius = 5;
    [guzhiBtn setTitle:@"开始估值" forState:UIControlStateNormal];
    [guzhiBtn addTarget:self action:@selector(guzhiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:guzhiBtn];
}
#pragma mark 车型和上牌照时间
-(void)createbutton
{
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 85, WIDTH-20, 30)];
    _textField.placeholder = @"请输入车型";
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [view addSubview:_textField];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:@"icon_arraw_right"];
    _textField.rightViewMode = UITextFieldViewModeAlways;
    _textField.rightView = imageView;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 85, WIDTH-20, 30);
    [button addTarget:self action:@selector(chexingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    timerField = [[UITextField alloc]initWithFrame:CGRectMake(10, 135, WIDTH - 20, 30)];
    timerField.placeholder = @"请选择挂牌日期";
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView1.image = [UIImage imageNamed:@"icon_arraw_right"];
    timerField.borderStyle = UITextBorderStyleRoundedRect;
    timerField.rightViewMode = UITextFieldViewModeAlways;
    timerField.rightView = imageView1;
    [view addSubview:timerField];
    UIButton *timerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timerButton.frame = CGRectMake(10, 135, WIDTH-20, 30);
    [timerButton addTarget:self action:@selector(timerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:timerButton];
}
#pragma mark 选择车型
-(void)chexingBtnClick
{
    LPHGJViewController *lphgj = [[LPHGJViewController alloc]init];
    [lphgj setBlock:^(NSString *carName) {
        _textField.text = carName;
    }];
    [self presentViewController:lphgj animated:YES completion:^{
    }];
}
#pragma mark 选择上牌日期
-(void)timerBtnClick
{
    UIButton *cover =[[UIButton alloc]init];
    cover.frame = CGRectMake(0, 60, WIDTH, HEIGHT-60);
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(quxiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    self.cover = cover;
    [self.view bringSubviewToFront:_cover];
    [self.view bringSubviewToFront:timerView];
    [UIView animateWithDuration:0.5 animations:^{
        //3.1.阴影慢慢显示出来
        cover.alpha = 0.2;
        timerView.frame = CGRectMake(0, HEIGHT/3*2, WIDTH, HEIGHT/3);
    }];
}
#pragma mark 取消选择上牌
-(void)quxiaoBtnClick
{
    [UIView animateWithDuration:0.2 animations:^{
        //存放需要执行动画代码
        timerView.frame = CGRectMake(0, HEIGHT, WIDTH, HEIGHT/3);
        self.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        //动画执行完毕会自动调用这个block内部的代码
        [self.cover removeFromSuperview];
        self.cover = nil;
    }];
}
#pragma mark 选择城市
-(void)cityBtnClick
{
    LPHJCCityViewController *lphjcCity = [[LPHJCCityViewController alloc]init];
    [lphjcCity setBlock:^(NSString *city) {
        cityField.text = city;
    }];
    [self presentViewController:lphjcCity animated:YES completion:^{
    }];
}
#pragma mark 确定选择上牌时间
-(void)quedingBtnClick:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _destDateString = [dateFormatter stringFromDate:_datePicker.date];
    timerField.text = _destDateString;
    
    [self quxiaoBtnClick];
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return HEIGHT/21*2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 3;
}
#pragma mark 开始估值
-(void)guzhiBtnClick
{
    NSLog(@"暂未实现");
}
#pragma mark 收起键盘
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击屏幕其他地方就可以收起键盘
    [journey resignFirstResponder];
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
@end
