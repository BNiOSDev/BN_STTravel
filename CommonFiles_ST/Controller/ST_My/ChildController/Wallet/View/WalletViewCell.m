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
}

@end
