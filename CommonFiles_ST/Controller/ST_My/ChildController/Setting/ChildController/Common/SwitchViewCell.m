//
//  SwitchViewCell.m
//  LUBABA
//
//  Created by Diana on 16/10/10.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "SwitchViewCell.h"

@implementation SwitchViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.descLabel.hidden = YES;
    self.switchBtn.enabled = NO;
    self.descLabel.font = Font16;
    self.descLabel.textColor = ColorBlack;
    self.contentLabel.font = Font16;
    self.contentLabel.textColor = ColorBlack;
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.descLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
