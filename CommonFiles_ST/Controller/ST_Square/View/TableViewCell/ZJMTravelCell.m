//
//  ZJMTravelCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ZJMTravelCell.h"
#import "SDAutoLayout.h"
#import <UIImageView+WebCache.h>

@implementation ZJMTravelCell
{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup
{
    _iconView = [UIImageView new];
    
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:15.0];
    _contentLabel.numberOfLines = 0;
    
    NSArray *views = @[_iconView, _nameLable, _contentLabel];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    _nameLable.sd_layout
    .leftSpaceToView(contentView, 50)
    .topEqualToView(contentView)
    .heightIs(18);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .leftEqualToView(contentView)
    .topSpaceToView(contentView, 40)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
}

- (void)setTravelModel:(ZJMTravelModel *)travelModel
{
    _travelModel = travelModel;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:travelModel.iconName]];
    _nameLable.text = travelModel.name;
    NSLog(@"name = %@",travelModel.name);
    _contentLabel.text = travelModel.msgContent;
    NSLog(@"msgContent = %@",travelModel.msgContent);
    [self setupAutoHeightWithBottomView:_iconView bottomMargin:10];
}

@end
