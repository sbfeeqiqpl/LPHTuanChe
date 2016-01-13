//
//  LPHFiveTableViewCell.h
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LPHFiveModel;
@interface LPHFiveTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) LPHFiveModel *model;

@end
