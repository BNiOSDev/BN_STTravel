//
//  LBB_PromotionModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/12/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PromotionModel.h"

@implementation LBB_PromotionModel

@end

@implementation LBB_PromotionViewModel

 - (id)init
{
    self = [super init];
    if(self) {
        self.dataArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.10.4 优惠促销列表(已测)
 */
- (void)getPromotionDataArray:(BOOL)isClear
{
    NSString *url = [NSString stringWithFormat:@"%@/homePage/promotion/list",BASEURL];
    int curPage = isClear == YES ? 0 : round(self.dataArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    __weak typeof(self) weakSelf = self;
    self.dataArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_PromotionModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
                [weakSelf.dataArray removeAllObjects];
            }
            
            [weakSelf.dataArray addObjectsFromArray:returnArray];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        weakSelf.dataArray.networkTotal = [dic objectForKey:@"total"];
        weakSelf.dataArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.dataArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
