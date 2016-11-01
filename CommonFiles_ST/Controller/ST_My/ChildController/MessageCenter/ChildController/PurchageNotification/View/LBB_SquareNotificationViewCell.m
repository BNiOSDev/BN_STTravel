//
//  LBB_SquareNotificationViewCell.m
//  ST_Travel
//
//  Created by Diana on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareNotificationViewCell.h"

@implementation LBB_SquareNotificationViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor  = ColorBackground;
    self.backgroundColor = ColorBackground;
    
    self.titleLabel.textColor = ColorBlack;
    self.contentLabel.textColor = ColorGray;
    
    self.titleLabel.font = Font15;
    self.contentLabel.font = Font15;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.contentLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
