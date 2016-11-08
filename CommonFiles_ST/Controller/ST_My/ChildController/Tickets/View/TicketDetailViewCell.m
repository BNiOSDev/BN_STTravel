//
//  TicketDetailViewCell.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/12.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "TicketDetailViewCell.h"
#import "Mine_Common.h"

@implementation TicketDetailViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.textColor = ColorGray;
    self.typeLabel.textColor = ColorGray;
    self.monneyLabel.textColor = ColorRed;
    self.numLabel.textColor = ColorGray;
    
    self.nameLabel.font = Font15;
    self.typeLabel.font = Font13;
    self.monneyLabel.font = Font15;
    self.numLabel.font = Font15;
    self.imageWidthContraint.constant = AutoSize(80.f);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imgView.image = nil;
    self.nameLabel.text = @"";
    self.typeLabel.text = @"";
}

- (void)setCellInfo:(LBB_TicketModelDetail*)cellInfo
{
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    self.nameLabel.text = cellInfo.content;
    self.typeLabel.text = cellInfo.typeContent;
    self.monneyLabel.text = [NSString stringWithFormat:@"￥%@",@(cellInfo.money)];
    self.numLabel.text = [NSString stringWithFormat:@"x %@",@(cellInfo.num)];
    self.imgView.image = IMAGE(cellInfo.ticketImagePath);
    self.accessoryView =  nil;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
