//
//  LPHTableViewCell.m
//  LPHTuanChe
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 李鹏辉. All rights reserved.
//

#import "LPHTableViewCell.h"

@implementation LPHTableViewCell

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
    _iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 100, 60)];
    [self.contentView addSubview:_iconImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 20, 180, 20)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_titleLabel];
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 40, 180, 20)];
    _priceLabel.font = [UIFont systemFontOfSize:16];
    _priceLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    [self.contentView addSubview:_priceLabel];
    
    _prefixLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 34, 20)];
    _prefixLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_prefixLabel];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(154, 60, 34, 20)];
    _numLabel.font = [UIFont systemFontOfSize:16];
    _numLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_numLabel];
    
    _suffixLabel = [[UILabel alloc]initWithFrame:CGRectMake(188, 60, 60, 20)];
    _suffixLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_suffixLabel];
    
}
-(void)relayoutWithModel:(LPHOneModel *)model
{
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    _titleLabel.text = model.styleName;
    _priceLabel.text = model.factoryPrice;
    _prefixLabel.text = model.prefix;
    _suffixLabel.text = model.suffix;
    _numLabel.text = [NSString stringWithFormat:@"%ld",model.manNum];
}

@end
