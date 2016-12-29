//
//  LBB_MyUserHeaderView.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/30.
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
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImgView;
@end


@implementation LBB_MyUserHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userNameLabel.textColor = ColorWhite;
    self.levelLabel.textColor = ColorWhite;
    self.guideLabel.textColor = ColorWhite;
    self.signatureLabel.textColor = ColorWhite;
    self.signatureLabel.adjustsFontSizeToFitWidth = YES;
    self.signatureLabel.numberOfLines = 0;
    self.userNameLabel.font = Font16;
    self.levelLabel.font = Font12;
    self.guideLabel.font = Font12;
    self.signatureLabel.font = Font12;
    
    self.coverPictureBtn.exclusiveTouch = YES;
    self.userHeadBtn.exclusiveTouch = YES;
    self.setBtn.exclusiveTouch = YES;
    self.messageBtn.exclusiveTouch = YES;
    
    self.backImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.setBtn.enlargeInset = UIEdgeInsetsMake(10, 10, 40, 40);
    self.messageBtn.enlargeInset = UIEdgeInsetsMake(10, 40, 40, 10);
    self.levelImgView.hidden = YES;
    self.levelLabel.hidden = YES;
    self.guideImgView.hidden = YES;
    self.guideLabel.hidden = YES;
    
    [self showShadow:self.userNameLabel];
    [self showShadow:self.levelLabel];
    [self showShadow:self.guideLabel];
    
}
//  加阴影
- (void)showShadow:(UIView*)view
{
    CALayer *layer = [view layer];
    layer.shadowOffset = CGSizeMake(1.f, 1.f);
    layer.shadowRadius = .5f;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.7;
}

- (void)setViewModel:(LBB_MineViewModel*)viewModel
{
    _viewModel = viewModel;
    UIImage *image = IMAGE(_viewModel.portrait);
    if (_viewModel.portrait && [_viewModel.portrait length]) {
        [self.userHeadImgView  sd_setImageWithURL:[NSURL URLWithString:_viewModel.portrait] placeholderImage:UnLoginDefaultImage];
    }else{
        [self.userHeadImgView setImage:UnLoginDefaultImage];
    }
    
    [self.userHeadBtn setImage:image forState:UIControlStateNormal];
    
    if (_viewModel.coverImageUrl && [_viewModel.coverImageUrl length]) {
        [self.backImgView  sd_setImageWithURL:[NSURL URLWithString:_viewModel.coverImageUrl] placeholderImage:nil];
    }else {
        self.backImgView.image = nil;
    }
   
    self.userNameLabel.text = _viewModel.name;
    self.levelLabel.text = [NSString stringWithFormat:@"Lv. %@",@(_viewModel.level)];
//    self.guideLabel.text = [self getAuthMessage:_viewModel.tourAuditState];
    self.signatureLabel.text = _viewModel.signature;
    if (self.isLogin) {
        if (_viewModel.level > 0) {
            self.levelImgView.hidden = NO;
            self.levelLabel.hidden = NO;
        }else {
            self.levelImgView.hidden = YES;
            self.levelLabel.hidden = YES;
        } 
        if (_viewModel.auditState == 2) {
            self.guideImgView.hidden = NO;
            self.guideLabel.hidden = NO;
        }else {self.guideImgView.hidden = YES;
            self.guideLabel.hidden = YES;
        }
    }else {
        self.levelImgView.hidden = YES;
        self.levelLabel.hidden = YES;
        self.guideImgView.hidden = YES;
        self.guideLabel.hidden = YES;
    }
}

- (NSString*)getAuthMessage:(int)type
{
    NSString *authStr = @"未提交实名认证";
    switch (type) {
        case 0:
            authStr = @"未提交实名认证";
            break;
        case 1:
            authStr = @"已提交实名认证，正在审核";
            break;
        case 2:
            authStr = @"认证成功";
            break;
        case 3:
            authStr = @"认证失败";
            break;
        default:
            break;
    }
    return authStr;
}

- (IBAction)setBtnClickEvent:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickSetting:)]) {
        [self.delegate didClickSetting:self.viewModel];
    }
}

- (IBAction)messageBtnClickEvent:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickMessage:)]) {
        [self.delegate didClickMessage:self.viewModel];
    }
}

- (IBAction)personCenterBtnClickEvent:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickPersonalCenter:IsLogin:)]) {
        [self.delegate didClickPersonalCenter:self.viewModel IsLogin:self.isLogin];
    }
}

- (IBAction)converPictureClickEvent:(id)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickConverPicture:IsLogin:)]) {
        [self.delegate didClickConverPicture:self.viewModel IsLogin:self.isLogin];
    }
}

@end
