//
//  BN_SquareTravelNotesBillModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 消费比例
 */
@interface BN_SquareTravelNotesConsumeRatios : BN_BaseDataModel

@property(nonatomic, assign)int consumptionType;//	int	消费类型 1 民宿 2 交通 3 美食 4 门票 5 娱乐 6 购物 7 其他

@property(nonatomic, assign)int ratio;//	int	比例
@property(nonatomic, strong)NSString* amount;//	String	金额

@end


/**
消费明细
 */
@interface BN_SquareTravelNotesconsumeDetails : BN_BaseDataModel

@property(nonatomic, assign)long consumeDetailId;//	Long	主键
@property(nonatomic, assign)int whitchDay;//	Int	第几天
@property(nonatomic, strong)NSString* releaseDate;//	String	发布日期
@property(nonatomic, strong)NSString* releaseTime;//	String	发布时间
@property(nonatomic, assign)int allSpotsType;//	int	场景类型 1美食 2 民宿 3 景点
@property(nonatomic, strong)NSString* name;	//String	名称
@property(nonatomic, strong)NSString* amount;//	String	金额
@property(nonatomic, assign)int consumptionType;//	int	消费类型 1 民宿 2 交通 3 美食 4 门票 5 娱乐 6 购物 7 其他
@property(nonatomic, strong)NSString* consumptionDesc;//	String	消费描述


//游记账单消费明细父数组,必须传入
@property(nonatomic, weak)NSMutableArray<BN_SquareTravelNotesconsumeDetails*> *parentArray;


/**
 3.4.19 主页-游记消费编辑（已测）
 */
-(void)modifySquareTravelNotesConsumeDetails:(void (^)(NSError *error))block;


/**
 3.4.20 主页-游记消费删除（已测）

 @param block 操作回调
 */
-(void)deleteSquareTravelNotesConsumeDetails:(void (^)(NSError *error))block;


@end

/**
 3.4.18 主页-游记账单（已测）
 */
@interface BN_SquareTravelNotesBillModel : BN_BaseDataModel


@property(nonatomic, strong)NSString* totalAmount;//	String	消费总金额
@property(nonatomic, strong)NSMutableArray<BN_SquareTravelNotesConsumeRatios*>* consumeRatios;	//List	消费比例
@property(nonatomic, strong)NSMutableArray<BN_SquareTravelNotesconsumeDetails*>* consumeDetails;//	List	消费明细



@end
