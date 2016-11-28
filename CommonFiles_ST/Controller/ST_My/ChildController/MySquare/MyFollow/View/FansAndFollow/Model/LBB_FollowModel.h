//
//  LBB_FollowModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_FollowModel : BN_BaseDataModel

@property(nonatomic,assign) long userId;//用户ID
@property(nonatomic,copy) NSString* chatId;//聊天ID
@property(nonatomic,copy) NSString* userName;//用户名称
@property(nonatomic,copy) NSString* userPicUrl;//用户头像
@property(nonatomic,assign) int  level;//级别
@property(nonatomic,assign) int  auditState;//用户认证状态：0  未提交实名认证 1  已提交实名认证，正在审核 2、认证成功 3、认证失败
@property(nonatomic,assign) int  tourAuditState;//导游认证状态：0  未提交实名认证 1  已提交实名认证，正在审核 2、认证成功 3、认证失败
@property(nonatomic,copy) NSString* signature;//签名
@property(nonatomic,assign) int  followState;//关注关系 0未关注2：互相关注

@end


@interface LBB_FollowViewModel : BN_BaseDataModel

@property(nonatomic,strong) NSMutableArray<LBB_FollowModel*>* dataArray;

/**
 *3.5.8 我的-广场 粉丝列表（已测）
 *3.5.9 我的-广场 关注列表（已测）
 @parames  listType   1:粉丝列表  2:关注列表
 */
- (void)getDataList:(int)listType IsClear:(BOOL)isClear;

@end
