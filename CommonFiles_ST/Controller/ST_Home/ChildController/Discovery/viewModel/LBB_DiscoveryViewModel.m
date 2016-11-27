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

@end
