//
//  MineHeaderView.m
//  LUBABA
//
//  Created by Dianar on 16/10/8.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *headBgImgView;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UIView *authenticationBgView;
@property (weak, nonatomic) IBOutlet UILabel *authenticationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authenticationImgView;
@property (weak, nonatomic) IBOutlet UILabel *userSignatureLabel;

@end

@implementation MineHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    [self initContraints];
}

- (void)initContraints
{
    self.userNameLabel.adjustsFontSizeToFitWidth = YES;
    self.userSignatureLabel.adjustsFontSizeToFitWidth = YES;
//    self.setBtn.layer.borderColor = [UIColor redColor].CGColor;
//    self.setBtn.layer.borderWidth = 1.0f;
//    self.messageBtn.layer.borderColor = [UIColor redColor].CGColor;
//    self.messageBtn.layer.borderWidth = 1.0f;
}
- (void)setUserInfo:(id)userInfo
{
    
}

- (IBAction)setBtnClickEvent:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickSetting:)]) {
        [self.delegate didClickSetting:self.userInfo];
    }
}

- (IBAction)messageBtnClickEvent:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickMessage:)]) {
        [self.delegate didClickMessage:self.userInfo];
    }
}

- (IBAction)personCenterBtnClickEvent:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickPersonalCenter:)]) {
        [self.delegate didClickPersonalCenter:self.userInfo];
    }
}

@end
