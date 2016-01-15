//
//  LPHGJViewController.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^carNameblock)(NSString *carName);

@interface LPHGJViewController : UIViewController

@property (strong, nonatomic) carNameblock block;

-(void)setBlock:(carNameblock)block;

@end
