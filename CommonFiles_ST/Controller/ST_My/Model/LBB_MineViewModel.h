//
//  LBB_MineViewModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/24.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_MineDetaiInfo : NSObject
@property(nonatomic,assign) NSInteger detailType;//类型
@property(nonatomic,copy) NSString *detailContent; //描述
@property(nonatomic,copy) NSString *detailImage; //icon图标
@property(nonatomic,assign) NSInteger newNum; //新增未查看数量

@end

@interface LBB_MineSectionInfo :NSObject

@property(nonatomic,assign) NSInteger setcionType;//类别
@property(nonatomic,copy) NSString *sectionContent;//类别内容
@property(nonatomic,assign) BOOL needCheckAll; //是否有查看全部
@property(nonatomic,strong) NSMutableArray<LBB_MineDetaiInfo*>* detailArary;

@end

@interface LBB_MineViewModel : NSObject

@property(nonatomic,copy) NSString *name;//用户名称
@property(nonatomic,copy) NSString *portrait;//用户头像
@property(nonatomic,assign) int  level;//级别
@property(nonatomic,copy) NSString *coverImageUrl;//封面地址
@property(nonatomic,assign) int  auditState;//用户认证状态：0  未提交实名认证 1  已提交实名认证，正在审核 2、认证成功 3、认证失败
@property(nonatomic,assign) int  tourAuditState;//导游认证状态：0  未提交实名认证 1  已提交实名认证，正在审核 2、认证成功 3、认证失败

@property(nonatomic,copy) NSString *signature;//签名
@property(nonatomic,assign) int  waitPayOrderCount;//待付款订单数
@property(nonatomic,assign) int  waitTakeOrderCount;//待取货订单数
@property(nonatomic,assign) int  waitCommentOrderCount;//待评论订单数
@property(nonatomic,assign) int  afterSaleOrderCount;//售后订单数

@property(nonatomic,assign) int  waitPayTicketCount;//待付款门票数
@property(nonatomic,assign) int  waitTakeTicketCount;//待取货门票数
@property(nonatomic,assign) int  waitCommentTicketCount;//待评论门票数
@property(nonatomic,assign) int  refundTicketCount;//售后订单

@end



@interface LBB_MineModelData : BN_BaseDataModel

@property(nonatomic,strong)LBB_MineViewModel *userInfo;
@property(nonatomic,strong) NSMutableArray<LBB_MineSectionInfo*> *sectionInfo;


/**
 3.5.1 我的-首页（已测）
 */
- (void)getMineInfo;

@end



