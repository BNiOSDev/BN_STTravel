//
//  LBB_GuiderMainCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderMainCell.h"
#import "LBB_GuiderUserViewController.h"
@implementation LBB_GuiderMainCell

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
        [identity setText:@"认证"];
        [identity setTextColor:ColorLightGray];
        [identity setFont:Font13];
        [self.contentView addSubview:identity];
        [identity mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.nameLabel);
            make.top.equalTo(ws.favoriteLabel.mas_bottom).offset(margin);
        }];
        
        self.identityLable = [UILabel new];
        [self.identityLable setFont:Font13];
        [self.identityLable setText:@"健康导游"];
        [self.contentView addSubview:self.identityLable];
        [self.identityLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(identity.mas_right).offset(margin);
            make.centerY.equalTo(identity);
        }];
        
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
            make.top.equalTo(sign.mas_bottom).offset(margin);
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
        
        
    }
    return self;
}

-(void)setModel:(id)model{
    WS(ws);
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

    [self.portraitImageView bk_whenTapped:^{
        
        LBB_GuiderUserViewController* dest = [[LBB_GuiderUserViewController alloc]init];
        [[ws getViewController].navigationController pushViewController:dest animated:YES];
    }];
    
}
@end
