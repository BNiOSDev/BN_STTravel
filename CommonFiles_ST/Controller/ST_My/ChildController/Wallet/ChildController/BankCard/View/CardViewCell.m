//
//  CardViewCell.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/9.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "CardViewCell.h"

@implementation CardViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cardNameLabel.adjustsFontSizeToFitWidth = YES;
    self.cardNumLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
