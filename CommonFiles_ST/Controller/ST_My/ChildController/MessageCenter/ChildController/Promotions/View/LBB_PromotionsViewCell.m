//
//  LBB_PromotionsViewCell.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PromotionsViewCell.h"

@implementation LBB_PromotionsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor  = ColorBackground;
    self.backgroundColor = ColorBackground;
    
    self.titleLabel.textColor = ColorBlack;
    self.contentLabel.textColor = ColorLightGray;
    self.detailLabel.textColor = ColorBlack;
    self.stateLabel.textColor = ColorWhite;
    
    self.titleLabel.font = Font15;
    self.contentLabel.font = Font15;
    self.detailLabel.font = Font15;
    self.stateLabel.font = [UIFont boldSystemFontOfSize:25.f];
    self.lineView.backgroundColor = ColorLine;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.stateLabel.text = nil;
    self.titleLabel.text = nil;
    self.contentLabel.text = nil;
    self.detailLabel.text = nil;
    self.stateLabel.text = nil;
    [self.iconImgView prepareForReuse];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
