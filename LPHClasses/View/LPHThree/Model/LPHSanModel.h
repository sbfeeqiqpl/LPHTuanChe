//
//  LPHSanModel.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHSanModel : NSObject

#pragma mark 抽屉上cell的数据模型
@property (nonatomic, copy) NSString *carModelPrices;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *prefix;

@property (nonatomic, copy) NSString *suffix;

@property (nonatomic, copy) NSString *styleName;

@property (nonatomic, assign) NSInteger identify;

@property (nonatomic, assign) NSInteger manNum;

@property (nonatomic, copy) NSString *factoryPrice;

@property (nonatomic, assign) NSInteger firmBrandId;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, assign) NSInteger brandId;

@property (nonatomic, assign) NSInteger isNew;

@property (nonatomic, copy) NSString *levelStr;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, assign) NSInteger isBuy;

@property (nonatomic, copy) NSString *content;

-(void)setValue:(id)value forKey:(NSString *)key;

@end
