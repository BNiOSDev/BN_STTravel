//
//  LBB_BalanceDetailModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/11.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_BalanceDetailModel : BN_BaseDataModel

@property(nonatomic,assign)long detailId;//明细主键
@property(nonatomic,copy) NSString *remark;//明细备注
@property(nonatomic,copy) NSString *amount;//金额
@property(nonatomic,copy) NSString *createTime;//日期

@end


@interface LBB_BalanceViewModel : BN_BaseDataModel

@property(nonatomic,strong) NSMutableArray <LBB_BalanceDetailModel*> *banlanceArray;

/**
 *3.5.11 我的-积分明细（已测）
 */
- (void)getMyCreditDetail:(BOOL)isClear;

@end
