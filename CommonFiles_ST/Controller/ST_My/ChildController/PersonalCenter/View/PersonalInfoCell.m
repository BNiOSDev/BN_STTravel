//
//  PersonalInfoCell.m
//  LUBABA
//
//  Created by Diana on 16/10/14.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "PersonalInfoCell.h"

@implementation PersonalInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rightImgView.layer.cornerRadius = 40.f;
    self.rightImgView.clipsToBounds = YES;
    self.rightImgView.backgroundColor = [UIColor clearColor];
    
    self.leftLabal.textColor = ColorBlack;
    self.rightLabel.textColor = ColorGray;
    self.leftLabal.font = Font15;
    self.rightLabel.font = Font14;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.leftLabal.text = @"";
    self.rightLabel.text = @"";
    self.rightImgView.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
