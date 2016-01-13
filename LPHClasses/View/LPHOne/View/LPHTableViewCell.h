//
//  LPHTableViewCell.h
//  LPHTuanChe
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPHOneModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface LPHTableViewCell : UITableViewCell

@property (assign,nonatomic)int index;

@property (strong, nonatomic) UIImageView *iconImage;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *prefixLabel;
@property (strong, nonatomic) UILabel *suffixLabel;
@property (strong, nonatomic) UILabel *numLabel;

-(void)relayoutWithModel:(LPHOneModel *)model;

@end
