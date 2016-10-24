//
//  LBB_SignInListCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SignInListCell.h"

@implementation LBB_SignInListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        CGFloat interval = 8;
        
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(2*interval);
            make.top.equalTo(ws.contentView).offset(interval);
            make.bottom.equalTo(ws.contentView).offset(-interval);
            make.width.equalTo(ws.portraitImageView.mas_height);
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font6];
        [self.titleLabel setText:@"厦门鼓浪屿"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.bottom.equalTo(ws.portraitImageView.mas_centerY);
        }];
        
        self.subTitleLabel = [UILabel new];
        [self.subTitleLabel setFont:Font1];
        [self.subTitleLabel setTextColor:ColorLightGray];
        [self.subTitleLabel setText:@"船票25/人"];
        [self.contentView addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.top.equalTo(ws.portraitImageView.mas_centerY).offset(5);
        }];
        
        
        self.signinButton = [UIButton new];
        [self.signinButton setBackgroundColor:ColorBtnYellow];
        [self.signinButton setTitle:@"已签到" forState:UIControlStateNormal];
        [self.signinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.signinButton.titleLabel setFont:Font1];
        [self.contentView addSubview:self.signinButton];
        [self.signinButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.right.equalTo(ws).offset(-interval);
            make.height.equalTo(@25);
            make.width.equalTo(@80);
        }];
        
        self.rankLabel = [UILabel new];
        [self.rankLabel setFont:Font1];
        [self.rankLabel setTextColor:ColorLightGray];
        [self.rankLabel setText:@"第一名"];
        [self.contentView addSubview:self.rankLabel];
        [self.rankLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-interval);
            make.centerY.equalTo(ws.contentView);
        }];
        
        self.rankImageView = [UIImageView new];
        [self.rankImageView setImage:IMAGE(@"ST_Sign_Num1Icon")];
        [self.contentView addSubview:self.rankImageView];
        [self.rankImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.rankLabel.mas_left).offset(-2);
            make.centerY.equalTo(ws.rankLabel);
            make.width.mas_equalTo(25);
            make.height.equalTo(@25);
        }];
        
        self.arrowImageView = [UIImageView new];
        [self.arrowImageView setImage:IMAGE(@"ST_Home_Arrow")];
        [self.contentView addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.right.equalTo(ws.contentView).offset(-8);
            make.width.mas_equalTo(10);
            make.height.equalTo(@15);
        }];

        self.sep = [UIView new];
        [self.sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:self.sep];
        [self.sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.bottom.equalTo(ws.contentView);
            make.height.equalTo(@1.5);
        }];
        
        [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/8c1001e93901213fcea979fb51e736d12f2e957a.jpg"] placeholderImage:IMAGE(@"poohtest")];

        self.arrowImageView.hidden = YES;
        self.signinButton.hidden = YES;
        self.rankLabel.hidden = YES;
        self.rankImageView.hidden = YES;
        
    }
    return self;
}


-(void)showSigninButton:(BOOL)show{
    
    if (show) {
        self.signinButton.hidden = NO;
    }
    else{
        self.signinButton.hidden = YES;
    }
}

-(void)showRankMsg:(BOOL)show{
    
    if (show) {
        self.rankLabel.hidden = NO;
        self.rankImageView.hidden = NO;
    }
    else{
        self.rankLabel.hidden = YES;
        self.rankImageView.hidden = YES;
    }
}

-(void)showArrowImageView:(BOOL)show{
    
    if (show) {
        self.arrowImageView.hidden = NO;
    }
    else{
        self.arrowImageView.hidden = YES;
    }
}

-(void)setModel:(id)model{

    
    
    
}


+(CGFloat)getCellHeight{
    
    CGFloat height = 70;
  //  NSLog(@"getCellHeight:%f",height);
    return height;
}


@end
