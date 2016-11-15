//
//  WalletViewCell.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/9.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "WalletViewCell.h"

@implementation WalletViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentLabel.adjustsFontSizeToFitWidth = YES;
    self.numLabel.adjustsFontSizeToFitWidth = YES;
    self.contentLabel.textColor = ColorBlack;
    self.numLabel.textColor = ColorBlack;
    self.contentLabel.font = Font14;
    self.numLabel.font = Font14;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

@end
