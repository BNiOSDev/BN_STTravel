//
//  LBB_GuiderListViewModel.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/10.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderViewModel.h"

@implementation LBB_GuiderTags


@end

@implementation LBB_GuiderListViewModel

-(void)setTourTags:(NSMutableArray<LBB_GuiderTags *> *)tourTags{
    NSMutableArray *array = (NSMutableArray *)[tourTags map:^id(NSDictionary *element) {
        return [LBB_GuiderTags mj_objectWithKeyValues:element];
    }];
    _tourTags = array;
}


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
            // temp.AttentionStatus = YES;
            id result = [dic objectForKey:@"result"];
            NSLog(@"LBB_GuiderListViewModel attention:%@",result);
            temp.followState = [[result objectForKey:@"attentionState"] intValue];
            if (temp.followState == 0) {
                temp.followNum = temp.followNum - 1;
            }
            else{
                temp.followNum = temp.followNum + 1;
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


@implementation LBB_GuiderViewModel

-(id)init{
    
    if (self = [super init]) {
        self.guiderListArray = [[NSMutableArray alloc] initFromNet];
        self.guiderCondition = [[LBB_GuiderCondition alloc]init];
    }
    return self;
}

/**
 3.7.5 导游 – 查询条件（已测）
 */
- (void)getGuiderConditions{

    NSString *url = [NSString stringWithFormat:@"%@/tour/condition",BASEURL];
    __weak typeof(self) temp = self;
    self.guiderCondition.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.guiderCondition mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getGuiderConditions成功  %@",[dic objectForKey:@"result"]);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        temp.guiderCondition.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.guiderCondition.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}


/**
 3.7.6 导游 -列表（已测）
 @param name       模糊查询名字
 @param tagKey     标签key
 @param jobTimeKey 工作时长key
 @param genderKey  性别key
 @param clear      清空原数据
 */
-(void)getGuiderListArray:(NSString*)name
                   tagKey:(int)tagKey
               jobTimeKey:(int)jobTimeKey
                genderKey:(int)genderKey
                    clear:(BOOL)clear{

    int curPage = clear == YES ? 0 : round(self.guiderListArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              @"name":name,
                              @"tagKey":@(tagKey),
                              @"jobTimeKey":@(jobTimeKey),
                              @"genderKey":@(genderKey),
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/tour/list",BASEURL];
    __weak typeof(self) temp = self;
    self.guiderListArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getGuiderListArray 成功:%@",array);
            NSArray *returnArray = [LBB_GuiderListViewModel mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.guiderListArray removeAllObjects];
            }
            
            [temp.guiderListArray addObjectsFromArray:returnArray];
            temp.guiderListArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getGuiderListArray errorStr:%@",errorStr);
            
        }
        
        temp.guiderListArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.guiderListArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getGuiderListArray 失败:%@",error.domain);
        
    }];

}
@end
