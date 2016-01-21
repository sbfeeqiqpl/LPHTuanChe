//
//  LPHXXViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/19.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHXXViewController.h"
#import "LPHKmagn.h"
#import "XMPPFramework.h"

#define HOST @"1000phone.net"
@interface LPHXXViewController ()<UIAlertViewDelegate,XMPPStreamDelegate>
{
    XMPPStream *_stream;
    UIView *LTView;
    UITextField *_friendField;
    UITextField *_sendField;
    UILabel *XXlabel;
}

@end

@implementation LPHXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _stream = [[XMPPStream alloc]init];
    //
    [_stream setHostName:HOST];
    //
    [_stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [self createView];
    [self createLTView];
    
}
-(void)createView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40 )];
    headView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [self.view addSubview:headView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 5, 40, 30);
    [button setTitle:@"退出" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/4, 5, WIDTH/2, 30)];
    label.text = @"聊天";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [headView addSubview:label];
}
- (void)tuichu{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"不再聊会了？" message:nil delegate:self cancelButtonTitle:@"不聊了" otherButtonTitles:@"再聊聊",nil];
    [av show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)createLTView
{
    LTView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60)];
    LTView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:0.9];
    [self.view addSubview:LTView];
    _friendField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, WIDTH - 100, 30)];
    _friendField.backgroundColor = [UIColor whiteColor];
    _friendField.placeholder = @"请输入要加好友的账号";
    _friendField.layer.cornerRadius = 5;
    [LTView addSubview:_friendField];
    
    _sendField = [[UITextField alloc]initWithFrame:CGRectMake(30, 90, WIDTH-100, 30)];
    _sendField.backgroundColor = [UIColor whiteColor];
    _sendField.placeholder = @"请输入您要发送的消息";
    _sendField.layer.cornerRadius = 5;
    [LTView addSubview:_sendField];
    
    UIButton *addFriend = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addFriend.frame = CGRectMake(WIDTH-70, 30, 40, 30);
    [addFriend setTitle:@"添加" forState:UIControlStateNormal];
    [addFriend setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addFriend addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    [LTView addSubview:addFriend];
    
    UIButton *faSong = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    faSong.frame = CGRectMake(WIDTH-70, 90, 40, 30);
    [faSong setTitle:@"发送" forState:UIControlStateNormal];
    [faSong setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [faSong addTarget:self action:@selector(faSongButton) forControlEvents:UIControlEventTouchUpInside];
    [LTView addSubview:faSong];
    
    XXlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, WIDTH-20, 30)];
    XXlabel.font = [UIFont systemFontOfSize:18];
    XXlabel.backgroundColor = [UIColor whiteColor];    
    [LTView addSubview:XXlabel];
}
/**上线*/
-(void)goOnline
{
    //<presence/>上线消息
    XMPPPresence *presence = [XMPPPresence presence];
    //发送出去
    [_stream sendElement:presence];
}
#pragma mark 添加好友
-(void)addFriend
{
    NSString *jid = [NSString stringWithFormat:@"%@@%@",_friendField.text,HOST];
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"subscribe" to:[XMPPJID jidWithString:jid]];
    [_stream sendElement:presence];
}
#pragma mark 发送消息
-(void)faSongButton
{
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",_friendField.text,HOST]]];
    NSXMLElement  *body = [NSXMLElement elementWithName:@"body" stringValue:_sendField.text];
    [message addChild:body];
    [_stream sendElement:message];
}
/**message*/
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    XXlabel.text = @"";
    NSLog(@"%@:%@",message.fromStr,message.stringValue);
    XXlabel.text = [NSString stringWithFormat:@"%@",message.stringValue];
}
/**接收到iq*/
-(BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    /**
     <iq>
     <query>
     <item jid = "">
     <item jid = "">
     </query>
     </iq>
     */
    NSXMLElement *query = iq.children[0];
    for(NSXMLElement *item in [query children])
    {
        NSXMLElement *jid = item.attributes[0];
        NSLog(@"%@",jid.stringValue);
    }
    return YES;
}
/**接收到一个presence*/
-(void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    /**判断是否有人要加自己为好友*/
    if([presence.type isEqualToString:@"subscribe"])
    {
        /**同意*/
        /**
         <presence type = "subscribed" to = "jid">
         */
        XMPPPresence *pre = [XMPPPresence presenceWithType:@"subscribed" to:presence.from];
        [_stream sendElement:pre];
        NSLog(@"同意%@加为好友",presence.fromStr);
    }
    /**判断对方是否已经同意自己的好友请求*/
    if([presence.type isEqualToString:@"subscribed"])
    {
        NSLog(@"%@已经同意了您的好友请求",presence.fromStr);
    }
    
}
@end
