//
//  LBB_FollowViewCell.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FollowViewCell.h"
#import <UIImageView+WebCache.h>
#import "Mine_Common.h"

@interface LBB_FollowViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *certifiedImgView;
@property (weak, nonatomic) IBOutlet UILabel *lvLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cetifiedImgViewWidthContraint;

@end


@implementation LBB_FollowViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.font = Font15;
    self.signatureLabel.font = Font13;
    self.lvLabel.font =  Font14;
    self.nameLabel.textColor = ColorBlack;
    self.signatureLabel.textColor = ColorGray;
    self.lvLabel.textColor = ColorWhite;
    self.lvLabel.backgroundColor = ColorBtnYellow;
    
    self.lvLabel.layer.cornerRadius = 8.f;
    self.lvLabel.clipsToBounds = YES;
    self.signatureLabel.adjustsFontSizeToFitWidth = YES;
    self.signatureLabel.numberOfLines = 2;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.iconImgView.image = nil;
    self.nameLabel.text = nil;
    self.signatureLabel.text = nil;
    self.certifiedImgView.hidden = YES;
    self.lvLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
 
}

- (void)setModel:(LBB_FollowModel *)model
{
     _model = model;
    [_iconImgView  sd_setImageWithURL:[NSURL URLWithString:_model.userPicUrl] placeholderImage:UnLoginDefaultImage];
    self.nameLabel.text = _model.userName;
    self.certifiedImgView.hidden = (_model.tourAuditState == 2) ? NO : YES;
    self.lvLabel.text = [NSString stringWithFormat:@" Lv.%@  ",@(_model.level)];
    self.signatureLabel.text = _model.signature;
    if (!(_model.tourAuditState == 2)) {
        self.cetifiedImgViewWidthContraint.constant = 0.f;
    }else {
        self.cetifiedImgViewWidthContraint.constant = 14.f;
    }
    [self layoutIfNeeded];
    self.lvLabel.hidden = NO;
    if (_model.level == 0) {
        self.lvLabel.hidden = YES;
    }else {
         self.lvLabel.hidden = NO;
    }
    
   // 0未关注2：互相关注
    if (_model.followState) {
        [_followBtn setTitle:@"相互关注" forState:UIControlStateNormal];
    }else{
        [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
}

@end
