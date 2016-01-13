//
//  LPHCityTableViewCell.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "LPHCityModel.h"

@interface LPHCityTableViewCell : UITableViewCell

@property (assign,nonatomic)int index;

@property (strong, nonatomic) UILabel *titleLabel;

-(void)relayoutWithModel:(LPHCityModel *)model;

@end
