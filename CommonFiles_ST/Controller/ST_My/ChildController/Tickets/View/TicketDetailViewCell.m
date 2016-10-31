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
    self.nameLabel.textColor = ColorBlack;
    self.typeLabel.textColor = ColorBlack;
    self.monneyLabel.textColor = RGBAHEX(0xFF1344, 1.0);
    self.numLabel.textColor = ColorBlack;
    
    self.nameLabel.font = Font12;
    self.typeLabel.font = Font12;
    self.monneyLabel.font = Font12;
    self.numLabel.font = Font12;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imgView.image = nil;
    self.nameLabel.text = @"";
    self.typeLabel.text = @"";
}

- (void)setCellInfo:(NSDictionary*)cellInfo
{
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    self.nameLabel.text = [cellInfo objectForKey:@"Title"];
    self.typeLabel.text = [cellInfo objectForKey:@"Type"];
    self.monneyLabel.text = [cellInfo objectForKey:@"Money"];
    self.numLabel.text = [cellInfo objectForKey:@"Num"];
    self.imgView.image = [UIImage imageNamed:[cellInfo objectForKey:@"Image"]];
    self.accessoryView =  nil;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
