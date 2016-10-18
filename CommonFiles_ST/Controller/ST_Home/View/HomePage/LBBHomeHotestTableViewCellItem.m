//
//  LBBHomeHotestTableViewCellItem.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeHotestTableViewCellItem.h"

@implementation LBBHomeHotestTableViewCellItem


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    WS(ws);
    if (self) {
     
        [self setBackgroundColor:[UIColor purpleColor]];

        
        self.mainImageView = [UIImageView new];
        [self.contentView addSubview:self.mainImageView];
        [self.mainImageView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.top.left.right.equalTo(ws.contentView);
        }];
        
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setImage:IMAGE(@"PoohFavorite") forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentView).offset(5);
            make.right.equalTo(ws.contentView).offset(-5);
            make.height.width.mas_equalTo(25);
        }];
        [self.favoriteButton bk_addEventHandler:^(id sender){
        
            NSLog(@"favoriteButton touch");
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font3];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView);
            make.top.equalTo(ws.mainImageView.mas_bottom).offset(2);
        }];
        [self.titleLabel setBackgroundColor:[UIColor redColor]];

        self.disView = [[LBBPoohGreatItemView alloc]init];
        [self.disView setBackgroundColor:[UIColor blueColor]];

        [self.disView.iconView setImage:IMAGE(@"poohComment")];
        [self.disView.desLabel setText:@"1000"];
        [self.contentView addSubview:self.disView];
        [self.disView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(8);
            make.bottom.equalTo(ws.contentView).offset(-3);
            make.height.equalTo(@25);
        }];
        
        [self.disView bk_addEventHandler:^(id sender){
            
            NSLog(@"disView touch");
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        self.greetView = [[LBBPoohGreatItemView alloc]init];
        [self.greetView setBackgroundColor:[UIColor yellowColor]];
        [self.greetView.iconView setImage:IMAGE(@"poohGreat")];
        [self.greetView.desLabel setText:@"190"];
        [self.contentView addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.disView.mas_right).offset(8);
            make.centerY.height.equalTo(ws.disView);
        }];
        [self.greetView bk_addEventHandler:^(id sender){
            
            NSLog(@"greetView touch");
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setText:@"120元起/人"];
        [self.priceLabel setTextColor:[UIConstants getProminentFillColor]];
        [self.priceLabel setFont:Font5];
        [self.priceLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.right.equalTo(ws.contentView);
            make.centerY.height.equalTo(ws.disView);
        }];
        
      //  [self layoutSubviews];//it must to be done to layouts subviews

    }
    return self;
}

@end
