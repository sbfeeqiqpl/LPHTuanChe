//
//  LPHFiveTableViewCell.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "LPHFiveTableViewCell.h"
#import "LPHFiveModel.h"
@implementation LPHFiveTableViewCell

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
    _logo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    [self.contentView addSubview:_logo];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nameLabel];
}
-(void)setModel:(LPHFiveModel *)model
{
    _model = model;
    self.logo.image = [UIImage imageNamed:model.logo];
    self.nameLabel.text = model.title;
}
@end
