//
//  LBBFriendTableViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBFriendTableViewCell.h"
#import "Header.h"

@implementation LBBFriendTableViewCell
{
    UIImageView   *iconImage;
    UILabel            *nameLabel;
    UILabel            *contentLabel;
    UIButton           *focusBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,AUTO(10) , AUTO(40), AUTO(40))];
    [self addSubview:iconImage];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconImage.right + 5, iconImage.top, DeviceWidth - AUTO(65) - iconImage.right - 5, AUTO(15))];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = FONT(AUTO(13.0));
    [self addSubview:nameLabel];
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + AUTO(5), nameLabel.width, AUTO(15))];
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.font = FONT(AUTO(11.0));
    [self addSubview:contentLabel];
    
    focusBtn = [[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth - AUTO(45) - 20, AUTO(20), AUTO(45), AUTO(20))];
    [focusBtn setTitle:@"关注" forState:0];
    [focusBtn setTitleColor:UIColorFromRGB(0xBA9150) forState:0];
    focusBtn.titleLabel.font = FONT(AUTO(12.0));
    LRViewBorderRadius(focusBtn, 2.0, 0.5, UIColorFromRGB(0xBA9150));
    [self addSubview:focusBtn];
}

- (void)setModel:(LBBFriendModel *)model
{
    _model = model;
    [iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:DEFAULTIMAGE];
    nameLabel.text = model.userName;
    contentLabel.text = model.content;
}

@end
