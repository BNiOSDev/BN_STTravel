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
    self.numLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
