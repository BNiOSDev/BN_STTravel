//
//  LBB_NoticeViewCell.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NoticeViewCell.h"

@interface LBB_NoticeViewCell()


@end


@implementation LBB_NoticeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor  = ColorBackground;
    self.backgroundColor = ColorBackground;
    
    self.titleLabel.font = Font16;
    self.dateLabel.font = Font14;
    self.contentLabel.font = Font14;
    self.checkLabel.font = Font14;
    
    self.titleLabel.textColor = ColorBlack;
    self.dateLabel.textColor = ColorLightGray;
    self.contentLabel.textColor = ColorBlack;
    self.checkLabel.textColor = ColorBlack;
    
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    
    self.checkLabel.text = @"查看详情";
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.dateLabel.text = nil;
    self.contentLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
