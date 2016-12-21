//
//  LBB_DiscoveryDownLoadManager.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_DiscoveryViewModel.h"
@interface LBB_DiscoveryDownLoadManager : UIView

+ (id)sharedInstance;


/**
 保存攻略

 @param model 传入的数据模型
 @param vc    当前页面的self引用
 */
-(void)saveDiscoveryDetail:(LBB_DiscoveryDetailModel*)model curVC:(Base_BaseViewController*)vc;


/**
 获取保存在本地的攻略数组

 @return 保存在本地的攻略数组
 */
-(NSMutableArray<LBB_DiscoveryDetailModel*>*)getDiscoveryDetailArray;


/**
 删除攻略

 @param model 要删除的攻略
 */
-(void)deleteDiscoveryDetail:(LBB_DiscoveryDetailModel*)model
                        succ:(void(^)(NSError* error))succBlock;

@end
