//
//  LPHThreeCeTableViewCell.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHThreeCeTableViewCell.h"
#import "LPHKmagn.h"

@implementation LPHThreeCeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createModel];
    }
    return self;
}
-(void)createModel{
    _logo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 50)];
    [self.contentView addSubview:_logo];
    
    _styleName = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 180, 20)];
    _styleName.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_styleName];
    
    _factoryPrice = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, 180, 20)];
    _factoryPrice.font = [UIFont systemFontOfSize:14];
    _factoryPrice.textColor = [UIColor grayColor];
    [self.contentView addSubview:_factoryPrice];
}
-(void)relayoutWithModel:(LPHSanModel *)model
{
    [_logo sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    _styleName.text = model.styleName;
    _factoryPrice.text = model.factoryPrice;
    
}
@end
