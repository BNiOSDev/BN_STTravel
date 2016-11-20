//
//  LBB_FoodsViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FoodsViewModel.h"


@implementation LBB_FoodsConditionOption


@end

@implementation LBB_FoodsCondition

- (void)setDistance:(NSMutableArray *)distance
{
    NSMutableArray *array = (NSMutableArray *)[distance map:^id(NSDictionary *element) {
        return [LBB_FoodsConditionOption mj_objectWithKeyValues:element];
    }];
    _distance = array;
}

- (void)setTradingArea:(NSMutableArray *)tradingArea
{
    NSMutableArray *array = (NSMutableArray *)[tradingArea map:^id(NSDictionary *element) {
        return [LBB_FoodsConditionOption mj_objectWithKeyValues:element];
    }];
    _tradingArea = array;
}

- (void)setType:(NSMutableArray *)type
{
    NSMutableArray *array = (NSMutableArray *)[type map:^id(NSDictionary *element) {
        return [LBB_FoodsConditionOption mj_objectWithKeyValues:element];
    }];
    _type = array;
}

- (void)setOrder:(NSMutableArray *)order
{
    NSMutableArray *array = (NSMutableArray *)[order map:^id(NSDictionary *element) {
        return [LBB_FoodsConditionOption mj_objectWithKeyValues:element];
    }];
    _order = array;
}

-(void)setHotRecommend:(NSMutableArray *)hotRecommend
{
    NSMutableArray *array = (NSMutableArray *)[hotRecommend map:^id(NSDictionary *element) {
        return [LBB_FoodsConditionOption mj_objectWithKeyValues:element];
    }];
    _hotRecommend = array;
}

- (void)setTags:(NSMutableArray *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_FoodsConditionOption mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

- (void)setPrice:(NSMutableArray *)price
{
    NSMutableArray *array = (NSMutableArray *)[price map:^id(NSDictionary *element) {
        return [LBB_FoodsConditionOption mj_objectWithKeyValues:element];
    }];
    _price = array;
}

@end

@implementation LBB_FoodsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.foodsCondition = [[LBB_FoodsCondition alloc]init];
        self.foodsArray = [[NSMutableArray alloc]initFromNet];
        self.advertisementArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}

/**
 3.2.2	美食筛选条件(已测)
 */
- (void)getFoodsCondition
{
    NSString *url = [NSString stringWithFormat:@"%@/food/condition",BASEURL];
    __weak typeof(self) temp = self;
    self.foodsCondition.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.foodsCondition mj_setKeyValues:[dic objectForKey:@"result"]];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
            
        }
        
        temp.foodsCondition.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.foodsCondition.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.2.5	美食列表(已测)
 
 @param longitude Y坐标
 @param dimensionality X坐标
 @param tradingAreaKey 商圈Key
 @param distance 传入距离key
 @param typeKey 传入类别key
 @param orderKey 传入排序key
 @param hotRecommendKey 热门推荐key
 @param tagsKey 标签key
 @param priceKey 价格Key
 @param clear 是否清空原数据
 */
- (void)getFoodsArrayLongitude:(NSString *)longitude
                dimensionality:(NSString *)dimensionality
                tradingAreaKey:(int)tradingAreaKey
                      distance:(int)distance
                       typeKey:(int)typeKey
                      orderKey:(int)orderKey
               hotRecommendKey:(int)hotRecommendKey
                       tagsKey:(int)tagsKey
                      priceKey:(int)priceKey
                     clearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.foodsArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"longitude":longitude,
                              @"dimensionality":dimensionality,
                              @"tradingAreaKey":@(tradingAreaKey),
                              @"distance":@(distance),
                              @"typeKey":@(typeKey),
                              @"orderKey":@(orderKey),
                              @"hotRecommendKey":@(hotRecommendKey),
                              @"tagsKey":@(tagsKey),
                              @"priceKey":@(priceKey),
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/food/list",BASEURL];
    __weak typeof(self) temp = self;
    self.foodsArray.loadSupport.loadEvent = NetLoadingEvent;
    
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
                [temp.foodsArray removeAllObjects];
            }
            
            [temp.foodsArray addObjectsFromArray:returnArray];
            temp.foodsArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.foodsArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getUgcArrayClearData失败  %@",error.domain);
        
        temp.foodsArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.1.2 广告轮播 3.美食页面最顶部
 
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
                              @"position":@(3)
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
            NSArray *returnArray = [LBB_SportAdvertisement mj_objectArrayWithKeyValuesArray:array];
            
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
