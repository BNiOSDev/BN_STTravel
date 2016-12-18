//
//  LBB_GuiderListViewModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/10.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_GuiderConditionOption.h"

@interface LBB_GuiderTags : BN_BaseDataModel

@property (nonatomic, assign)long tagId ;// 标签ID
@property (nonatomic, strong)NSString *tagName ;// 标签名称

@end

@interface LBB_GuiderListViewModel : BN_BaseDataModel

@property(nonatomic, assign)long userId;//	Long	用户ID
@property(nonatomic, strong)NSString* userPicUrl;//	String	用户头像
@property(nonatomic, strong)NSString* userName;//	String	用户名
@property(nonatomic, assign)int tourAuditState;//	Int	0  未提交实名认证 1  已提交实名认证，正在审核 2、认证成功 3、认证失败
@property(nonatomic, assign)int gender;//	Int	0女  1男  2未知（保密)
@property(nonatomic, assign)int actionNum;//	Int	动态数量
@property(nonatomic, assign)int followNum;//	Int	关注数
@property(nonatomic, assign)int fansNum;//	Int	粉丝数
//auditTags	List	认证标签（已删除）
@property(nonatomic, strong)NSMutableArray<LBB_GuiderTags*>* tourTags;//	List	导游标签
@property(nonatomic, strong)NSString* signed1;//	String	签名
@property(nonatomic, assign)int followState	;//int	点赞标志 0关注 1：已关注 2: 相互关注

/**
 3.4.3	广场-广场主页-好友关注（已测）
 
 @param block 回调block
 */
- (void)attention:(void (^)(NSError *error))block;

@end

@interface LBB_GuiderViewModel : BN_BaseDataModel

@property (nonatomic,strong)LBB_GuiderCondition *guiderCondition;//导游筛选条件

@property(nonatomic, strong)NSMutableArray<LBB_GuiderListViewModel*>* guiderListArray;


/**
 3.7.5 导游 – 查询条件（已测）
 */
- (void)getGuiderConditions;


/**
 3.7.6 导游 -列表（已测）
 @param name       模糊查询名字
 @param tagKey     标签key
 @param jobTimeKey 工作时长key
 @param genderKey  性别key
 @param clear      清空原数据
 */
-(void)getGuiderListArray:(NSString*)name
                   tagKey:(int)tagKey
               jobTimeKey:(int)jobTimeKey
                genderKey:(int)genderKey
                    clear:(BOOL)clear;


@end
