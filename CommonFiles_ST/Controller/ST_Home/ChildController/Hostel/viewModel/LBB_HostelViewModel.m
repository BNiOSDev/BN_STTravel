//
//  LBB_HostelViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HostelViewModel.h"

@implementation LBB_HostelConditionOption


@end

@implementation LBB_HostelCondition

- (void)setType:(NSMutableArray *)type
{
    NSMutableArray *array = (NSMutableArray *)[type map:^id(NSDictionary *element) {
        return [LBB_HostelConditionOption mj_objectWithKeyValues:element];
    }];
    _type = array;
}

- (void)setOrder:(NSMutableArray *)order
{
    NSMutableArray *array = (NSMutableArray *)[order map:^id(NSDictionary *element) {
        return [LBB_HostelConditionOption mj_objectWithKeyValues:element];
    }];
    _order = array;
}

- (void)setHotRecommend:(NSMutableArray *)hotRecommend
{
    NSMutableArray *array = (NSMutableArray *)[hotRecommend map:^id(NSDictionary *element) {
        return [LBB_HostelConditionOption mj_objectWithKeyValues:element];
    }];
    _hotRecommend = array;
}

- (void)setTags:(NSMutableArray *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_HostelConditionOption mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

- (void)setPrice:(NSMutableArray *)price
{
    NSMutableArray *array = (NSMutableArray *)[price map:^id(NSDictionary *element) {
        return [LBB_HostelConditionOption mj_objectWithKeyValues:element];
    }];
    _price = array;
}

@end

@implementation LBB_HostelViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hostelCondition = [[LBB_HostelCondition alloc]init];
        self.hostelArray = [[NSMutableArray alloc]initFromNet];
        self.advertisementArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}
/**
 3.2.3	民宿筛选条件(已测)
 */
- (void)getHostelCondition{
    
    NSString *url = [NSString stringWithFormat:@"%@/hostel/condition",BASEURL];
    __weak typeof(self) temp = self;
    self.hostelCondition.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.hostelCondition mj_setKeyValues:[dic objectForKey:@"result"]];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
            
        }
        
        temp.hostelCondition.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.hostelCondition.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 2.3.6	民宿列表(已测)
 
 @param longitude Y坐标
 @param dimensionality X坐标
 @param typeKey 传入类别key
 @param orderKey 传入排序key
 @param hotRecommendKey 热门推荐key
 @param tagsKey 标签key
 @param priceKey 价格Key
 @param clear 是否清空原数据
 */
- (void)getHostelArrayLongitude:(NSString *)longitude
                 dimensionality:(NSString *)dimensionality
                        typeKey:(int)typeKey
                       orderKey:(int)orderKey
                hotRecommendKey:(int)hotRecommendKey
                        tagsKey:(int)tagsKey
                       priceKey:(int)priceKey
                      clearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.hostelArray.count/10.0);
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
    
    NSString *url = [NSString stringWithFormat:@"%@/hostel/list",BASEURL];
    __weak typeof(self) temp = self;
    self.hostelArray.loadSupport.loadEvent = NetLoadingEvent;
    
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
                [temp.hostelArray removeAllObjects];
            }
            
            [temp.hostelArray addObjectsFromArray:returnArray];
            temp.hostelArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.hostelArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getUgcArrayClearData失败  %@",error.domain);
        
        temp.hostelArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
    
}

/**
 3.1.2 广告轮播 2.美食页面最顶部
 
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
                              @"position":@(2)
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
