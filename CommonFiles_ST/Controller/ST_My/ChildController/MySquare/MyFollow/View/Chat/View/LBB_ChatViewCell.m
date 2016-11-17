//
//  LBB_ChatViewCell.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ChatViewCell.h"
#import "Header.h"

@interface LBB_ChatViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation LBB_ChatViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.font = Font15;
    self.signatureLabel.font = Font13;
    self.dateLabel.font =  Font14;
    self.nameLabel.textColor = ColorBlack;
    self.signatureLabel.textColor = ColorGray;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.iconImgView.image = nil;
    self.nameLabel.text = nil;
    self.signatureLabel.text = nil;
    self.dateLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LBB_ChatModel *)model
{
    _model = model;
    [_iconImgView  sd_setImageWithURL:[NSURL URLWithString:_model.imageURL] placeholderImage:DEFAULTIMAGE];
    self.nameLabel.text = _model.name;
    self.signatureLabel.text = _model.content;
    self.dateLabel.text = _model.dateStr;
}

@end
