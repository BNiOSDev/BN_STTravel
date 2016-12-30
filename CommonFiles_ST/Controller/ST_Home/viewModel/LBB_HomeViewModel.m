//
//  LBB_HomeViewModel.m
//  ST_Travel
//
//  Created by newman on 16/11/13.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HomeViewModel.h"


@implementation BN_HomeHotGoodsObject


/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.goods_id),
                              @"allSpotsType":@(14),
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/collecte",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            id result = [dic objectForKey:@"result"];
            temp.is_collect = [[result objectForKey:@"collecteState"] boolValue];
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

/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.goods_id),
                              @"allSpotsType":@(14),
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/like",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            id result = [dic objectForKey:@"result"];
            BOOL likedState = [[result objectForKey:@"likedState"] boolValue];
            if (likedState != temp.is_like) {//状态有变化的时候
                temp.is_like = likedState;
                if (temp.is_like) {
                    temp.total_like = temp.total_like + 1;
                }
                else{
                    temp.total_like = temp.total_like - 1;
                }
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

@implementation BN_HomeUgcList

/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.ugcId),
                              @"allSpotsType":@(self.ugcType + 4),
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/collecte",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            id result = [dic objectForKey:@"result"];
            temp.isCollected = [[result objectForKey:@"collecteState"] boolValue];
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

/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.ugcId),
                              @"allSpotsType":@(self.ugcType + 4),
                              };
    
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
                if (temp.isLiked) {
                    temp.likeNum = temp.likeNum + 1;
                }
                else{
                    temp.likeNum = temp.likeNum - 1;
                }
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

@implementation BN_HomeTag

@end

@implementation BN_HomeTravelNotes

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
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.travelNotesId),
                              @"allSpotsType":@(7),
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/collecte",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            id result = [dic objectForKey:@"result"];
            temp.isCollected = [[result objectForKey:@"collecteState"] boolValue];
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

/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.travelNotesId),
                              @"allSpotsType":@(7),
                              };
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
                if (temp.isLiked) {
                    temp.likeNum = temp.likeNum + 1;
                }
                else{
                    temp.likeNum = temp.likeNum - 1;
                }
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

@implementation BN_HomeSpotsList

/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.allSpotsId),
                              @"allSpotsType":@(self.allSpotsType),
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
            temp.isCollected = [[result objectForKey:@"collecteState"] boolValue];
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

/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.allSpotsId),
                              @"allSpotsType":@(self.allSpotsType),
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
                if (temp.isLiked) {
                    temp.likeNum = temp.likeNum + 1;
                }
                else{
                    temp.likeNum = temp.likeNum - 1;
                }
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

@implementation BN_HomeNotices

@end



@implementation LBB_HomeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.advertisementArray = [[NSMutableArray alloc]initFromNet];
        self.spotAdvertisementArray = [[NSMutableArray alloc]initFromNet];
        self.noticesArray = [[NSMutableArray alloc]initFromNet];
        self.spotsArray = [[NSMutableArray alloc]initFromNet];
        self.travelNotesArray = [[NSMutableArray alloc]initFromNet];
        self.scenicSpotsArray = [[NSMutableArray alloc]initFromNet];
        self.footSpotsArray = [[NSMutableArray alloc]initFromNet];
        self.liveSpotsArray = [[NSMutableArray alloc]initFromNet];
        self.ugcArray = [[NSMutableArray alloc]initFromNet];
        self.giftAdvertisementArray = [[NSMutableArray alloc] initFromNet];
        self.goodsArray = [[NSMutableArray alloc] initFromNet];

    }
    return self;
}

/**
 3.1.2 广告轮播
 
 @param clear 是否清空原数据
 */
