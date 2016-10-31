//
//  LBB_TicketFooterView.m
//  ST_Travel
//
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TicketFooterView.h"

@interface LBB_TicketFooterView()
@property (assign,nonatomic) MineBaseViewType stateType;
@property (assign,nonatomic) TicketClickType clickType;

@end

@implementation LBB_TicketFooterView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.goodNumLabel.textColor = ColorBlack;
    self.totoalTipLabel.textColor = ColorBlack;
    self.goodMoneyLabel.textColor = RGBAHEX(0xFF1344, 1.0);
    
    self.goodNumLabel.font = Font13;
    self.totoalTipLabel.font = Font13;
    self.goodMoneyLabel.font = Font13;
    
    self.leftBtn.backgroundColor = ColorGray;
    self.rightBtn.backgroundColor = ColorBtnYellow;
    [self.leftBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    
    self.bgView.backgroundColor = ColorBackground;
    self.topLine.backgroundColor = ColorLine;
    self.bgLine1.backgroundColor = ColorLine;
    self.bgLine2.backgroundColor = ColorLine;
}

- (void)setCellInfo:(NSDictionary*)cellInfo
{
    self.goodNumLabel.text = [cellInfo objectForKey:@"GoogNum"];
    self.goodMoneyLabel.text = [cellInfo objectForKey:@"TotalMonney"];
    self.stateType = [[cellInfo objectForKey:@"TicketState"] intValue];
    switch (self.stateType) {
        case eTicket_WaitPay://待付款
        {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = NO;
            [self.rightBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        }
            break;
        case eTicket_WaitGetTicket://待取票
        {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = YES;
            [self.rightBtn setTitle:@"立即取票" forState:UIControlStateNormal];
        }
            break;
        case eTicket_WaitComment://待评价
        {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = YES;
            [self.rightBtn setTitle:@"立即评价" forState:UIControlStateNormal];
        }
            break;
        case eTicket_Refund://退款
        {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = YES;
            [self.rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UI Action

- (IBAction)rightBtnAction:(id)sender {
    if (self.mDelegate &&
        [self.mDelegate respondsToSelector:@selector(cellBtnClickDelegate:StateType:TicketClickType:)]) {
        [self.mDelegate cellBtnClickDelegate:self.cellInfo
                                   StateType:self.stateType
                             TicketClickType:[self clickType:NO]];
    }
}

- (IBAction)leftBtnAction:(id)sender {
    
    if (self.mDelegate &&
        [self.mDelegate respondsToSelector:@selector(cellBtnClickDelegate:StateType:TicketClickType:)]) {
        [self.mDelegate cellBtnClickDelegate:self.cellInfo
                                   StateType:self.stateType
                             TicketClickType:[self clickType:YES]];
    }
}

- (TicketClickType)clickType:(BOOL)isLeft
{
    if (isLeft) {
        switch (self.stateType) {
            case eTicket_WaitPay:
            {
                _clickType = eCancelTicket;
            }
                break;
                
            default:
                break;
        }
    }else {
        switch (self.stateType) {
            case eTicket_WaitPay:
            {
                _clickType = eTicketPay;
            }
                break;
            case eTicket_WaitGetTicket:
            {
                _clickType = eGetTicket;
            }
                break;
            case eTicket_WaitComment:
            {
                _clickType = eComment;
            }
                break;
            case eTicket_Refund:
            {
                _clickType = eShowDetail;
            }
                break;
            default:
                break;
        }
    }
    return _clickType;
}

@end
