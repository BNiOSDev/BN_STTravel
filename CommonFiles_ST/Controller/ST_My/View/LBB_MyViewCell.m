//
//  LBB_MyViewCell.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyViewCell.h"

@implementation LBB_MyViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label.textColor = ColorGray;
    self.label.font = Font12;
    self.numLabel.font = Font10;
    self.numLabel.layer.cornerRadius = 8.f;
    self.numLabel.backgroundColor = ColorRed;
    self.numLabel.textColor = ColorWhite;
    self.numLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.numLabel.hidden = YES;
}
@end
