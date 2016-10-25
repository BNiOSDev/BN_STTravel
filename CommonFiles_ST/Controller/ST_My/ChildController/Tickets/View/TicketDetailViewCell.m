//
//  TicketDetailViewCell.m
//  LUBABA
//
//  Created by Diana on 16/10/12.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "TicketDetailViewCell.h"

@implementation TicketDetailViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imgView.image = nil;
    self.nameLabel.text = @"";
    self.typeLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
