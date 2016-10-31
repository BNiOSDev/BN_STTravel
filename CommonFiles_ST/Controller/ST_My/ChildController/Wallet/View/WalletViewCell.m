//
//  WalletViewCell.m
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
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
