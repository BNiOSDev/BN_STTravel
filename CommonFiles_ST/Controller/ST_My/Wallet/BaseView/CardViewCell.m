//
//  CardViewCell.m
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
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
