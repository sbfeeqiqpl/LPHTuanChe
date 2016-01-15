//
//  LPHJCCXModel.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/14.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHJCCXModel : NSObject

@property (nonatomic, copy) NSString *series_name;

@property (nonatomic, copy) NSString *series_id;

@property (nonatomic, copy) NSString *series_group_name;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
