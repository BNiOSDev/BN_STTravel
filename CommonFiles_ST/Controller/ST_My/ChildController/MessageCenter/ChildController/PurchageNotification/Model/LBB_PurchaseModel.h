//
//  LBB_PurchaseModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_PurchaseModel : BN_BaseDataModel

@property(nonatomic,assign) long obj_id;//商品id
@property(nonatomic,copy) NSString *title;//标题
@property(nonatomic,copy) NSString *msg_image;//列表缩略图
@property(nonatomic,copy) NSString *createtime;//时间
@property(nonatomic,copy) NSString *msg_abstract;//消息内容

@end


@interface LBB_PurchaseViewModel : BN_BaseDataModel

@property(nonatomic,strong)NSMutableArray<LBB_PurchaseModel*> *dataArray;

/**
 *3.10.3 消息-购买通知(已测)
 */
- (void)getPurchaseDataArray:(BOOL)isClear;

@end
