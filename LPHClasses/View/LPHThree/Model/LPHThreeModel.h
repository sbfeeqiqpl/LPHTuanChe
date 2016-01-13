
//
//  LPHThreeModel.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHThreeModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *penname;

@property (nonatomic, copy) NSString *pinyin;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *logo;

-(void)setValue:(id)value forKey:(NSString *)key;

@end