- (void)getAdvertisementListArrayClearData:(BOOL)clear
{
//    int curPage = clear == YES ? 0 : round(self.advertisementArray.count/10.0);
//    NSDictionary *paraDic = @{
//                              @"curPage":[NSNumber numberWithInt:curPage],
//                              @"pageNum":[NSNumber numberWithInt:10],
//                              };
    NSDictionary *paraDic = @{
                              @"position":@(1)
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/advertisementList",BASEURL];
    __weak typeof(self) temp = self;
    self.advertisementArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_HomeAdvertisement mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.advertisementArray removeAllObjects];
            }
            
            [temp.advertisementArray addObjectsFromArray:returnArray];
            temp.advertisementArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
        //    NSString *errorStr = [dic objectForKey:@"remark"];

        }
        
        temp.advertisementArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.advertisementArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.1.2 广告轮播 5.首页热门推荐
 
 @param clear 是否清空原数据
 */
- (void)getSpotAdvertisementListArrayClearData:(BOOL)clear
{
//    int curPage = clear == YES ? 0 : round(self.advertisementArray.count/10.0);
//    NSDictionary *paraDic = @{
//                              @"curPage":[NSNumber numberWithInt:curPage],
//                              @"pageNum":[NSNumber numberWithInt:10],
//                              };
    NSDictionary *paraDic = @{
                              @"position":@(5)
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/advertisementList",BASEURL];
    __weak typeof(self) temp = self;
    self.spotAdvertisementArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getSpotAdvertisementListArrayClearData:%@",array);
            NSArray *returnArray = [BN_HomeAdvertisement mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.spotAdvertisementArray removeAllObjects];
            }
            
            [temp.spotAdvertisementArray addObjectsFromArray:returnArray];
            temp.spotAdvertisementArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
        //    NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.spotAdvertisementArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {

        temp.spotAdvertisementArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}


/**
 3.1.2 广告轮播 11 首页-伴手礼推荐广告位
 
 @param clear 是否清空原数据
 */
- (void)getGiftAdvertisementListArrayClearData:(BOOL)clear{
    //    int curPage = clear == YES ? 0 : round(self.advertisementArray.count/10.0);
    //    NSDictionary *paraDic = @{
    //                              @"curPage":[NSNumber numberWithInt:curPage],
    //                              @"pageNum":[NSNumber numberWithInt:10],
    //                              };
    NSDictionary *paraDic = @{
                              @"position":@(11)
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/advertisementList",BASEURL];
    __weak typeof(self) temp = self;
    self.giftAdvertisementArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_HomeAdvertisement mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.giftAdvertisementArray removeAllObjects];
            }
            
            [temp.giftAdvertisementArray addObjectsFromArray:returnArray];
            temp.giftAdvertisementArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            //    NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.giftAdvertisementArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.giftAdvertisementArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.1.3 公告轮播
 
 @param clear 是否清空原数据
 */
- (void)getNoticesArrayClearData:(BOOL)clear
{
//    int curPage = clear == YES ? 0 : round(self.advertisementArray.count/10.0);
//    NSDictionary *paraDic = @{
//                              @"curPage":[NSNumber numberWithInt:curPage],
//                              @"pageNum":[NSNumber numberWithInt:10],
//                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/notices",BASEURL];
    __weak typeof(self) temp = self;
    self.noticesArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_HomeNotices mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.noticesArray removeAllObjects];
            }
            
            [temp.noticesArray addObjectsFromArray:returnArray];
            temp.noticesArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
        //    NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.noticesArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.noticesArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.1.4 热门推荐
 
 @param clear 是否清空原数据
 */
- (void)getSpotsArrayClearData:(BOOL)clear
{
    //    int curPage = clear == YES ? 0 : round(self.advertisementArray.count/10.0);
    //    NSDictionary *paraDic = @{
    //                              @"curPage":[NSNumber numberWithInt:curPage],
    //                              @"pageNum":[NSNumber numberWithInt:10],
    //                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/hot/spotsList",BASEURL];
    __weak typeof(self) temp = self;
    self.spotsArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"热门推荐getSpotsArrayClearData:%@",array);
            NSArray *returnArray = [BN_HomeSpotsList mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.spotsArray removeAllObjects];
            }
            
            [temp.spotsArray addObjectsFromArray:returnArray];
            temp.spotsArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
        //    NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.spotsArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {

        temp.spotsArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.1.7 游记推荐
 
 @param clear 是否清空原数据
 */
