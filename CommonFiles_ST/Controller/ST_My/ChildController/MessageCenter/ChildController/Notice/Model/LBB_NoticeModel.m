//
//  LBB_NoticeModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NoticeModel.h"

@implementation LBB_NoticeModel


- (void)getNoticeModelDataBlock:(void (^)(LBB_NoticeModel *noticeModel ,NSError* error))block
{
    NSString *url = [NSString stringWithFormat:@"%@/homePage/notices/view",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:@{@"noticesId":@(self.noticesId)} success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp mj_setKeyValues:[dic objectForKey:@"result"]];
            block(temp,nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            block(temp,[NSError errorWithDomain:errorStr
                                              code:codeNumber.intValue
                                          userInfo:nil]);
        }

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        block(temp,error);
    }];
}

@end


@implementation LBB_NoticeViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.10.7 公告列表(已测)
 */
- (void)getNoticeDataArray:(BOOL)isClear
{
    NSString *url = [NSString stringWithFormat:@"%@/homePage/notices/list",BASEURL];
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
            NSArray *returnArray = [LBB_NoticeModel mj_objectArrayWithKeyValuesArray:array];
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
