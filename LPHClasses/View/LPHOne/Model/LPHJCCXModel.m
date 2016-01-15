//
//  LPHJCCXModel.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/14.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHJCCXModel.h"

@implementation LPHJCCXModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        self.series_group_name=dic[@"series_group_name"];
        self.series_id=dic[@"series_id"];
        self.series_name=dic[@"series_name"];
    }
    return self;
}

@end
