//
//  LBB_BalanceDetailModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/11.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_BalanceDetailModel.h"

@implementation LBB_BalanceDetailModel

@end

@implementation LBB_BalanceViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.banlanceArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.5.11 我的-积分明细（已测）
 */
- (void)getMyCreditDetail:(BOOL)isClear
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/myCredits/details",BASEURL];

    int curPage = isClear == YES ? 0 : round(self.banlanceArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];

        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_BalanceDetailModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
                [weakSelf.banlanceArray removeAllObjects];
            }
             [weakSelf.banlanceArray addObjectsFromArray:returnArray];
        }
       
        weakSelf.banlanceArray.networkTotal = [dic objectForKey:@"total"];
        weakSelf.banlanceArray.loadSupport.loadEvent = codeNumber.intValue;
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadFailEvent = NetLoadFailedEvent;
    }];
    
}

@end
