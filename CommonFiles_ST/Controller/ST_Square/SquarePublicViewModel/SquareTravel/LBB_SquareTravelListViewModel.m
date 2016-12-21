//
//  LBB_SquareTravelListViewModel.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareTravelListViewModel.h"

@implementation BN_SquareTravelComments

- (void)setLikeList:(NSMutableArray<LBB_SquareLikeList *> *)likeList
{
    NSMutableArray *array = (NSMutableArray *)[likeList map:^id(NSDictionary *element) {
        return [LBB_SquareLikeList mj_objectWithKeyValues:element];
    }];
    _likeList = array;
}

- (void)setComments:(NSMutableArray<LBB_SquareComments *> *)comments
{
    NSMutableArray *array = (NSMutableArray *)[comments map:^id(NSDictionary *element) {
        return [LBB_SquareComments mj_objectWithKeyValues:element];
    }];
    _comments = array;
}

@end

@implementation BN_SquareTravelList

-(id)init{
    
    if (self = [super init]) {
        self.travelDetail = [[BN_SquareTravelNotesModel alloc]init];
        self.travelComments = [[BN_SquareTravelComments alloc]init];
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
    self.travelDetail.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.travelDetail mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getTravelDetailModel 成功  %@",[dic objectForKey:@"result"]);
            NSLog(@"getTravelDetailModel temp.travelDetailModel:  %@",temp.travelDetail);

        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getTravelDetailModel errorStr : %@",errorStr);
            
        }
        
        temp.travelDetail.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getTravelDetailModel 失败 : %@",error.domain);

        temp.travelDetail.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.4.28	主页-游记评论（已测）
 */
-(void)getTravelCommentsModel{
    
    NSDictionary *paraDic = @{
                              @"travelNotesId":@(self.travelNotesId),
                              };
    NSLog(@"paraDic:%@",paraDic);
    
    
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/comments",BASEURL];
    __weak typeof(self) temp = self;
    self.travelComments.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.travelComments mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getTravelDetailModel 成功  %@",[dic objectForKey:@"result"]);
            NSLog(@"getTravelDetailModel temp.travelDetailModel:  %@",temp.travelComments);
            
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getTravelDetailModel errorStr : %@",errorStr);
            
        }
        
        temp.travelComments.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getTravelDetailModel 失败 : %@",error.domain);
        
        temp.travelComments.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSDictionary*dic, NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.travelNotesId),
                              @"allSpotsType":@(7),
                              };
    NSLog(@"collecte paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/collecte",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            id result = [dic objectForKey:@"result"];
            BOOL collecteState = [[result objectForKey:@"collecteState"] boolValue];
            if (collecteState != temp.isCollected) {//状态有变化的时候
                temp.isCollected = collecteState;
                temp.isCollected = collecteState;
            }
            
            block(result,nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            block(nil,[NSError errorWithDomain:errorStr
                                          code:codeNumber.intValue
                                      userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        block(nil,error);
    }];
}

/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSDictionary*dic, NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.travelNotesId),
                              @"allSpotsType":@(7),
                              };
    NSLog(@"like paraDic:%@",paraDic);
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/like",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            id result = [dic objectForKey:@"result"];
            BOOL likedState = [[result objectForKey:@"likedState"] boolValue];
            if (likedState != temp.isLiked) {//状态有变化的时候
                temp.isLiked = likedState;
                temp.isLiked = likedState;
                if (temp.isLiked) {
                    temp.likeNum = temp.likeNum + 1;
                    temp.likeNum = temp.likeNum + 1;
                }
                else{
                    temp.likeNum = temp.likeNum - 1;
                    temp.likeNum = temp.likeNum - 1;
                }
            }
            block(result,nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            block(nil,[NSError errorWithDomain:errorStr
                                          code:codeNumber.intValue
                                      userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        block(nil,error);
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
