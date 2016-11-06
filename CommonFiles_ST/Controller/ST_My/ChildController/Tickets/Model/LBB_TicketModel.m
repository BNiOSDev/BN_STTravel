//
//  LBB_TicketModel.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TicketModel.h"
#import "Mine_Common.h"

@implementation LBB_TicketModelDetail


@end


@implementation LBB_TicketModelData


@end

@implementation LBB_TicketModel

- (NSArray<LBB_TicketModelDetail *> *)getDataWithType:(NSInteger)ticketState
{
    //查看全部数据
    BOOL isNeedAllType = (ticketState == eTickets) ? YES : NO;
    
    NSMutableArray *ticketArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i++) {
        
        if (isNeedAllType) {//查看全部数据时 每种类型至少加载一个
            if (ticketState == eTickets) {
                ticketState = eTicket_WaitPay;
            }else if(ticketState == eTicket_WaitPay){
                ticketState = eTicket_WaitGetTicket;
            }else if(ticketState == eTicket_WaitGetTicket){
                ticketState = eTicket_WaitComment;
            }else if(ticketState == eTicket_WaitComment) {
                ticketState = eTicket_Refund;
            }
        }
        
        LBB_TicketModelData *ticketModel = [[LBB_TicketModelData alloc] init];
        ticketModel.ticketID = [NSString stringWithFormat:@"%@+100",@(i)];
        ticketModel.totalNum = ((i+1)%2) ? (i+1)%2 : (i+1)/2;
        NSInteger money = 0;
       NSMutableArray *detailArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < ticketModel.totalNum ; j++) {
            LBB_TicketModelDetail *detail = [[LBB_TicketModelDetail alloc] init];
            detail.detailID = [NSString stringWithFormat:@"%@*100 + 1",@(i)];
            detail.ticketImagePath = @"19.pic.jpg";
            detail.content = @"鼓浪屿船票，中山街门票，日光岩看票，五缘湾观光光票";
            detail.typeContent = @"成人票的";
            detail.num = j;
            detail.money = (j + i) * 10;
            detail.ticketState = ticketState;
            money += detail.money;
            [detailArray addObject:detail];
        }
        ticketModel.detailArray = detailArray;
        ticketModel.totalMoney = money;
        ticketModel.ticketState = ticketState;
        [ticketArray addObject:ticketModel];
      
    }
    
    return ticketArray;
}

@end

