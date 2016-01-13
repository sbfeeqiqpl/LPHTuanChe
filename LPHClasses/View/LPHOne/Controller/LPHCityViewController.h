//
//  LPHCityViewController.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cityblock)(NSString *city);
@interface LPHCityViewController : UIViewController

@property (strong, nonatomic) cityblock block;

@property (strong,nonatomic)NSMutableArray *cityArray;

-(void)setBlock:(cityblock)block;

@end
