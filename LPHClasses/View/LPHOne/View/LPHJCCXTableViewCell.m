//
//  LPHJCCXTableViewCell.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/14.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHJCCXTableViewCell.h"

@implementation LPHJCCXTableViewCell

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
    _logo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
    [self.contentView addSubview:_logo];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 15, 230, 20)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_titleLabel];
    
}
-(void)relayoutWithModel:(LPHJCCXModel *)model
{
    _logo.image = [UIImage imageNamed:@"default_special_3"];
    _titleLabel.text = model.series_name;
}

@end
