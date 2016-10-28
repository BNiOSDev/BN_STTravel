//
//  LBB_OrderPayWayCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderPayWayCell.h"

@implementation LBB_OrderPayWayCell

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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        CGFloat interval = 8;
        
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(interval);
            make.top.equalTo(ws.contentView).offset(interval);
            make.bottom.equalTo(ws.contentView).offset(-interval);
            make.width.height.mas_equalTo(AutoSize(78/2));
        }];
        self.portraitImageView.layer.cornerRadius = 5;
        self.portraitImageView.layer.masksToBounds = YES;
        
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font15];
        [self.titleLabel setText:@"厦门鼓浪屿"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.bottom.equalTo(ws.portraitImageView.mas_centerY);
        }];
        
        self.subTitleLabel = [UILabel new];
        [self.subTitleLabel setFont:Font14];
        [self.subTitleLabel setTextColor:ColorLightGray];
        [self.subTitleLabel setText:@"船票25/人"];
        [self.contentView addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.top.equalTo(ws.portraitImageView.mas_centerY).offset(5);
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
            make.centerX.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.left.equalTo(ws.portraitImageView).offset(interval);
            make.right.equalTo(ws.contentView).offset(-3*interval);

        }];
    }
    return self;
}

@end
