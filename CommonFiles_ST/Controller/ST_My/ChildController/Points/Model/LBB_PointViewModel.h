//
//  LBB_PointViewModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_PointViewModel : BN_BaseDataModel

@property(nonatomic,assign)  int unused;//可用积分
@property(nonatomic,assign)  int used;//使用积分
@property(nonatomic,assign)  int total;//总积分

@property(nonatomic,assign) NSInteger totalPoints;//累计总积分
@property(nonatomic,copy)   NSString  *descURL;//积分兑换说明URL

/**
 *3.5.10 我的-积分（已测）
 */
- (void)getPointData;


@end
