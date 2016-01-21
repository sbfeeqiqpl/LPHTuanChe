//
//  LPHZCViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/19.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHZCViewController.h"
#import "XMPPFramework.h"

#define HOST @"1000phone.net"
@interface LPHZCViewController ()<UIAlertViewDelegate>
{
    XMPPStream *_stream;
    IBOutlet UITextField *_nameField;
    IBOutlet UITextField *_passwordField;
    IBOutlet UITextField *_nickNameField;
    IBOutlet UITextField *_emaliField;
}
@end

@implementation LPHZCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _stream = [[XMPPStream alloc]init];
    //
    [_stream setHostName:HOST];
    //
    [_stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
- (IBAction)fanhui {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)zhuce {
    //如果已经连接，先断开
    if(_stream.isConnected)
    {
        [self goOffline];
    }
    //希望注册的账号
    NSString *jid = [NSString stringWithFormat:@"%@@%@",_nameField.text,HOST];
    _stream.tag = @"注册";
    //设置jid
    [_stream setMyJID:[XMPPJID jidWithString:jid]];
    //连接
    [_stream connectWithTimeout:30 error:nil];
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
/**连接成功*/
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"连接成功");
    if(![self isValidatePhone:_nameField.text]){
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"注册失败" message:@"手机号不合法，注册失败" delegate:self cancelButtonTitle:@"取消注册" otherButtonTitles:@"继续注册", nil];
        [av show];
    }else{
        if(_passwordField.text.length!=0 && _nickNameField.text.length !=0 && _emaliField.text.length !=0){
            if([sender.tag isEqualToString:@"注册"])
            {
                //注册
                [_stream registerWithPassword:_passwordField.text error:nil];
            }
        }else
        {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"注册失败" message:@"资料不完整，注册失败" delegate:self cancelButtonTitle:@"取消注册" otherButtonTitles:@"继续注册", nil];
            [av show];
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        _nameField.text = @"";
        _passwordField.text = @"";
    }
}
/**注册成功*/
-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"注册成功" message:@"恭喜注册成功" delegate:self cancelButtonTitle:@"去登陆" otherButtonTitles:nil];
    [av show];
}
/**注册失败*/
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"注册失败" message:@"账号已存在" delegate:self cancelButtonTitle:@"取消注册" otherButtonTitles:@"继续注册", nil];
    [av show];
}
#pragma mark 收起键盘
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击屏幕其他地方就可以收起键盘
    [_nameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_nickNameField resignFirstResponder];
    [_emaliField resignFirstResponder];
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
-(BOOL)isValidatePhone:(NSString *)phone
{
    NSString *phoneRegex = @"^(13[0-9]|15[0|1|2|3|5|6|7|8|9]|18[0-9]|14[5|7]|17[0|8])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

@end
