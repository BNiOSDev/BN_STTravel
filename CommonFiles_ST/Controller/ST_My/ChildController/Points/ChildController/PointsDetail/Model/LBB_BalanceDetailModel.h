//
//  LBB_BalanceDetailModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/11.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_BalanceDetailModel : NSObject

@property(nonatomic,copy) NSString *content;//描述
@property(nonatomic,copy) NSString *dateStr;//日期
@property(nonatomic,assign) NSInteger num;//数量

@end


@interface LBB_BalanceDataModel : NSObject

- (NSArray<LBB_BalanceDetailModel*>*)getData;

@end
