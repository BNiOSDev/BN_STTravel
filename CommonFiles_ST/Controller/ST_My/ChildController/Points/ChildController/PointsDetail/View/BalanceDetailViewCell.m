//
//  BalanceDetailViewCell.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/9.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "BalanceDetailViewCell.h"

@implementation BalanceDetailViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.describeLabel.textColor = ColorBlack;
    self.timeLabel.textColor = ColorLightGray;
    self.numLabel.textColor = ColorRed;
    self.describeLabel.font = Font15;
    self.timeLabel.font = Font13;
    self.numLabel.font = Font15;
    self.describeLabel.numberOfLines = 0;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.describeLabel.text = nil;
    self.timeLabel.text = nil;
    self.numLabel.text = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
