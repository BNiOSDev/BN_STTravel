//
//  LBB_TravelGuideModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelGuideModel.h"

@implementation LBB_TravelGuideModel

@end

@implementation LBB_TravelGuideViewModelModel

- (id)init
{
    self = [super init];
    if (self) {
        self.travelGuideArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.5.17 我的-收藏 广场 攻略（已测）
 */
- (void)getMyTravelGuideList:(BOOL)isClear
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/myCollect/line/list",BASEURL];
    
    int curPage = isClear == YES ? 0 : round(self.travelGuideArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    __weak typeof(self) weakSelf = self;
    self.travelGuideArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_TravelGuideModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
                [weakSelf.travelGuideArray removeAllObjects];
            }
            
            [weakSelf.travelGuideArray addObjectsFromArray:returnArray];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        
        weakSelf.travelGuideArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.travelGuideArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
