//
//  LPHThreeModel.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHThreeModel.h"

@implementation LPHThreeModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        _ID = [value integerValue];
        return;
    }
    [super setValue:value forKey:key];
}

@end
