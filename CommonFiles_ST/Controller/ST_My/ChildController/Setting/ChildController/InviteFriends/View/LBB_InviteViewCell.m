//
//  LBB_InviteViewCell.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_InviteViewCell.h"

@implementation LBB_InviteViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentLabel.font = Font16;
    self.contentLabel.textColor = ColorBlack;
}

- (void)prepareForReuse
{
    [self prepareForReuse];
    self.contentLabel.text = nil;
    self.iconImgView.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
