//
//  LBB_NearViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NearViewModel.h"

@implementation LBB_SignInUser

@end

@implementation LBB_NearSignIn

@end

@implementation LBB_NearShopModel

@end

@implementation LBB_NearViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spotArray = [[NSMutableArray alloc]initFromNet];
        self.hostelArray = [[NSMutableArray alloc]initFromNet];
        self.foodsArray = [[NSMutableArray alloc]initFromNet];
        self.nearShopArray = [[NSMutableArray alloc]initFromNet];
        self.nearSignInArray = [[NSMutableArray alloc]initFromNet];
        self.signInUserArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}

/**
 3.9.2	附近 –美食\名宿\景点列表(已测)
 
 @param longitude Y坐标
 @param dimensionality X坐标
 @param distance 距离多少范围以内(单位米)
 @param allSpotsType 1.美食 2.民宿 3景点
 @param clear 是否清空原数据
 */
- (void)getSpotArrayLongitude:(NSString *)longitude
               dimensionality:(NSString *)dimensionality
                     distance:(int)distance
                 allSpotsType:(int)allSpotsType
                    clearData:(BOOL)clear
{
    NSMutableArray *sportArray;
    switch (allSpotsType) {
        case 1:
            sportArray = self.foodsArray;
            break;
        case 2:
            sportArray = self.hostelArray;
            break;
        case 3:
            sportArray = self.spotArray;
            break;
        default:
            break;
    }
    
    int curPage = clear == YES ? 0 : round(sportArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"longitude":longitude,
                              @"dimensionality":dimensionality,
                              @"distance":@(distance),
                              @"allSpotsType":@(allSpotsType),
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/nearby/spots",BASEURL];
    __weak typeof(self) temp = self;
    __weak NSMutableArray *sportArray_block = sportArray;
    sportArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getUgcArrayClearData成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SpotModel mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [sportArray_block removeAllObjects];
            }
            
            [sportArray_block addObjectsFromArray:returnArray];
            sportArray_block.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        sportArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getUgcArrayClearData失败  %@",error.domain);
        
        sportArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.9.1	附近的商家 (已测)
 
 @param longitude Y坐标
 @param dimensionality X坐标
 */
- (void)getNearShopArrayLongitude:(NSString *)longitude
                   dimensionality:(NSString *)dimensionality
{
    NSDictionary *paraDic = @{
                              @"longitude":longitude,
                              @"dimensionality":dimensionality,
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/nearby/map",BASEURL];
    __weak typeof(self) temp = self;
    self.nearShopArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_NearShopModel mj_objectArrayWithKeyValuesArray:array];
            [temp.nearShopArray removeAllObjects];
            
            [temp.nearShopArray addObjectsFromArray:returnArray];
            temp.nearShopArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
            
        }
        
        temp.nearShopArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.nearShopArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.9.3	附近–签到列表(已测)
 
 @param clear 清空原数据
 */
- (void)getNearSignInArrayClearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.nearSignInArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/nearby/signIn/list",BASEURL];
    __weak typeof(self) temp = self;
    self.nearSignInArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_NearSignIn mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.nearSignInArray removeAllObjects];
            }
            
            [temp.nearSignInArray addObjectsFromArray:returnArray];
            temp.nearSignInArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.nearSignInArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.nearSignInArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.9.4	附近–签到信息(已测)
 */
- (void)getSignInfo
{
    NSString *url = [NSString stringWithFormat:@"%@/nearby/signIn/info",BASEURL];
    __weak typeof(self) temp = self;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSDictionary *result = [dic objectForKey:@"result"];
            temp.signInNum = [result[@"signInNum"] longLongValue];
            temp.rank = [result[@"rank"] intValue];
            
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    }];
}

/**
 3.9.5	附近–签到排名(已测)
 
 @param clear 清空原数据
 */
- (void)getSignInUserArrayClearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.signInUserArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/nearby/signIn/rank",BASEURL];
    __weak typeof(self) temp = self;
    self.signInUserArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SignInUser mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.signInUserArray removeAllObjects];
            }
            
            [temp.signInUserArray addObjectsFromArray:returnArray];
            temp.signInUserArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.signInUserArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.signInUserArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
