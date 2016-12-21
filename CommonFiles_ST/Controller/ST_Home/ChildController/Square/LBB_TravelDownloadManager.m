//
//  LBB_TravelDownloadManager.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelDownloadManager.h"

@implementation LBB_TravelDownloadManager


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
-(void)saveTravelDetail:(BN_SquareTravelNotesModel*)model curVC:(Base_BaseViewController*)vc{
    
    NSMutableArray* detailModelArray = [self getTravelDetailArray];
    
    BOOL isExit = NO;
    for (BN_SquareTravelNotesModel* obj in detailModelArray) {
        
        if (model.travelNotesId == obj.travelNotesId) {
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
        
        NSMutableArray* array = [self getTravelDetailDicArray];
        [array addObject:[self filterTravelDeatilDic:dic]];
        
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"LBB_TravelDetailArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"saveDiscoveryDetail:%@",dic);
        [vc showHudPrompt:@"攻略下载成功"];
        NSLog(@"攻略下载成功");
    }
}

/**
 删除攻略

 @param model     要删除的攻略
 @param succBlock 数据回调状态
 */
-(void)deleteTravelDetail:(BN_SquareTravelNotesModel*)model
                     succ:(void(^)(NSError* error))succBlock{
    
    NSMutableArray* detailModelArray = [self getTravelDetailArray];
    
    BN_SquareTravelNotesModel* deleteObj;
    BOOL isExit = NO;
    for (BN_SquareTravelNotesModel* obj in detailModelArray) {
        
        if (model.travelNotesId == obj.travelNotesId) {
            deleteObj = obj;
            isExit = YES;
            break;
        }
    }
    
    if (isExit) {
        [detailModelArray removeObject:deleteObj];//移除对象
        
        NSMutableArray* saveDic = [[NSMutableArray alloc] init];
        for (BN_SquareTravelNotesModel* obj in detailModelArray) {
            NSMutableDictionary* dic = [obj mj_keyValues];
            
            [saveDic addObject:[self filterTravelDeatilDic:dic]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:saveDic forKey:@"LBB_TravelDetailArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"deleteDiscoveryDetail:%@",saveDic);
        succBlock(nil);
    }
    else{
        NSLog(@"deleteDiscoveryDetail 不存在");
        NSString *errorStr = @"游记详情不存在";
        succBlock([NSError errorWithDomain:errorStr
                                  code:1
                              userInfo:nil]);
    }
    
}


/**
 过滤游记详情无效的字段

 @param dic 传入的模型字段

 @return 过滤后的模型字段
 */
-(NSMutableDictionary*)filterTravelDeatilDic:(NSMutableDictionary*)dic{

    dic[@"debugDescription"] = nil;
    dic[@"loadSupport"] = nil;
    dic[@"superclass"] = nil;
    dic[@"description"] = nil;
    dic[@"hash"] = nil;
    dic[@"travelBillModel"] = nil;
    NSMutableArray* tagsDicArray = [dic objectForKey:@"tags"];
    for (NSMutableDictionary* dic in tagsDicArray) {
        dic[@"debugDescription"] = nil;
        dic[@"loadSupport"] = nil;
        dic[@"superclass"] = nil;
        dic[@"description"] = nil;
        dic[@"hash"] = nil;
        dic[@"tagsViewModel"] = nil;
        dic[@"showImageHotArray"] = nil;
        dic[@"showImageTimeArray"] = nil;
        dic[@"showViewUsersArray"] = nil;
    }
    
    
    NSMutableArray* travelNotesDetailsDicArray = [dic objectForKey:@"travelNotesDetails"];
    for (NSMutableDictionary* dic in travelNotesDetailsDicArray) {
        dic[@"debugDescription"] = nil;
        dic[@"loadSupport"] = nil;
        dic[@"superclass"] = nil;
        dic[@"description"] = nil;
        dic[@"hash"] = nil;
        dic[@"travelNotesDetailsComments"] = nil;
        
        NSMutableArray* picsArray = [dic objectForKey:@"pics"];
        for (NSMutableDictionary* dicPic in picsArray) {
            dicPic[@"debugDescription"] = nil;
            dicPic[@"loadSupport"] = nil;
            dicPic[@"superclass"] = nil;
            dicPic[@"description"] = nil;
            dicPic[@"hash"] = nil;
        }
    }
    
    return dic;
}

/**
 获取保存在本地的攻略数组字典
 
 @return 保存在本地的攻略数组
 */
-(NSMutableArray*)getTravelDetailDicArray{
    
    NSArray* array = [[NSUserDefaults standardUserDefaults] objectForKey:@"LBB_TravelDetailArray"];
    
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
-(NSMutableArray<BN_SquareTravelNotesModel*>*)getTravelDetailArray{
    
    NSArray* array = [[NSUserDefaults standardUserDefaults] objectForKey:@"LBB_TravelDetailArray"];
    
    if (array.count <= 0) {
        return [[NSMutableArray alloc] init];
    }
    NSLog(@"getDiscoveryDetailArray:%@",array);
    
    NSMutableArray *returnArray = [BN_SquareTravelNotesModel mj_objectArrayWithKeyValuesArray:array];
    return returnArray;
}



@end
