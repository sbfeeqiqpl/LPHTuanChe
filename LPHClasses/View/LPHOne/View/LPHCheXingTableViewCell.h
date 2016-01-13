//
//  LPHCheXingTableViewCell.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "LPHCheXingModel.h"

@interface LPHCheXingTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *imageLogo;

@property (strong, nonatomic) UILabel *titleLabel;

-(void)relayoutWithModel:(LPHCheXingModel *)model;

@end
