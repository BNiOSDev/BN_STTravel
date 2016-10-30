//
//  LBB_MessageCenterViewCell.m
//  ST_Travel
//
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MessageCenterViewCell.h"

@implementation LBB_MessageCenterViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.textColor = ColorGray;
    self.contentLabel.textColor = ColorLightGray;
    self.dateLabel.textColor = ColorLightGray;
    
    self.titleLabel.font = Font16;
    self.contentLabel.font = Font16;
    self.dateLabel.font = Font15;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.iconImgView.image = nil;
    self.titleLabel.text = nil;
    self.contentLabel.text = nil;
    self.dateLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellInfo:(id)cellInfo
{
    _cellInfo = cellInfo;
}

@end
