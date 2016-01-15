//
//  LPHJCCityViewController.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cityNameblock)(NSString *city);

@interface LPHJCCityViewController : UIViewController

@property (strong, nonatomic) cityNameblock block;

@property (strong,nonatomic)NSMutableArray *cityNameArray;

-(void)setBlock:(cityNameblock)block;

@end
