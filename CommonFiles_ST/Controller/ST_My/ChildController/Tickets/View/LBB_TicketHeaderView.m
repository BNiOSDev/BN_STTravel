//
//  LBB_TicketHeaderView.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TicketHeaderView.h"
#import "Mine_Common.h"

@interface LBB_TicketHeaderView()
@property (assign,nonatomic) MineBaseViewType stateType;
@end

@implementation LBB_TicketHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.numTipsLabel.textColor = ColorBlack;
    self.numLabel.textColor = ColorBlack;
    self.stateLabel.textColor = ColorBtnYellow;
    
    self.numTipsLabel.font = Font13;
    self.numLabel.font = Font13;
    self.stateLabel.font = Font13;
    self.lineView.backgroundColor = ColorLine;
}

- (void)setCellInfo:(NSDictionary*)cellInfo
{
    self.numLabel.text = [cellInfo objectForKey:@"TicketNum"];
    self.stateType = [[cellInfo objectForKey:@"TicketState"] intValue];
    
    switch (self.stateType) {
        case eTicket_WaitPay://待付款
        {
          self.stateLabel.text = @"待支付";
        }
            break;
        case eTicket_WaitGetTicket://待取票
        {
            self.stateLabel.text = @"待取票";
        }
            break;
        case eTicket_WaitComment://待评价
        {
            self.stateLabel.text = @"待评价";
        }
            break;
        case eTicket_Refund://退款
        {
            self.stateLabel.text = @"已退款";
        }
            break;
        default:
            break;
    }
}

@end
