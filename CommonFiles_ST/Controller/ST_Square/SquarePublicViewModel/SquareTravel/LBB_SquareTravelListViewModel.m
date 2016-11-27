//
//  LBB_SquareTravelListViewModel.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareTravelListViewModel.h"

@implementation BN_SquareTravelList

-(id)init{
    
    if (self = [super init]) {
        self.travelDetailModel = [[BN_SquareTravelNotesModel alloc]init];
    }
    return self;
}

- (void)setTags:(NSArray<LBB_SquareTags *> *)tags
{
    NSMutableArray *array = [@[] mutableCopy];
    [tags enumerateObjectsUsingBlock:^(LBB_SquareTags * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        LBB_SquareTags *tag = [LBB_SquareTags mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _tags = array;
}

/**
 3.4.17 主页-游记详情/游记下载（已测）
 */
-(void)getTravelDetailModel{

    NSDictionary *paraDic = @{
                              @"travelNotesId":@(self.travelNotesId),
                              };
    NSLog(@"paraDic:%@",paraDic);
    
    
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/view",BASEURL];
    __weak typeof(self) temp = self;
    self.travelDetailModel.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.travelDetailModel mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getTravelDetailModel 成功  %@",[dic objectForKey:@"result"]);
            NSLog(@"getTravelDetailModel temp.travelDetailModel:  %@",temp.travelDetailModel);

        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getTravelDetailModel errorStr : %@",errorStr);
            
        }
        
        temp.travelDetailModel.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getTravelDetailModel 失败 : %@",error.domain);

        temp.travelDetailModel.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end

@implementation LBB_SquareTravelListViewModel

-(id)init{
    
    if (self = [super init]) {
        self.squareTravelArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 3.4.16 主页-游记列表（已测）
 */
- (void)getSquareTravelList:(BOOL)clear{

    int curPage = clear == YES ? 0 : round(self.squareTravelArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/list",BASEURL];
    __weak typeof(self) temp = self;
    self.squareTravelArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getSquareTravelList成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_SquareTravelList mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.squareTravelArray removeAllObjects];
            }
            
            [temp.squareTravelArray addObjectsFromArray:returnArray];
            temp.squareTravelArray.networkTotal = [dic objectForKey:@"total"];
            NSLog(@"getSquareTravelList squareTravelArray 成功  %@", temp.squareTravelArray);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getSquareTravelList失败 errorStr %@",errorStr);

        }
        
        temp.squareTravelArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getSquareTravelList失败  %@",error.domain);
        
        temp.squareTravelArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

    
}

@end
