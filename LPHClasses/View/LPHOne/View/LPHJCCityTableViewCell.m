//
//  LPHJCCityTableViewCell.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHJCCityTableViewCell.h"

@implementation LPHJCCityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createModel];
    }
    return self;
}

-(void)createModel
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 160, 20)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_titleLabel];
}
-(void)relayoutWithModel:(LPHJCCityModel *)model
{
    _titleLabel.text = model.city_name;
}

@end
