//
//  LBB_TicketFooterView.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/26.
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
    self.goodNumLabel.textColor = ColorGray;
    self.totoalTipLabel.textColor = ColorGray;
    self.goodMoneyLabel.textColor = ColorRed;
    
    self.goodNumLabel.font = Font15;
    self.totoalTipLabel.font = Font15;
    self.goodMoneyLabel.font = Font15;
    
    self.leftBtn.backgroundColor = ColorLightGray;
    self.rightBtn.backgroundColor = ColorBtnYellow;
    [self.leftBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    [self.leftBtn.titleLabel setFont:Font15];
    [self.rightBtn.titleLabel setFont:Font15];
    
    self.bgView.backgroundColor = ColorBackground;
    self.topLine.backgroundColor = ColorLine;
    self.bgLine1.backgroundColor = ColorLine;
    self.bgLine2.backgroundColor = ColorLine;
}

- (void)setCellInfo:(LBB_TicketModelData*)cellInfo
{
    _cellInfo = cellInfo;
    self.goodNumLabel.text = [NSString stringWithFormat:@"共%@件商品",@(cellInfo.totalNum)];
    self.goodMoneyLabel.text = [NSString stringWithFormat:@"￥%@",@(cellInfo.totalMoney)];
    self.stateType = cellInfo.ticketState;
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
