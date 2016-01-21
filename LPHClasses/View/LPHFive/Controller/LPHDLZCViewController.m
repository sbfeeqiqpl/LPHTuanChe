//
//  LPHDLZCViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/19.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHDLZCViewController.h"
#import "LPHZCViewController.h"
#import "XMPPFramework.h"
#import "LPHXXViewController.h"

#define HOST @"1000phone.net"
@interface LPHDLZCViewController ()<UIAlertViewDelegate>
{
    XMPPStream *_stream;
    IBOutlet UITextField *_nameField;
    IBOutlet UITextField *_passwordField;
}
@end

@implementation LPHDLZCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _stream = [[XMPPStream alloc]init];
    //
    [_stream setHostName:HOST];
    //
    [_stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fanhui {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**上线*/
-(void)goOnline
{
    //<presence/>上线消息
    XMPPPresence *presence = [XMPPPresence presence];
    //发送出去
    [_stream sendElement:presence];
}
/**下线*/
-(void)goOffline
{
    //<presence type = "unavailable"/>
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [_stream sendElement:presence];
    //断开
    [_stream disconnect];
}
- (IBAction)login {
    //如果已经连接，先断开
    if(_stream.isConnected)
    {
        [self goOffline];
    }
    //希望登录的账号
    NSString *jid = [NSString stringWithFormat:@"%@@%@",_nameField.text,HOST];
    _stream.tag = @"登录";
    //设置jid
    [_stream setMyJID:[XMPPJID jidWithString:jid]];
    //连接
    [_stream connectWithTimeout:30 error:nil];
}
/**连接成功*/
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"连接成功");
    if([sender.tag isEqualToString:@"登录"])
    {
        //验证密码
        [_stream authenticateWithPassword:_passwordField.text error:nil];
    }
    if(_nameField.text.length == 0 && _passwordField.text.length == 0)
    {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"账号或密码为空" delegate:self cancelButtonTitle:@"不登了" otherButtonTitles:@"再试试",nil];
        [av show];
    }
}
/**登录成功*/
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"登录成功");
    [self goOnline];
    LPHXXViewController *LPHXX = [[LPHXXViewController alloc]init];
    [self presentViewController:LPHXX animated:YES completion:nil];
}
/**登录失败*/
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"账号或密码错误" delegate:self cancelButtonTitle:@"不登了" otherButtonTitles:@"再试试",nil];
    [av show];
}
- (IBAction)reg {
    LPHZCViewController *lphzc = [[LPHZCViewController alloc]init];
    [self presentViewController:lphzc animated:YES completion:nil];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        _passwordField.text = @"";
    }
}



@end
