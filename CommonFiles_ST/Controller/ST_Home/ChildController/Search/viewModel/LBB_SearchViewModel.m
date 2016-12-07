//
//  LBB_SearchViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SearchViewModel.h"

@implementation LBB_SearchHotWordModel



@end

@implementation LBB_SearchViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hotWordArray = [[NSMutableArray alloc]initFromNet];
        self.scenicSpotsArray = [[NSMutableArray alloc]initFromNet];
        self.foodSpotsArray = [[NSMutableArray alloc]initFromNet];
        self.hostelSpotsArray = [[NSMutableArray alloc]initFromNet];

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
            NSArray *returnArray = [LBB_SearchHotWordModel mj_objectArrayWithKeyValuesArray:array];
            NSLog(@"getHotWordArray success:%@",returnArray);
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

/**
 3.6.4	搜索-景点/美食/民宿（已测）
 
 @param longitude Y坐标
 @param dimensionality X坐标
 @param allSpotsType 1.美食 2.民宿 3景点
 @param name 搜索名称
 @param clear 清空原数据
 */
- (void)getAllSpotsArrayLongitude:(NSString *)longitude
                 dimensionality:(NSString *)dimensionality
                   allSpotsType:(int)allSpotsType
                           name:(NSString*)name
                      clearData:(BOOL)clear
{
    NSMutableArray *sportArray;
    switch (allSpotsType) {
        case 1:
            sportArray = self.foodSpotsArray;
            break;
        case 2:
            sportArray = self.hostelSpotsArray;
            break;
        case 3:
            sportArray = self.scenicSpotsArray;
            break;
        default:
            break;
    }
    int curPage = clear == YES ? 0 : round(sportArray.count/10.0);
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
    __weak NSMutableArray *sportArray_block = sportArray;
    sportArray.loadSupport.loadEvent = NetLoadingEvent;
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
        NSLog(@"getHostelArrayLongitude失败  %@",error.domain);
        
        sportArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}
@end
