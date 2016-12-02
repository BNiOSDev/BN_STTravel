//
//  LBB_MessageCenterModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/12/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_MessageCenterModel : BN_BaseDataModel

@property(nonatomic,copy) NSString *onsaleTitle;//优惠促销标题
@property(nonatomic,copy) NSString *onsaleTime;//优惠促销时间
@property(nonatomic,copy) NSString *buyTitle;//购买备注
@property(nonatomic,copy) NSString *buyTime;//购买时间
@property(nonatomic,copy) NSString *noticeTitle;//通知备注
@property(nonatomic,copy) NSString *noticeTime;//通知时间
@property(nonatomic,copy) NSString *squareName;//广场游记备注
@property(nonatomic,copy) NSString *squareTime;//广场游记时间

/**
 *3.10.2 消息-消息中心(已测)
 */
- (void)getMessage;

@end
