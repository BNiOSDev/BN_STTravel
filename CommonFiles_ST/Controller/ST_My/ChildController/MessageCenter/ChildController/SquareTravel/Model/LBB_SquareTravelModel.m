//
//  LBB_SquareTravelModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareTravelModel.h"

@implementation LBB_MessageSquareTravelModel


@end


@implementation LBB_MessageSquareTravelViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

//msgType = 4关注消息 5点赞提醒 6评论提醒 7收藏提醒
- (void)getDataArrayWithType:(int)msgType IsClear:(BOOL)isClear
{
    NSString *url = [NSString stringWithFormat:@"%@/msg/square",BASEURL];

    int curPage = isClear == YES ? 0 : round(self.dataArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              @"msgType":[NSNumber numberWithInt:msgType]
                              };
    
    __weak typeof(self) weakSelf = self;
    self.dataArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_MessageSquareTravelModel mj_objectArrayWithKeyValuesArray:array];
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
        
        weakSelf.dataArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.dataArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
