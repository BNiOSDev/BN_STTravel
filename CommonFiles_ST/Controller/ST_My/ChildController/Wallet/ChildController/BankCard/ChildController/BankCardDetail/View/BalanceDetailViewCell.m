//
//  BalanceDetailViewCell.m
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
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
