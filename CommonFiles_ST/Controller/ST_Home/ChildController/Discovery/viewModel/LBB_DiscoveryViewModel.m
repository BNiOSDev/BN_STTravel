//
//  LBB_DiscoveryViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryViewModel.h"

@implementation LBB_DiscoveryDetailModel

@end

@implementation LBB_DiscoveryModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.discoveryDetail = [[LBB_DiscoveryDetailModel alloc]init];
    }
    return self;
}

/**
 3.3.5	攻略详情(已测)
 */
- (void)getDiscoveryDetailData
{
    NSString *url = [NSString stringWithFormat:@"%@/line/detail",BASEURL];
    __weak typeof(self) temp = self;
    self.discoveryDetail.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.discoveryDetail mj_setKeyValues:[dic objectForKey:@"result"]];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        
        temp.discoveryDetail.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.discoveryDetail.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end

@implementation LBB_DiscoveryViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.discoveryArray = [[NSMutableArray alloc]initFromNet];
        self.squareSpotsArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}

- (void)getDiscoveryArrayClearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.discoveryArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/line/list",BASEURL];
    __weak typeof(self) temp = self;
    self.discoveryArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_DiscoveryModel mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.discoveryArray removeAllObjects];
            }
            
            [temp.discoveryArray addObjectsFromArray:returnArray];
            temp.discoveryArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.discoveryArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.discoveryArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}

/**
 3.4.26	主页-游记添加地址（已测）
 
 @param allSpotsType 1.美食 2.民宿 3景点(可为空)
 @param name 可为空 模糊查询
 @param clear 是否清空原数据
 */
- (void)getsTravelNotesDetailAllSpotsType:(int)allSpotsType name:(NSString *)name ClearData:(BOOL)clear
{
    NSMutableArray *showArray = self.squareSpotsArray;
    
    int curPage = clear == YES ? 0 : round(showArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"allSpotsType":@(allSpotsType),
                              @"name":name,
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotesDetail/allSpots",BASEURL];
    __weak typeof(self) temp = self;
    __weak NSMutableArray *showArray_block = showArray;
    showArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SpotAddress mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [showArray_block removeAllObjects];
            }
            
            [showArray_block addObjectsFromArray:returnArray];
            showArray_block.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        showArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        showArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
