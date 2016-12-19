//
//  LBB_ScenicMainViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicViewModel.h"

@implementation LBB_ScenicSpotConditionOption

@end

@implementation LBB_ScenicSpotCondition

- (void)setTags:(NSMutableArray *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_ScenicSpotConditionOption mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

- (void)setType:(NSMutableArray *)type
{
    NSMutableArray *array = (NSMutableArray *)[type map:^id(NSDictionary *element) {
        return [LBB_ScenicSpotConditionOption mj_objectWithKeyValues:element];
    }];
    _type = array;
}

- (void)setOrder:(NSMutableArray *)order
{
    NSMutableArray *array = (NSMutableArray *)[order map:^id(NSDictionary *element) {
        return [LBB_ScenicSpotConditionOption mj_objectWithKeyValues:element];
    }];
    _order = array;
}

- (void)setPrice:(NSMutableArray *)price
{
    NSMutableArray *array = (NSMutableArray *)[price map:^id(NSDictionary *element) {
        return [LBB_ScenicSpotConditionOption mj_objectWithKeyValues:element];
    }];
    _price = array;
}

- (void)setHotRecommend:(NSMutableArray *)hotRecommend
{
    NSMutableArray *array = (NSMutableArray *)[hotRecommend map:^id(NSDictionary *element) {
        return [LBB_ScenicSpotConditionOption mj_objectWithKeyValues:element];
    }];
    _hotRecommend = array;
}

@end

@implementation LBB_ScenicViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scenicSpotCondition = [[LBB_ScenicSpotCondition alloc]init];
        self.spotArray = [[NSMutableArray alloc]initFromNet];
        self.advertisementArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}

/**
 3.2.1	景点筛选条件(已测)
 */
- (void)getSpotCondition
{    
    NSString *url = [NSString stringWithFormat:@"%@/spot/condition",BASEURL];
    __weak typeof(self) temp = self;
    self.scenicSpotCondition.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.scenicSpotCondition mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getSpotCondition成功  %@",[dic objectForKey:@"result"]);

        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
            
        }
        
        temp.scenicSpotCondition.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.scenicSpotCondition.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.2.4	景点列表(已测)
 
 @param longitude Y坐标
 @param dimensionality Y坐标
 @param typeKey 传入景点类型key
 @param orderKey 传入排序key
 @param hotRecommendKey 热门推荐key
 @param tagsKey 标签key
 @param priceKey 价格Key
 */
- (void)getSpotArrayLongitude:(NSString *)longitude
               dimensionality:(NSString *)dimensionality
                      typeKey:(int)typeKey
                     orderKey:(int)orderKey
              hotRecommendKey:(int)hotRecommendKey
                      tagsKey:(int)tagsKey
                     priceKey:(int)priceKey
                    clearData:(BOOL)clear;
{
        int curPage = clear == YES ? 0 : round(self.spotArray.count/10.0);
        NSDictionary *paraDic = @{
                                  @"longitude":longitude,
                                  @"dimensionality":dimensionality,
                                  @"typeKey":@(typeKey),
                                  @"orderKey":@(orderKey),
                                  @"hotRecommendKey":@(hotRecommendKey),
                                  @"tagsKey":@(tagsKey),
                                  @"priceKey":@(priceKey),
                                  @"curPage":[NSNumber numberWithInt:curPage],
                                  @"pageNum":[NSNumber numberWithInt:10],
                                  };
    
    NSString *url = [NSString stringWithFormat:@"%@/spot/list",BASEURL];
    __weak typeof(self) temp = self;
    self.spotArray.loadSupport.loadEvent = NetLoadingEvent;
    NSLog(@"getSpotArrayLongitude paraDic : %@",paraDic);

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
                [temp.spotArray removeAllObjects];
            }
            
            [temp.spotArray addObjectsFromArray:returnArray];
            temp.spotArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
         //   NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.spotArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getUgcArrayClearData失败  %@",error.domain);
        
        temp.spotArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.1.2 广告轮播 4.景点页面最顶部
 
 @param clear 是否清空原数据
 */
- (void)getAdvertisementListArrayClearData:(BOOL)clear
{
    //    int curPage = clear == YES ? 0 : round(self.advertisementArray.count/10.0);
    //    NSDictionary *paraDic = @{
    //                              @"curPage":[NSNumber numberWithInt:curPage],
    //                              @"pageNum":[NSNumber numberWithInt:10],
    //                              };
    NSDictionary *paraDic = @{
                              @"position":@(4)
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/advertisementList",BASEURL];
    __weak typeof(self) temp = self;
    self.advertisementArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getAdvertisementListArrayClearData成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_HomeAdvertisement mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.advertisementArray removeAllObjects];
            }
            
            [temp.advertisementArray addObjectsFromArray:returnArray];
            temp.advertisementArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
            
        }
        
        temp.advertisementArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getAdvertisementListArrayClearData失败  %@",error.domain);
        
        temp.advertisementArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}


@end
