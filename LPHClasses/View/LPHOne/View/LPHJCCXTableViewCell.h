//
//  LPHJCCXTableViewCell.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/14.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "LPHJCCXModel.h"
#import "UIImageView+WebCache.h"

@interface LPHJCCXTableViewCell : UITableViewCell

@property (assign,nonatomic)int index;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *logo;

-(void)relayoutWithModel:(LPHJCCXModel *)model;

@end
