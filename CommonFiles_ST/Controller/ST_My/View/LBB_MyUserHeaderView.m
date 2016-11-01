//
//  LBB_MyUserHeaderView.m
//  ST_Travel
//
//  Created by Diana on 16/10/30.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyUserHeaderView.h"
#import "Base_Common.h"

@interface LBB_MyUserHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *userHeadBtn;
@property (weak, nonatomic) IBOutlet EnlargeButton *setBtn;
@property (weak, nonatomic) IBOutlet EnlargeButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backImgView;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImgView;
@property (weak, nonatomic) IBOutlet UIImageView *guideImgView;
@property (weak, nonatomic) IBOutlet UILabel *guideLabel;
@property (weak, nonatomic) IBOutlet UIView *levelGuideBgView;
@property (weak, nonatomic) IBOutlet UIButton *coverPictureBtn;

@end


@implementation LBB_MyUserHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userNameLabel.textColor = ColorWhite;
    self.levelLabel.textColor = ColorWhite;
    self.guideLabel.textColor = ColorWhite;
    self.signatureLabel.textColor = ColorWhite;
    self.userNameLabel.font = Font16;
    self.levelLabel.font = Font12;
    self.guideLabel.font = Font12;
    self.signatureLabel.font = Font12;
    
    self.coverPictureBtn.exclusiveTouch = YES;
    self.userHeadBtn.exclusiveTouch = YES;
    self.setBtn.exclusiveTouch = YES;
    self.messageBtn.exclusiveTouch = YES;
    
    self.backImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.setBtn.enlargeInset = UIEdgeInsetsMake(10, 10, 10, 20);
    self.messageBtn.enlargeInset = UIEdgeInsetsMake(10, 20, 10, 10);
}

- (void)setUserInfo:(NSDictionary*)userInfo
{
    _userInfo = userInfo;
    NSDictionary *detailDict = [_userInfo objectForKey:@"Header"];
    UIImage *image = [detailDict objectForKey:@"Image"];
    self.backImgView.image = image;
    
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

- (IBAction)converPictureClickEvent:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickConverPicture:)]) {
        [self.delegate didClickConverPicture:self.userInfo];
    }
}

@end
