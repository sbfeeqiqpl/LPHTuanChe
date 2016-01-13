//
//  LPHFiveModel.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHFiveModel : NSObject

@property (nonatomic,copy) NSString *logo;

@property (nonatomic,copy) NSString *title;

+(instancetype)itemWithTitle:(NSString *)title andLogo:(NSString *)logo;

@end
