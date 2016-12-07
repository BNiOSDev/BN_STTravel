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
        
        self.spotAdvertisementArray = [[NSMutableArray alloc]initFromNet];
        self.foodAdvertisementArray = [[NSMutableArray alloc]initFromNet];
        self.hostelAdvertisementArray = [[NSMutableArray alloc]initFromNet];
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
                            //  @"distance":@(distance),
                              @"allSpotsType":@(allSpotsType),
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    NSLog(@"getSpotArrayLongitude paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/nearby/spots",BASEURL];
    __weak typeof(self) temp = self;
    __weak NSMutableArray *sportArray_block = sportArray;
    sportArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getSpotArrayLongitude成功  %@",[dic objectForKey:@"rows"]);
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
            NSLog(@"getSpotArrayLongitude errorStr  %@",errorStr);
        }
        
        sportArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getSpotArrayLongitude失败  %@",error.domain);
        
        sportArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.3.4	攻略列表(已测)
 
 @param lineTime 行程时间
 @param allSpots 场景列表
 @param tags 个性标签列表
 */
- (void)getNearShopArrayLineTime:(long)lineTime
                        allSpots:(NSArray<LBB_SpotsTag*>*)allSpots
                            tags:(NSArray<LBB_SpotAddress*>*)tags
{
    NSArray *allSpotsArray = [allSpots map:^id(LBB_SpotAddress *element) {
        return @(element.allSpotsId);
    }];
    
    NSArray *tagsArray = [tags map:^id(LBB_SpotsTag *element) {
        return @(element.tagId);
    }];
    
    NSString *allSpotsStr = [allSpotsArray componentsJoinedByString:@","];
    NSString *tagsStr = [tagsArray componentsJoinedByString:@","];
    
    NSDictionary *paraDic = @{
                              @"lineTime":@(lineTime),
                              @"allSpots":allSpotsStr,
                              @"tags":tagsStr,
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/line/list",BASEURL];
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
            NSLog(@"getNearSignInArrayClearData成功:%@",array);
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
            NSLog(@"getNearSignInArrayClearData失败:%@",errorStr);

        }
        
        temp.nearSignInArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.nearSignInArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getNearSignInArrayClearData error:%@",error.domain);

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
            NSLog(@"getSignInfo 成功 temp.signInNum:%ld",temp.signInNum);
            NSLog(@"getSignInfo 成功 temp.rank:%d",temp.rank);

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
            NSLog(@"getSignInUserArrayClearData成功:%@",array);

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
            NSLog(@"getSignInUserArrayClearData errorStr:%@",errorStr);

        }
        
        temp.signInUserArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.signInUserArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getSignInUserArrayClearData error:%@",error.domain);

    }];
}


/**
 3.9.1 附近的商家 (已测)
 
 @param clear 清空原数据
 */
- (void)getNearSignInMapArrayClearData:(NSString *)longitude
                        dimensionality:(NSString *)dimensionality
                                 clear:(BOOL)clear
{
    NSDictionary *paraDic = @{
                              @"longitude":longitude,
                              @"dimensionality":dimensionality,
                              };
    NSLog(@"getNearSignInMapArrayClearData para:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/nearby/map",BASEURL];
    __weak typeof(self) temp = self;
    self.nearShopArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getNearSignInMapArrayClearData 成功:%@",array);
            
            NSArray *returnArray = [LBB_NearShopModel mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.nearShopArray removeAllObjects];
            }
            
            [temp.nearShopArray addObjectsFromArray:returnArray];
            temp.nearShopArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getNearSignInMapArrayClearData errorStr:%@",errorStr);
        }
        
        temp.nearShopArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.nearShopArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getNearSignInMapArrayClearData error:%@",error.domain);
        
    }];
}

#pragma AD
/**
 3.1.1 广告轮播 8 附近景点广告
 
 @param clear 是否清空原数据
 */

- (void)getSpotAdvertisementListArrayClearData:(BOOL)clear{
    NSDictionary *paraDic = @{
                              @"position":@(8)
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/advertisementList",BASEURL];
    __weak typeof(self) temp = self;
    self.spotAdvertisementArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_HomeAdvertisement mj_objectArrayWithKeyValuesArray:array];
            NSLog(@"getSpotAdvertisementListArrayClearData:%@",array);

            if (clear == YES)
            {
                [temp.spotAdvertisementArray removeAllObjects];
            }
            
            [temp.spotAdvertisementArray addObjectsFromArray:returnArray];
            temp.spotAdvertisementArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.spotAdvertisementArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.spotAdvertisementArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}
/**
 3.1.1 广告轮播 9附近美食广告
 
 @param clear 是否清空原数据
 */

- (void)getFoodAdvertisementListArrayClearData:(BOOL)clear{
    NSDictionary *paraDic = @{
                              @"position":@(9)
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/advertisementList",BASEURL];
    __weak typeof(self) temp = self;
    self.foodAdvertisementArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getFoodAdvertisementListArrayClearData:%@",array);
            NSArray *returnArray = [BN_HomeAdvertisement mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.foodAdvertisementArray removeAllObjects];
            }
            
            [temp.foodAdvertisementArray addObjectsFromArray:returnArray];
            temp.foodAdvertisementArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.foodAdvertisementArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.foodAdvertisementArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}
/**
 3.1.1 广告轮播 10 附近民宿广告
 
 @param clear 是否清空原数据
 */

- (void)getHostelAdvertisementListArrayClearData:(BOOL)clear{
    NSDictionary *paraDic = @{
                              @"position":@(10)
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/advertisementList",BASEURL];
    __weak typeof(self) temp = self;
    self.hostelAdvertisementArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_HomeAdvertisement mj_objectArrayWithKeyValuesArray:array];
            NSLog(@"getHostelAdvertisementListArrayClearData:%@",array);

            if (clear == YES)
            {
                [temp.hostelAdvertisementArray removeAllObjects];
            }
            
            [temp.hostelAdvertisementArray addObjectsFromArray:returnArray];
            temp.hostelAdvertisementArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.hostelAdvertisementArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.hostelAdvertisementArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}

@end
