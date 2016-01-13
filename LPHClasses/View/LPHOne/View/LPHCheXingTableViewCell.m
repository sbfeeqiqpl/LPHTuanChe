//
//  LPHCheXingTableViewCell.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHCheXingTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LPHCheXingTableViewCell

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
    _imageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.contentView addSubview:_imageLogo];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, 180, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
}
-(void)relayoutWithModel:(LPHCheXingModel *)model
{
    [_imageLogo sd_setImageWithURL:[NSURL URLWithString:model.brand_logo] placeholderImage:[UIImage imageNamed:@"default_special_3"]];
    _titleLabel.text = model.brand_name;
    
}

@end
