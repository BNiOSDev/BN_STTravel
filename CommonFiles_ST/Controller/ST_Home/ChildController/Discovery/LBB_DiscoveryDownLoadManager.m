//
//  LBB_DiscoveryDownLoadManager.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryDownLoadManager.h"

@implementation LBB_DiscoveryDownLoadManager

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

/**
 保存攻略
 
 @param model 传入的数据模型
 @param vc    当前页面的self引用
 */
-(void)saveDiscoveryDetail:(LBB_DiscoveryDetailModel*)model curVC:(Base_BaseViewController*)vc{

    NSMutableArray* detailModelArray = [self getDiscoveryDetailArray];
    
    BOOL isExit = NO;
    for (LBB_DiscoveryDetailModel* obj in detailModelArray) {
        
        if (model.lineId == obj.lineId) {
            isExit = YES;
            break;
        }
    }
    
    if (isExit) {
        
        [vc showHudPrompt:@"攻略已下载"];
        NSLog(@"攻略已下载");
    }
    else{
        NSMutableDictionary* dic = [model mj_keyValues];
        dic[@"debugDescription"] = nil;
        dic[@"loadSupport"] = nil;
        dic[@"superclass"] = nil;
        dic[@"description"] = nil;
        dic[@"hash"] = nil;
        NSMutableArray* array = [self getDiscoveryDetailDicArray];
        [array addObject:dic];
        
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"LBB_DiscoveryDetailArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"saveDiscoveryDetail:%@",dic);
        [vc showHudPrompt:@"攻略下载成功"];
        NSLog(@"攻略下载成功");
    }
}

/**
 删除攻略
 
 @param model 要删除的攻略
 */
-(void)deleteDiscoveryDetail:(LBB_DiscoveryDetailModel*)model
                        succ:(void(^)(NSError* error))succBlock{
    NSMutableArray* detailModelArray = [self getDiscoveryDetailArray];
    
    LBB_DiscoveryDetailModel* deleteObj;
    BOOL isExit = NO;
    for (LBB_DiscoveryDetailModel* obj in detailModelArray) {
        
        if (model.lineId == obj.lineId) {
            deleteObj = obj;
            isExit = YES;
            break;
        }
    }
    
    if (isExit) {
        [detailModelArray removeObject:deleteObj];//移除对象
        
        NSMutableArray* saveDic = [[NSMutableArray alloc] init];
        for (LBB_DiscoveryDetailModel* obj in detailModelArray) {
            NSMutableDictionary* dic = [obj mj_keyValues];
            dic[@"debugDescription"] = nil;
            dic[@"loadSupport"] = nil;
            dic[@"superclass"] = nil;
            dic[@"description"] = nil;
            dic[@"hash"] = nil;
            [saveDic addObject:dic];
        }
        [[NSUserDefaults standardUserDefaults] setObject:saveDic forKey:@"LBB_DiscoveryDetailArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"deleteDiscoveryDetail:%@",saveDic);
        succBlock(nil);

    }
    else{
        NSLog(@"deleteDiscoveryDetail 不存在");
        NSString *errorStr = @"攻略不存在";
        succBlock([NSError errorWithDomain:errorStr
                                      code:1
                                  userInfo:nil]);
    }

}

/**
 获取保存在本地的攻略数组字典
 
 @return 保存在本地的攻略数组
 */
-(NSMutableArray*)getDiscoveryDetailDicArray{
    
    NSArray* array = [[NSUserDefaults standardUserDefaults] objectForKey:@"LBB_DiscoveryDetailArray"];
    
    if (array.count <= 0) {
        return [[NSMutableArray alloc] init];
    }
    NSLog(@"getDiscoveryDetailDicArray:%@",array);
    return [NSMutableArray arrayWithArray:array];
}

/**
 获取保存在本地的攻略数组模型
 
 @return 保存在本地的攻略数组
 */
-(NSMutableArray<LBB_DiscoveryDetailModel*>*)getDiscoveryDetailArray{
    
    NSArray* array = [[NSUserDefaults standardUserDefaults] objectForKey:@"LBB_DiscoveryDetailArray"];
    
    if (array.count <= 0) {
        return [[NSMutableArray alloc] init];
    }
    NSLog(@"getDiscoveryDetailArray:%@",array);
    
    NSMutableArray *returnArray = [LBB_DiscoveryDetailModel mj_objectArrayWithKeyValuesArray:array];
    return returnArray;
}



@end
