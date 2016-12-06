//
//  LBB_UserShowViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_UserShowViewModel.h"

@implementation LBB_UserOther


/**
 3.4.3	广场-广场主页-好友关注（已测）
 
 @param block 回调block
 */
- (void)attention:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"beUserId":@(self.userId),
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/friends/attention",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            id result = [dic objectForKey:@"result"];
            int attentionState = [[result objectForKey:@"attentionState"] intValue];
            if (attentionState != 0) {
                temp.followState = [[result objectForKey:@"followState"] intValue];
            }
            else{
                temp.followState = 0;
            }
            block(nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        block(error);
    }];
}


@end

@implementation LBB_UserAction

- (void)setTags:(NSMutableArray<LBB_SquareTags *> *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_SquareTags mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

@end

@implementation LBB_UserShowViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userActionArray = [[NSMutableArray alloc]initFromNet];
        self.userAttentionArray = [[NSMutableArray alloc]initFromNet];
        self.userFansArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}

- (void)setTags:(NSArray<BN_HomeTag *> *)tags
{
    NSMutableArray *array = [@[] mutableCopy];
    [tags enumerateObjectsUsingBlock:^(BN_HomeTag * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        BN_HomeTag *tag = [BN_HomeTag mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _tags = array;
}

/**
 3.4.7	广场-广场主页-个人主页-动态（已测）
 
 @param clear 清空原数据
 */
- (void)getUserActionArrayClearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.userActionArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"userId":@(self.userId),
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/user/view/action",BASEURL];
    __weak typeof(self) temp = self;
    self.userActionArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_UserAction mj_objectArrayWithKeyValuesArray:array];
            NSLog(@"getUserActionArrayClearData 成功:%@",array);
            
            if (clear == YES)
            {
                [temp.userActionArray removeAllObjects];
            }
            
            [temp.userActionArray addObjectsFromArray:returnArray];
            temp.userActionArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.userActionArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.userActionArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

- (void)getUserAttentionArrayClearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.userAttentionArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"userId":@(self.userId),
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/user/view/attention",BASEURL];
    __weak typeof(self) temp = self;
    self.userAttentionArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_UserOther mj_objectArrayWithKeyValuesArray:array];
            NSLog(@"getUserAttentionArrayClearData 成功:%@",array);
            if (clear == YES)
            {
                [temp.userAttentionArray removeAllObjects];
            }
            
            [temp.userAttentionArray addObjectsFromArray:returnArray];
            temp.userAttentionArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getUserAttentionArrayClearData errorStr:%@",errorStr);

        }
        
        temp.userAttentionArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.userAttentionArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getUserAttentionArrayClearData 失败:%@",error.domain);

    }];
}

/**
 3.4.9	广场-广场主页-个人主页-粉丝（已测）
 
 @param clear 清空原数据
 */
- (void)getUserFansArrayClearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.userFansArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"userId":@(self.userId),
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/user/view/fans",BASEURL];
    __weak typeof(self) temp = self;
    self.userFansArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_UserOther mj_objectArrayWithKeyValuesArray:array];
            NSLog(@"getUserFansArrayClearData 成功:%@",array);

            if (clear == YES)
            {
                [temp.userFansArray removeAllObjects];
            }
            
            [temp.userFansArray addObjectsFromArray:returnArray];
            temp.userFansArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getUserFansArrayClearData errorStr:%@",errorStr);

        }
        
        temp.userFansArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.userFansArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getUserFansArrayClearData 失败:%@",error.domain);

    }];

}


/**
 3.4.3	广场-广场主页-好友关注（已测）
 
 @param block 回调block
 */
- (void)attention:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"beUserId":@(self.userId),
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/friends/attention",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            id result = [dic objectForKey:@"result"];
            temp.isFollow = [[result objectForKey:@"attentionState"] intValue];
            block(nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        block(error);
    }];
}


@end
