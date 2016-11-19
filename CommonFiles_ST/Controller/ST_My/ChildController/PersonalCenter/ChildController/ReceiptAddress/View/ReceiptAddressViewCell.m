//
//  ReceiptAddressViewCell.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/19.
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
    
    self.userNameLabel.font = Font15;
    self.phoneNumLabel.font = Font14;
    self.adressLabel.font = Font13;
    self.streetLabel.font = Font13;
    [self.defaultBtn.titleLabel setFont:Font13];
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.userNameLabel.text = nil;
    self.phoneNumLabel.text = nil;
    self.adressLabel.text = nil;
    self.streetLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellInfo:(LBB_AddressModel *)cellInfo
{
    _cellInfo = cellInfo;
    self.userNameLabel.text = _cellInfo.userName;
    self.phoneNumLabel.text = _cellInfo.phoneNum;
    self.adressLabel.text = _cellInfo.adress;
    self.streetLabel.text = _cellInfo.street;
    self.defaultImgView.hidden = !_cellInfo.isDefault;
    if (_cellInfo.isDefault) {
        self.defaultBtn.backgroundColor = ColorBtnYellow;
        [self.defaultBtn setTitle:@"默认地址" forState:UIControlStateNormal];
    }else {
        self.defaultBtn.backgroundColor = ColorGray;
        [self.defaultBtn setTitle:@"设为默认" forState:UIControlStateNormal];
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
