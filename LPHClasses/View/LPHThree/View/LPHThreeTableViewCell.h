//
//  LPHThreeTableViewCell.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "LPHThreeModel.h"
#import "UIImageView+WebCache.h"

@interface LPHThreeTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;

@property (strong, nonatomic) UILabel *nameLabel;

-(void)relayoutWithModel:(LPHThreeModel *)model;

@end
