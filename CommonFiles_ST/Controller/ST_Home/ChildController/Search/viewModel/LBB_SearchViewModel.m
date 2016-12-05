//
//  LBB_SearchViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SearchViewModel.h"

@implementation LBB_SearchViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hotWordArray = [[NSMutableArray alloc]initFromNet];
        self.allSpotsArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}


- (void)getHotWordArray
{

    NSDictionary *paraDic = @{};
    
    NSString *url = [NSString stringWithFormat:@"%@/search/hotWords",BASEURL];
    __weak typeof(self) temp = self;
    self.hotWordArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = array;
            
            [temp.hotWordArray removeAllObjects];
            [temp.hotWordArray addObjectsFromArray:returnArray];
            temp.hotWordArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            
        }
        
        temp.hotWordArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.hotWordArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

- (void)getAllSpotsArrayLongitude:(NSString *)longitude
                 dimensionality:(NSString *)dimensionality
                   allSpotsType:(int)allSpotsType
                           name:(NSString*)name
                      clearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.allSpotsArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"longitude":longitude,
                              @"dimensionality":dimensionality,
                              @"allSpotsType":@(allSpotsType),
                              @"name":name,
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/search/allSpots",BASEURL];
    __weak typeof(self) temp = self;
    self.allSpotsArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getHostelArrayLongitude成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SpotModel mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.allSpotsArray removeAllObjects];
            }
            
            [temp.allSpotsArray addObjectsFromArray:returnArray];
            temp.allSpotsArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.allSpotsArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getHostelArrayLongitude失败  %@",error.domain);
        
        temp.allSpotsArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
    
}
@end
