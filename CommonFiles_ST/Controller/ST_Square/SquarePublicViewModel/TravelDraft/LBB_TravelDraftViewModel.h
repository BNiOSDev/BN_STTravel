//
//  LBB_TravelDraftViewModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BN_SquareTravelNotesModel.h"

@interface LBB_TravelDraftViewModel : BN_BaseDataModel


@property(nonatomic, strong)BN_SquareTravelNotesModel* travelDraftModel;
/**
 3.4.17 主页-游记详情/游记下载（已测），不传travelNotesId,获取草稿
 */
-(void)getTravelDraftData;


/**
 3.4.21 主页-游记修改草稿保存（已测）
 */
-(void)saveTravelDraftData:(void (^)(NSError *error))block;;

/**
 3.4.22 主页-游记删除（已测）
 */
-(void)deleteTravelDraftData:(void (^)(NSError *error))block;;

/**
3.4.23 主页-游记发布（已测）
 */
-(void)publicTravelDraftData:(void (^)(NSError *error))block;;





@end
