//
//  LPHCityModel.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHCityModel : NSObject


@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *pname;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *pinyin;

@property (nonatomic, copy) NSString *py;

-(void)setValue:(id)value forKey:(NSString *)key;

@end
