//
//  LPHThreeTableViewCell.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHThreeTableViewCell.h"

@implementation LPHThreeTableViewCell

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
    _logo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    [self.contentView addSubview:_logo];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 120, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    _nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nameLabel];
}
-(void)relayoutWithModel:(LPHThreeModel *)model
{
    [_logo sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    _nameLabel.text = model.name;
}
@end
