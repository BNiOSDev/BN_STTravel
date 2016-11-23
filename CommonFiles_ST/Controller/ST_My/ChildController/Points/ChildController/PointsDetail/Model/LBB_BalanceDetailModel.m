//
//  LBB_BalanceDetailModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/11.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_BalanceDetailModel.h"

@implementation LBB_BalanceDetailModel

@end


@implementation LBB_BalanceDataModel

- (NSArray<LBB_BalanceDetailModel*>*)getData
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        LBB_BalanceDetailModel *detailModel = [[LBB_BalanceDetailModel alloc] init];
        detailModel.content = @"兑换积分一百积分兑换积分一百积分兑换积分一百积分兑换";
        detailModel.dateStr = @"2016-01-22 12:01";
        detailModel.num = 1000000000000;
        if (i%2 == 0) {
            detailModel.num = -99;
        }
        [dataArray addObject:detailModel];
    }
    
    return dataArray;
}

@end
