//
//  LBBHomeHotestTableViewCellItem.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeHotestTableViewCellItem.h"
#import "PoohCommon.h"

@implementation LBBHomeHotestTableViewCellItem


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    WS(ws);
    if (self) {
     
        self.mainImageView = [UIImageView new];
        [self.contentView addSubview:self.mainImageView];
        [self.mainImageView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(186/2));
        }];
        
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentView).offset(5);
            make.right.equalTo(ws.contentView).offset(-5);
           // make.height.width.mas_equalTo(25);
        }];

        
        self.titleLabel = [UILabel new];

        [self.titleLabel setFont:Font12];
        [self.titleLabel setText:@"曾厝垵"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(ws.mainImageView.mas_bottom).offset(8);
            
        }];

        self.disView = [[UIButton alloc]init];
        [self.disView setImage:IMAGE(@"ST_Home_Comments") forState:UIControlStateNormal];
        [self.disView setTitle:@"1000" forState:UIControlStateNormal];
        [self.disView.titleLabel setFont:Font12];
        [self.disView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.disView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [self.contentView addSubview:self.disView];
        [self.disView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(8);
            make.bottom.equalTo(ws.contentView).offset(-3);
          //  make.height.equalTo(@16);
        }];

        
        self.greetView = [[UIButton alloc]init];
        [self.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        [self.greetView setTitle:@"1000" forState:UIControlStateNormal];
        [self.greetView.titleLabel setFont:Font12];
        [self.greetView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greetView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [self.contentView addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.disView.mas_right).offset(8);
            make.centerY.height.equalTo(ws.disView);
        }];
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setText:@"120元起/人"];
        [self.priceLabel setTextColor:ColorBtnYellow];
        [self.priceLabel setFont:Font8];
        [self.priceLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.right.equalTo(ws.contentView);
            make.centerY.height.equalTo(ws.disView);
        }];
        
        [self layoutSubviews];//it must to be done to layouts subviews

    }
    return self;
}

@end
