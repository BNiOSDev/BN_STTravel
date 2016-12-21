//
//  LBB_SquareViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareViewModel.h"

@implementation LBB_SquareUgc


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.squareDetailViewModel = [[LBB_SquareDetailViewModel alloc]init];
        self.userShowViewModel = [[LBB_UserShowViewModel alloc]init];
    }
    return self;
}

- (void)setPics:(NSMutableArray<LBB_SquarePics *> *)pics
{
    NSMutableArray *array = (NSMutableArray *)[pics map:^id(NSDictionary *element) {
        return [LBB_SquarePics mj_objectWithKeyValues:element];
    }];
    _pics = array;
}

- (void)setTags:(NSMutableArray<LBB_SquareTags *> *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_SquareTags mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

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

/**
 3.4.5	广场-广场主页-图片/视频详情（已测）
 */
- (void)getSquareDetailViewModelData
{
    NSString *url = [NSString stringWithFormat:@"%@/square/ugc/view/%ld",BASEURL,self.ugcId];
    __weak typeof(self) temp = self;
    self.squareDetailViewModel.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.squareDetailViewModel mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getSquareDetailViewModelData succ:  %@",[dic objectForKey:@"result"]);

        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        
        temp.squareDetailViewModel.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.squareDetailViewModel.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.4.6	广场-广场主页-个人主页（添加导游部分、未开发）
 */
- (void)getUserShowViewModelData
{
    NSString *url = [NSString stringWithFormat:@"%@/square/user/view",BASEURL];
    
    NSDictionary *paraDic = @{
                              @"userId":@(self.userId),
                              };
    
    __weak typeof(self) temp = self;
    self.userShowViewModel.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.userShowViewModel mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getUserShowViewModelData成功  %@",[dic objectForKey:@"result"]);

        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getUserShowViewModelData失败  %@",errorStr);
        }
        
        temp.userShowViewModel.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.userShowViewModel.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getUserShowViewModelData error:  %@",error.domain);

    }];
}

/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSDictionary*dic, NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.ugcId),
                              @"allSpotsType":@(self.ugcType + 4),
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
                 temp.squareDetailViewModel.isCollected = collecteState;
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
                              @"allSpotsId":@(self.ugcId),
                              @"allSpotsType":@(self.ugcType + 4),
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
                temp.squareDetailViewModel.isLiked = likedState;
                if (temp.isLiked) {
                    temp.likeNum = temp.likeNum + 1;
                    temp.squareDetailViewModel.likeNum = temp.squareDetailViewModel.likeNum + 1;
                }
                else{
                    temp.likeNum = temp.likeNum - 1;
                    temp.squareDetailViewModel.likeNum = temp.squareDetailViewModel.likeNum - 1;
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

@implementation LBB_SquareFriend

- (void)attention:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"beUserId":@(self.followId),
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
            temp.AttentionStatus = [[result objectForKey:@"attentionState"] intValue];
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

@implementation LBB_SquareViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.squareRecommend = [[LBB_SquareFriend alloc]init];
        self.friendArray = [[NSMutableArray alloc]initFromNet];
        self.ugcImageArray = [[NSMutableArray alloc]initFromNet];
        self.ugcVideoArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}

/**
 3.4.1	广场-广场主页-好友推荐（已测）
 */
- (void)getSquareRecommendData
{
    NSString *url = [NSString stringWithFormat:@"%@/square/friends/recommend",BASEURL];
    __weak typeof(self) temp = self;
    self.squareRecommend.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.squareRecommend mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getSquareRecommendData 成功:%@",[dic objectForKey:@"result"]);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getSquareRecommendData失败  %@",errorStr);
        }
        
        temp.squareRecommend.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.squareRecommend.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getSquareRecommendData 失败 error:%@",error.domain);

    }];
}

/**
 3.4.2	广场-广场主页-好友推荐列表（已测）
 
 @param clear 清空原数据
 */
- (void)getFriendArrayClearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.friendArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/friends/list",BASEURL];
    __weak typeof(self) temp = self;
    self.friendArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getFriendArrayClearData 成功:%@",array);
            NSArray *returnArray = [LBB_SquareFriend mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.friendArray removeAllObjects];
            }
            
            [temp.friendArray addObjectsFromArray:returnArray];
            temp.friendArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getFriendArrayClearData errorStr:%@",errorStr);

        }
        
        temp.friendArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.friendArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getFriendArrayClearData 失败:%@",error.domain);

    }];

}

/**
 3.4.4	广场-广场主页-图片/视频列表（已测）
 
 @param type 1主页  视频为单独的2.视频
 @param clear 清空原数据
 */
- (void)getUgcArrayType:(int)type ClearData:(BOOL)clear
{
    NSMutableArray *ugcArray = type == 2 ? self.ugcVideoArray : self.ugcImageArray;
    
    int curPage = clear == YES ? 0 : round(ugcArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"type":@(type),
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/ugc/list",BASEURL];
    __weak typeof(self) temp = self;
    __weak NSMutableArray *ugcArray_block = ugcArray;
    ugcArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getUgcArrayType成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SquareUgc mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [ugcArray_block removeAllObjects];
            }
            
            [ugcArray_block addObjectsFromArray:returnArray];
            ugcArray_block.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getUgcArrayType errorStr:  %@",errorStr);

        }
        
        ugcArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getUgcArrayType失败  %@",error.domain);
        
        ugcArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
