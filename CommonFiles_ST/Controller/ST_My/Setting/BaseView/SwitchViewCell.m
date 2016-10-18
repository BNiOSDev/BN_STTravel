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
