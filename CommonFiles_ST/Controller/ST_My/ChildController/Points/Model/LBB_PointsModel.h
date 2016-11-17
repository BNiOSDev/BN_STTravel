//
//  LBB_PointsModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/10.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_PointsDetailModel : NSObject

@property(nonatomic,assign) NSInteger myPoints;//我的积分
@property(nonatomic,assign) NSInteger convertiblePoints;//可兑换积分
@property(nonatomic,assign) NSInteger haveConvertedPoints;//已兑换积分
@property(nonatomic,assign) NSInteger totalPoints;//累计总积分
@property(nonatomic,copy)   NSString  *descURL;//积分兑换说明URL


@end

@interface LBB_PointsModel : NSObject

- (LBB_PointsDetailModel*)getData;

@end
