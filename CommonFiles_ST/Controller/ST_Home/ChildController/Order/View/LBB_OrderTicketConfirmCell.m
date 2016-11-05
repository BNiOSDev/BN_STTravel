//
//  LBB_OrderTicketConfirmCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderTicketConfirmCell.h"
#import "LBB_OrderPayWayViewController.h"
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
        [self.titleLabel setTextColor:ColorGray];
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
        
        self.leftButton = [UIButton new];
        [self.leftButton setBackgroundColor:ColorLightGray];
        [self.leftButton setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.leftButton.titleLabel setFont:Font15];
        [self.contentView addSubview:self.leftButton];
        
        self.rightButton = [UIButton new];
        [self.rightButton setBackgroundColor:ColorBtnYellow];
        [self.rightButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightButton.titleLabel setFont:Font15];
        [self.contentView addSubview:self.rightButton];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.timeLabel);
            make.top.equalTo(sep2.mas_bottom).offset(2*margin);
            make.bottom.equalTo(ws.contentView).offset(-2*margin);
            make.width.mas_equalTo(AutoSize(190/2));
            make.height.mas_equalTo(AutoSize(54/2));

        }];
        
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.rightButton.mas_left).offset(-2*margin);
            make.centerY.width.height.equalTo(ws.rightButton);
            
        }];
        
        
    }
    return self;
}

-(void)setModel:(id)model{

    WS(ws);
    self.leftButton.hidden = NO;
    self.rightButton.hidden = NO;
    
    switch (self.ticketStatus) {
        case LBBPoohTicketStatusWaitPay:
        {
            
            [self.leftButton setTitle:@"删除订单" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"立即支付" forState:UIControlStateNormal];

            [self.leftButton bk_addEventHandler:^(id sender){
                
                [[ws getViewController].navigationController popViewControllerAnimated:YES];
                
            } forControlEvents:UIControlEventTouchUpInside];
            
            [self.rightButton bk_addEventHandler:^(id sender){
                
                LBB_OrderPayWayViewController* dest = [[LBB_OrderPayWayViewController alloc]init];
                [[ws getViewController].navigationController pushViewController:dest animated:YES];
                
            } forControlEvents:UIControlEventTouchUpInside];
        }
            
            break;
        case LBBPoohTicketStatusWaitCollect:
        {
            self.leftButton.hidden = YES;
            [self.rightButton setTitle:@"退票" forState:UIControlStateNormal];
        }
            
            break;
        case LBBPoohTicketStatusCollected:
        {
            self.leftButton.hidden = YES;
            [self.rightButton setTitle:@"立即评价" forState:UIControlStateNormal];
            [self.rightButton bk_addEventHandler:^(id sender){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TicketCommentNotification"
                                                                object:@{@"TicketState" : @(LBBPoohTicketStatusCollected)}];
                
            } forControlEvents:UIControlEventTouchUpInside];
        }
            
            break;
        case LBBPoohTicketStatusRefunded:
        {
            self.leftButton.hidden = YES;
            [self.rightButton setTitle:@"确认完成" forState:UIControlStateNormal];
        }
            break;
    }

    
}

@end
