//
//  LPHThreeCeTableViewCell.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "LPHSanModel.h"
#import "UIImageView+WebCache.h"

@interface LPHThreeCeTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *logo;

@property (nonatomic,strong) UILabel *styleName;

@property (nonatomic,strong) UILabel *factoryPrice;

-(void)relayoutWithModel:(LPHSanModel *)model;

@end
