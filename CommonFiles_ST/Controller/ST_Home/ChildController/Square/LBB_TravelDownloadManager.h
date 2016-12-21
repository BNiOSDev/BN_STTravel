//
//  LBB_TravelDownloadManager.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BN_SquareTravelNotesModel.h"

@interface LBB_TravelDownloadManager : NSObject

+ (id)sharedInstance;


/**
 保存攻略
 
 @param model 传入的数据模型
 @param vc    当前页面的self引用
 */
-(void)saveTravelDetail:(BN_SquareTravelNotesModel*)model curVC:(Base_BaseViewController*)vc;


/**
 获取保存在本地的攻略数组
 
 @return 保存在本地的攻略数组
 */
-(NSMutableArray<BN_SquareTravelNotesModel*>*)getTravelDetailArray;


/**
 删除攻略
 
 @param model 要删除的攻略
 */
-(void)deleteTravelDetail:(BN_SquareTravelNotesModel*)model
                     succ:(void(^)(NSError* error))succBlock;

@end
