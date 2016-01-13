//
//  LPHFirstTableViewCell.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPHFirstModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface LPHFirstTableViewCell : UITableViewCell

@property (assign,nonatomic)int index;

@property (strong, nonatomic) UIImageView *iconImage;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *prefixLabel;
@property (strong, nonatomic) UILabel *suffixLabel;
@property (strong, nonatomic) UILabel *numLabel;

-(void)relayoutWithModel:(LPHFirstModel *)model;

@end
