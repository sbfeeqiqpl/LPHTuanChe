//
//  LPHFiveModel.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHFiveModel.h"

@implementation LPHFiveModel

+(instancetype)itemWithTitle:(NSString *)title andLogo :(NSString *)logo
{
    LPHFiveModel *model = [[LPHFiveModel alloc]init];
    model.logo = logo;
    model.title = title;
    
    return model;
}

@end
