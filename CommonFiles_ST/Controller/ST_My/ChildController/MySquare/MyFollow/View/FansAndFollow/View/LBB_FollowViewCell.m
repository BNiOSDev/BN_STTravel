//
//  LBB_FollowViewCell.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FollowViewCell.h"
#import <UIImageView+WebCache.h>
#import "Header.h"

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
//    self.signatureLabel.adjustsFontSizeToFitWidth = YES;
    self.signatureLabel.numberOfLines = 1;
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
    [_iconImgView  sd_setImageWithURL:[NSURL URLWithString:_model.userImageURL] placeholderImage:DEFAULTIMAGE];
    self.nameLabel.text = _model.userName;
    self.certifiedImgView.hidden = !_model.certified;
    self.lvLabel.text = [NSString stringWithFormat:@" Lv.%@ ",@(_model.lvLevel)];
    self.signatureLabel.text = _model.userSignature;
    if (!_model.certified) {
        self.cetifiedImgViewWidthContraint.constant = 0.f;
    }else {
        self.cetifiedImgViewWidthContraint.constant = 14.f;
    }
    [self.lvLabel updateLayout];
    self.lvLabel.hidden = NO;
    
    if (_model.isFollow) {
        [_followBtn setTitle:@"相互关注" forState:UIControlStateNormal];
    }else{
        [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
}

@end
