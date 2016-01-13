//
//  LPHCityTableViewCell.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHCityTableViewCell.h"

@implementation LPHCityTableViewCell

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
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 20)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_titleLabel];
}
-(void)relayoutWithModel:(LPHCityModel *)model
{
    _titleLabel.text = model.name;
}
@end
