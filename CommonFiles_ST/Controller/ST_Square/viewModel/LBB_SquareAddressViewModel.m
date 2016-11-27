//
//  LBB_SquareAddressViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareAddressViewModel.h"

@implementation LBB_SquareAddressViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.squareSpotsArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
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
