//
//  LPHFiveGroupModel.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHFiveGroupModel : NSObject

@property (nonatomic,copy) NSString *header;

@property (nonatomic,copy) NSString *footer;

@property (strong, nonatomic) NSArray *groupArray;

+(instancetype)group;

@end
