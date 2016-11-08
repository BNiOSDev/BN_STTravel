//
//  LBB_TicketModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_TicketModelDetail :NSObject

@property (nonatomic,copy) NSString *detailID;//物品ID
@property (nonatomic,copy) NSString *ticketImagePath; //物品图片
@property (nonatomic,copy) NSString *content;//物品描述
@property (nonatomic,copy) NSString *typeContent;//物品类型
@property (nonatomic,assign) NSInteger num;//物品总数
@property (nonatomic,assign) NSInteger money;//物品总额
@property (nonatomic,assign) NSInteger ticketState; //订单状态（代付款 待取票 待评价 退款）

@end


@interface LBB_TicketModelData : NSObject

@property (nonatomic,copy) NSString *ticketID;//订单ID
@property (nonatomic,assign) NSInteger totalNum;//订单物品总数
@property (nonatomic,assign) NSInteger totalMoney;//订单总额
@property (nonatomic,assign) NSInteger  ticketState; //订单状态（代付款 待取票 待评价 退款）
@property (nonatomic,copy) NSArray<LBB_TicketModelDetail *> *detailArray; //订单物品数组

@end

@interface LBB_TicketModel : NSObject

- (NSArray<LBB_TicketModelData *> *)getDataWithType:(NSInteger)ticketState;

@end
