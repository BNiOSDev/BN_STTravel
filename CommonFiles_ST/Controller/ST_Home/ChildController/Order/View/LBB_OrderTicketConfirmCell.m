//
//  LBB_OrderTicketConfirmCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderTicketConfirmCell.h"

@implementation LBB_OrderTicketConfirmCell

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
        
        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font15];
        [self.titleLabel setText:@"订单时间"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.top.equalTo(sep1.mas_bottom).offset(2* margin);
        }];
        
        self.timeLabel = [UILabel new];
        [self.timeLabel setFont:Font15];
        [self.timeLabel setTextColor:ColorLightGray];
        [self.timeLabel setText:@"2016-10-10 12:12:12"];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.centerY.equalTo(ws.titleLabel);
        }];
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(2*margin);
        }];
        
        self.deleteButton = [UIButton new];
        [self.deleteButton setBackgroundColor:ColorLightGray];
        [self.deleteButton setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.deleteButton.titleLabel setFont:Font15];
        [self.contentView addSubview:self.deleteButton];
        
        self.payButton = [UIButton new];
        [self.payButton setBackgroundColor:ColorBtnYellow];
        [self.payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.payButton.titleLabel setFont:Font15];
        [self.contentView addSubview:self.payButton];
        
        [self.payButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.timeLabel);
            make.top.equalTo(sep2.mas_bottom).offset(2*margin);
            make.bottom.equalTo(ws.contentView).offset(-2*margin);
            make.width.mas_equalTo(AutoSize(190/2));
            make.height.mas_equalTo(AutoSize(54/2));

        }];
        
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.payButton.mas_left).offset(-2*margin);
            make.centerY.width.height.equalTo(ws.payButton);
            
        }];
        
        
    }
    return self;
}

@end
