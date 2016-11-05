//
//  ReceiptAddressViewCell.m
//  ST_Travel
//
//  Created by Diana on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ReceiptAddressViewCell.h"

@implementation ReceiptAddressViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userNameLabel.textColor = ColorBlack;
    self.phoneNumLabel.textColor = ColorBlack;
    self.adressLabel.textColor = ColorBlack;
    self.streetLabel.textColor = ColorBlack;
    self.defaultLabel.textColor = ColorRed;
    self.defaultLabel.backgroundColor = ColorLightGray;
    self.defaultLabel.layer.borderColor = ColorRed.CGColor;
    self.defaultLabel.layer.cornerRadius = self.defaultLabel.frame.size.height/2.0;
    
    self.userNameLabel.font = Font14;
    self.phoneNumLabel.font = Font14;
    self.adressLabel.font = Font12;
    self.streetLabel.font = Font12;
    self.defaultLabel.font = Font12;
    self.defaultLabel.font = Font14;
   
    self.defaultBtn.backgroundColor = [UIColor clearColor];
    [self.defaultBtn setBackgroundImage:[UIImage createImageWithColor:ColorGray] forState:UIControlStateNormal];
    self.editBtn.backgroundColor = [UIColor clearColor];
    [self.editBtn setBackgroundImage:[UIImage createImageWithColor:ColorBtnYellow] forState:UIControlStateNormal];
    self.deleteBtn.backgroundColor = [UIColor clearColor];
    [self.deleteBtn setBackgroundImage:[UIImage createImageWithColor:ColorLightGray] forState:UIControlStateNormal];
    
    [self.defaultBtn.titleLabel setFont:Font13];
    [self.editBtn.titleLabel setFont:Font13];
    [self.deleteBtn.titleLabel setFont:Font13];
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.userNameLabel.text = nil;
    self.phoneNumLabel.text = nil;
    self.adressLabel.text = nil;
    self.streetLabel.text = nil;
    self.defaultLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellInfo:(NSDictionary *)cellInfo
{
    _cellInfo = cellInfo;
    self.userNameLabel.text = [cellInfo objectForKey:@"UserName"];
    self.phoneNumLabel.text = [cellInfo objectForKey:@"PhoneNum"];
    self.adressLabel.text = [cellInfo objectForKey:@"Address"];
    self.streetLabel.text = [cellInfo objectForKey:@"Street"];
    if ([cellInfo objectForKey:@"DefautAdress"]) {
        NSString *show = [cellInfo objectForKey:@"DefautAdress"];
        self.defaultLabel.hidden = ![show boolValue];;
    }else{
        self.defaultLabel.hidden  = YES;
    }
}

#pragma mark - UI Action

- (IBAction)deleteBtnAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didDeleteCellAddress:)]) {
        [self.delegate didDeleteCellAddress:self.cellInfo];
    }
}

- (IBAction)editBtnAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didEditCellAddress:)]) {
        [self.delegate didEditCellAddress:self.cellInfo];
    }
}

- (IBAction)defaultBtnAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(setDefautlCellAdress:)]) {
        [self.delegate setDefautlCellAdress:self.cellInfo];
    }
}

@end