- (void)getTravelNotesArrayClearData:(BOOL)clear
{
    //    int curPage = clear == YES ? 0 : round(self.advertisementArray.count/10.0);
    //    NSDictionary *paraDic = @{
    //                              @"curPage":[NSNumber numberWithInt:curPage],
    //                              @"pageNum":[NSNumber numberWithInt:10],
    //                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/travelNotesList",BASEURL];
    __weak typeof(self) temp = self;
    self.travelNotesArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_HomeTravelNotes mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.travelNotesArray removeAllObjects];
            }
            
            [temp.travelNotesArray addObjectsFromArray:returnArray];
            temp.travelNotesArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
       //     NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.travelNotesArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {

        temp.travelNotesArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.1.8 达人推荐
 
 @param Type 1.景点 2.美食 3.民宿
 */
- (void)getSpotsArrayWithType:(NSInteger)Type
{
    NSString *url = [NSString stringWithFormat:@"%@/homePage/master/spotsList",BASEURL];
    NSDictionary *paraDic = @{
                              @"type":@(Type)
                              };
    NSMutableArray *spotsArray = nil;
    switch (Type) {
        case 1://美食
            spotsArray = self.footSpotsArray;
            break;
        case 2://民宿
            spotsArray = self.liveSpotsArray;
            break;
        case 3://景点
            spotsArray = self.scenicSpotsArray;
            break;
        default:
            spotsArray = self.scenicSpotsArray;
            break;
    }
    
    spotsArray.loadSupport.loadEvent = NetLoadingEvent;
    
   // __weak typeof(self) temp = self;
    __weak NSMutableArray *spotsArray_block = spotsArray;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getSpotsArrayWithType type:%ld array:%@",Type,array);
            NSArray *returnArray = [BN_HomeSpotsList mj_objectArrayWithKeyValuesArray:array];
            [spotsArray_block removeAllObjects];
            
            [spotsArray_block addObjectsFromArray:returnArray];
            spotsArray_block.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
         //   NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        spotsArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        spotsArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.1.9 广场中心
 
 @param clear 是否清空原数据
 */
- (void)getUgcArrayClearData:(BOOL)clear
{
    //    int curPage = clear == YES ? 0 : round(self.advertisementArray.count/10.0);
    //    NSDictionary *paraDic = @{
    //                              @"curPage":[NSNumber numberWithInt:curPage],
    //                              @"pageNum":[NSNumber numberWithInt:10],
    //                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/ugcList",BASEURL];
    __weak typeof(self) temp = self;
    self.ugcArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_HomeUgcList mj_objectArrayWithKeyValuesArray:array];
            NSLog(@"getUgcArrayClearData:%@",array);

            if (clear == YES)
            {
                [temp.ugcArray removeAllObjects];
            }
            
            [temp.ugcArray addObjectsFromArray:returnArray];
            temp.ugcArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
      //      NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.ugcArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {

        temp.ugcArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 1.1.1	首页热门商品
 */
- (void)getGoodsArrayRecommend{
    NSString *url = [NSString stringWithFormat:@"%@/mall/hotGoods",BASEURL];
 
    NSMutableArray *spotsArray = nil;

    spotsArray = self.goodsArray;

    
    spotsArray.loadSupport.loadEvent = NetLoadingEvent;
    
    __weak typeof(self) temp = self;
    __weak NSMutableArray *spotsArray_block = spotsArray;
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_HomeHotGoodsObject mj_objectArrayWithKeyValuesArray:array];
            [spotsArray_block removeAllObjects];
            NSLog(@"getGoodsArrayRecommend:%@",array);

            [spotsArray_block addObjectsFromArray:returnArray];
            spotsArray_block.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            //   NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        spotsArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        spotsArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
