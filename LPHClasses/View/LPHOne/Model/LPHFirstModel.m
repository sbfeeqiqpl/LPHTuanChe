//
//  LPHFirstModel.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHFirstModel.h"

@implementation LPHFirstModel

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
