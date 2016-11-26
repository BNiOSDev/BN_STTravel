//
//  LBB_TravelModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelModel.h"

@implementation LBB_TravelModel

@end

@implementation LBB_TravelViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.travelArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.5.6 我的-广场 游记（已测）
 *3.5.12 我的-收藏 广场 游记（已测）
 */
- (void)getMyTravelList:(BOOL)isClear VidewType:(MySquareViewType)videoType
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/travelNotes/list",BASEURL];
    if (videoType == MySquareViewFravorite) {
        [NSString stringWithFormat:@"%@/mime/myCollect/travelNotes/list",BASEURL];
    }

    int curPage = isClear == YES ? 0 : round(self.travelArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    __weak typeof(self) weakSelf = self;
    self.travelArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_TravelModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
                [weakSelf.travelArray removeAllObjects];
            }
            
            [weakSelf.travelArray addObjectsFromArray:returnArray];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        
        weakSelf.travelArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.travelArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
