//
//  LBB_GuiderMainCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderMainCell.h"
#import "LBB_GuiderUserViewController.h"
@implementation LBB_GuiderMainCell{

    RACDisposable* racFollowState;
    RACDisposable* racActionNum;
    RACDisposable* racFansNum;
    RACDisposable* racFollowNum;
    
    UILabel* signTitleLable;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat margin = 8;
        CGFloat height = AutoSize(93/2);
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(margin);
            make.top.equalTo(ws.contentView).offset(2*margin);
            make.width.height.mas_equalTo(height);
        }];
        self.portraitImageView.layer.cornerRadius = height/2;
        self.portraitImageView.layer.masksToBounds = YES;
        self.portraitImageView.userInteractionEnabled = YES;
        
        self.nameLabel = [UILabel new];
        [self.nameLabel setText:@"黄灿灿导游"];
        [self.nameLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [self.nameLabel setTextColor:ColorBlack];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.portraitImageView);
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
        }];
        [self.nameLabel setUserInteractionEnabled:YES];

        self.vImageView = [UIImageView new];
        [self.vImageView setImage:IMAGE(@"导游_导游V")];
        [self.contentView addSubview:self.vImageView];
        [self.vImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.nameLabel);
            make.left.equalTo(ws.nameLabel.mas_right).offset(margin/2);
        }];
        
        self.genderImageView = [UIImageView new];
        [self.genderImageView setImage:IMAGE(@"导游_女")];
        [self.contentView addSubview:self.genderImageView];
        [self.genderImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.nameLabel);
            make.left.equalTo(ws.vImageView.mas_right).offset(margin/2);
        }];
        
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.favoriteButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [self.favoriteButton.titleLabel setFont:Font13];
        [self.favoriteButton setBackgroundColor:ColorBtnYellow];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.nameLabel);
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.width.mas_equalTo(AutoSize(40));
            make.height.mas_equalTo(AutoSize(15));
        }];
        [self.favoriteButton bk_addEventHandler:^(id sender){
            
            [ws.model attention:^(NSError* error){
            
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        
        //关注、粉丝、动态等标签
        self.favoriteLabel = [UILabel new];
        [self.favoriteLabel setFont:Font13];
        [self.favoriteLabel setText:@"关注 12"];
        [self.contentView addSubview:self.favoriteLabel];
        [self.favoriteLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.nameLabel);
            make.top.equalTo(ws.nameLabel.mas_bottom).offset(margin);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.height.equalTo(ws.favoriteLabel);
            make.left.equalTo(ws.favoriteLabel.mas_right).offset(margin);
            make.width.mas_equalTo(SeparateLineWidth);
        }];
        
        self.funsLabel = [UILabel new];
        [self.funsLabel setFont:Font13];
        [self.funsLabel setText:@"粉丝 1290"];
        [self.contentView addSubview:self.funsLabel];
        [self.funsLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(sep.mas_right).offset(margin);
            make.centerY.equalTo(ws.favoriteLabel);
        }];
        
        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.height.equalTo(ws.favoriteLabel);
            make.left.equalTo(ws.funsLabel.mas_right).offset(margin);
            make.width.mas_equalTo(SeparateLineWidth);
        }];
        
        self.dynamicLabel = [UILabel new];
        [self.dynamicLabel setFont:Font13];
        [self.dynamicLabel setText:@"动态 1290"];
        [self.contentView addSubview:self.dynamicLabel];
        [self.dynamicLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(sep1.mas_right).offset(margin);
            make.centerY.equalTo(ws.favoriteLabel);
        }];
     
        
        //认证信息
        UILabel* identity = [UILabel new];
        [identity setText:@""];
        [identity setTextColor:ColorLightGray];
        [identity setFont:Font13];
        [self.contentView addSubview:identity];
        [identity mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.nameLabel);
            make.top.equalTo(ws.favoriteLabel.mas_bottom).offset(0/*margin*/);
        }];
        identity.hidden = YES;
        
        self.identityLable = [UILabel new];
        [self.identityLable setFont:Font13];
        [self.identityLable setText:@""];
        [self.contentView addSubview:self.identityLable];
        [self.identityLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(identity.mas_right).offset(margin);
            make.centerY.equalTo(identity);
        }];
        self.identityLable.hidden = YES;
        
        //认证信息
        UILabel* sign = [UILabel new];
        [sign setText:@"签名"];
        [sign setTextColor:ColorLightGray];
        [sign setFont:Font13];
        [self.contentView addSubview:sign];
        [sign mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.nameLabel);
            make.top.equalTo(identity.mas_bottom).offset(margin);
        }];
        signTitleLable = sign;
        
        self.signLable = [UILabel new];
        [self.signLable setFont:Font13];
        [self.signLable setText:@"欢迎来到海上花园城市"];
        [self.contentView addSubview:self.signLable];
        [self.signLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(sign.mas_right).offset(margin);
            make.centerY.equalTo(sign);
        }];
        
        //底部的标签按钮
        self.labelButton1 = [UIButton new];
        [self.labelButton1 setTitleColor:ColorBlack forState:UIControlStateNormal];
        [self.labelButton1.titleLabel setFont:Font10];
        self.labelButton1.layer.borderColor = ColorBtnYellow.CGColor;
        self.labelButton1.layer.borderWidth = SeparateLineWidth;
        self.labelButton1.layer.masksToBounds = YES;
        [self.labelButton1 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton1];
        
        self.labelButton2 = [UIButton new];
        [self.labelButton2 setTitleColor:ColorBlack forState:UIControlStateNormal];
        [self.labelButton2.titleLabel setFont:Font10];
        self.labelButton2.layer.borderColor = ColorBtnYellow.CGColor;
        self.labelButton2.layer.borderWidth = SeparateLineWidth;
        self.labelButton2.layer.masksToBounds = YES;
        [self.labelButton2 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton2];
        
        self.labelButton3 = [UIButton new];
        [self.labelButton3 setTitleColor:ColorBlack forState:UIControlStateNormal];
        [self.labelButton3.titleLabel setFont:Font10];
        self.labelButton3.layer.borderColor = ColorBtnYellow.CGColor;
        self.labelButton3.layer.borderWidth = SeparateLineWidth;
        self.labelButton3.layer.masksToBounds = YES;
        [self.labelButton3 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton3];
        
        
        [self.labelButton1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.nameLabel);
            make.top.equalTo(signTitleLable.mas_bottom).offset(margin);
            make.width.mas_equalTo(AutoSize(80/2));
            make.height.mas_equalTo(AutoSize(30/2));
        }];
        
        [self.labelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton1.mas_right).offset(margin);
            make.centerY.width.height.equalTo(ws.labelButton1);
        }];
        [self.labelButton3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton2.mas_right).offset(margin);
            make.centerY.width.height.equalTo(ws.labelButton1);
        }];
        
        UIView* sep3 = [UIView new];
        [sep3 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep3];
        [sep3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.bottom.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.labelButton1.mas_bottom).offset(2*margin);
        }];
        
        
        [self.portraitImageView bk_whenTapped:^{
            
            LBB_GuiderUserViewController* dest = [[LBB_GuiderUserViewController alloc]init];
            LBB_SquareUgc* viewModel = [[LBB_SquareUgc alloc] init];
            viewModel.userId = ws.model.userId;
            dest.viewModel = viewModel;
            
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
        
        
        [self.nameLabel bk_whenTapped:^{
            LBB_GuiderUserViewController* dest = [[LBB_GuiderUserViewController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
    }
    return self;
}

-(void)setModel:(LBB_GuiderListViewModel*)model{
    
    _model = model;
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:model.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];

    [self.nameLabel setText:model.userName];
    [self.signLable setText:model.signed1];
    
    switch (model.tourAuditState) {//	Int	0  未提交实名认证 1  已提交实名认证，正在审核 2、认证成功 3、认证失败
        case 0://未提交实名认证
            [self.vImageView setImage:IMAGE(@"导游_导游V")];
            break;
        case 1:// 已提交实名认证，正在审核
            [self.vImageView setImage:IMAGE(@"导游_导游V")];
            break;
        case 2://认证成功
            [self.vImageView setImage:IMAGE(@"导游_导游V")];
            break;
        case 3://认证失败
            [self.vImageView setImage:IMAGE(@"导游_导游V")];
            break;
            
        default://未提交实名认证
            [self.vImageView setImage:IMAGE(@"导游_导游V")];
            break;
    }
    
    switch (model.gender) {//	Int	0女  1男  2未知（保密)
        case 0://女
            [self.genderImageView setImage:IMAGE(@"导游_女")];
            break;
        case 1://男
            [self.genderImageView setImage:IMAGE(@"导游_男")];
            break;
            
        default://未知
            [self.genderImageView setImage:IMAGE(@"导游_女")];
            break;
    }
    
    
    [racFollowState dispose];
    [racFansNum dispose];
    [racActionNum dispose];
    [racFollowNum dispose];
    @weakify(self);
    racFollowState = [RACObserve(model, followState) subscribeNext:^(NSNumber* status){
        @strongify(self);
        //0未关注1：已关注 2：互相关注
        
        switch ([status intValue]) {
            case 0:
                [self.favoriteButton setTitle:@"关注" forState:UIControlStateNormal];
                break;
            case 1:
                [self.favoriteButton setTitle:@"已关注" forState:UIControlStateNormal];
                break;
            case 2:
                [self.favoriteButton setTitle:@"互相关注" forState:UIControlStateNormal];
                break;
                
            default:
                [self.favoriteButton setTitle:@"关注" forState:UIControlStateNormal];
                break;
        }
    }];
    
    [self.favoriteLabel setText:@"关注 12"];
    [self.funsLabel setText:@"粉丝 1290"];
    [self.dynamicLabel setText:@"动态 1290"];
    //动态
    racActionNum = [RACObserve(model, actionNum) subscribeNext:^(NSNumber* num){
        @strongify(self);
        [self.dynamicLabel setText:[NSString stringWithFormat:@"动态 %d",[num intValue]]];
    }];
    
    //关注
    racFollowNum = [RACObserve(model, followNum) subscribeNext:^(NSNumber* num){
        @strongify(self);
        [self.favoriteLabel setText:[NSString stringWithFormat:@"关注 %d",[num intValue]]];
    }];
    
    //粉丝
    racFansNum = [RACObserve(model, fansNum) subscribeNext:^(NSNumber* num){
        @strongify(self);
        [self.funsLabel setText:[NSString stringWithFormat:@"粉丝 %d",[num intValue]]];
    }];
    
    //标签
    self.labelButton1.hidden = YES;
    self.labelButton2.hidden = YES;
    self.labelButton3.hidden = YES;
    
    NSInteger count = model.tourTags.count;
    if (count > 0) {
        self.labelButton1.hidden = NO;
        LBB_GuiderTags* tag = [model.tourTags objectAtIndex:0];
        [self.labelButton1 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 1){
        self.labelButton2.hidden = NO;
        LBB_GuiderTags* tag = [model.tourTags objectAtIndex:1];
        [self.labelButton2 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 2){
        self.labelButton3.hidden = NO;
        LBB_GuiderTags* tag = [model.tourTags objectAtIndex:2];
        [self.labelButton3 setTitle:tag.tagName forState:UIControlStateNormal];
    }

    WS(ws);
    CGFloat margin = 8;
    if (count <= 0) {
        [self.labelButton1 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.nameLabel);
            make.top.equalTo(signTitleLable.mas_bottom).offset(0);
            make.width.mas_equalTo(AutoSize(80/2));
            make.height.mas_equalTo(AutoSize(0));
        }];
        
        [self.labelButton2 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton1.mas_right).offset(margin);
            make.centerY.width.height.equalTo(ws.labelButton1);
        }];
        [self.labelButton3 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton2.mas_right).offset(margin);
            make.centerY.width.height.equalTo(ws.labelButton1);
        }];
    }
    else{
        [self.labelButton1 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.nameLabel);
            make.top.equalTo(signTitleLable.mas_bottom).offset(margin);
            make.width.mas_equalTo(AutoSize(80/2));
            make.height.mas_equalTo(AutoSize(30/2));
        }];
        
        [self.labelButton2 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton1.mas_right).offset(margin);
            make.centerY.width.height.equalTo(ws.labelButton1);
        }];
        [self.labelButton3 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton2.mas_right).offset(margin);
            make.centerY.width.height.equalTo(ws.labelButton1);
        }];
    }
    [self.contentView layoutSubviews];
}
@end
