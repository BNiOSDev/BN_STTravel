//
//  LBB_SpotDetailsViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SpotDetailsViewModel.h"

@implementation LBB_SpotsNearbyRecommendData

- (void)setTags:(NSMutableArray<LBB_SpotsTag *> *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_SpotsTag mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

@end

@implementation LBB_SpotsCommentsRecord

@end

@implementation LBB_SpotsCollectedRecord

@end

@implementation LBB_SpotsFacilities

@end

@implementation LBB_SpotsTag

@end

@implementation LBB_SpotsUgc

@end

@implementation LBB_PurchaseRecords

@end

@implementation LBB_SpotsPics

@end

@implementation LBB_SpotDetailsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nearbySpotRecommends = [[NSMutableArray alloc]initFromNet];
        self.nearbyFoodRecommends = [[NSMutableArray alloc]initFromNet];
        self.nearbyHostelRecommends = [[NSMutableArray alloc]initFromNet];

    }
    return self;
}

- (void)setAllSpotsPics:(NSMutableArray<LBB_SpotsPics *> *)allSpotsPics
{
    NSMutableArray *array = (NSMutableArray *)[allSpotsPics map:^id(NSDictionary *element) {
        return [LBB_SpotsPics mj_objectWithKeyValues:element];
    }];
    _allSpotsPics = array;
}

- (void)setPurchaseRecords:(NSMutableArray<LBB_PurchaseRecords *> *)purchaseRecords
{
    NSMutableArray *array = (NSMutableArray *)[purchaseRecords map:^id(NSDictionary *element) {
        return [LBB_PurchaseRecords mj_objectWithKeyValues:element];
    }];
    _purchaseRecords = array;
}

- (void)setUgc:(NSMutableArray<LBB_SpotsUgc *> *)ugc
{
    NSMutableArray *array = (NSMutableArray *)[ugc map:^id(NSDictionary *element) {
        return [LBB_SpotsUgc mj_objectWithKeyValues:element];
    }];
    _ugc = array;
}

- (void)setTags:(NSMutableArray<LBB_SpotsTag *> *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_SpotsTag mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

- (void)setFacilities:(NSMutableArray<LBB_SpotsFacilities *> *)facilities
{
    NSMutableArray *array = (NSMutableArray *)[facilities map:^id(NSDictionary *element) {
        return [LBB_SpotsFacilities mj_objectWithKeyValues:element];
    }];
    _facilities = array;
}

- (void)setCollectedRecord:(NSMutableArray<LBB_SpotsCollectedRecord *> *)collectedRecord
{
    NSMutableArray *array = (NSMutableArray *)[collectedRecord map:^id(NSDictionary *element) {
        return [LBB_SpotsCollectedRecord mj_objectWithKeyValues:element];
    }];
    _collectedRecord = array;
}

- (void)setCommentsRecord:(NSMutableArray<LBB_SpotsCommentsRecord *> *)commentsRecord
{
    NSMutableArray *array = (NSMutableArray *)[commentsRecord map:^id(NSDictionary *element) {
        return [LBB_SpotsCommentsRecord mj_objectWithKeyValues:element];
    }];
    _commentsRecord = array;
}

/**
 3.2.8	周边推荐(已测)
 
 @param type 1.景点 2.美食 3.民宿
 @param clear 是否清空原数据
 */
- (void)getSpotNearbyRecommendsType:(int)type
                          clearData:(BOOL)clear
{
    
    NSMutableArray *spotsArray = nil;
    switch (type) {
        case 1:
            spotsArray = self.nearbySpotRecommends;
            break;
        case 2:
            spotsArray = self.nearbyFoodRecommends;
            break;
        case 3:
            spotsArray = self.nearbyHostelRecommends;
            break;
        default:
            spotsArray = self.nearbySpotRecommends;
            break;
    }
    int curPage = clear == YES ? 0 : round(spotsArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"longitude":self.longitude,
                              @"dimensionality":self.dimensionality,
                              @"type":@(type),
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    NSLog(@"getSpotNearbyRecommendsType paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/spot/nearbyRecommends",BASEURL];

    
    spotsArray.loadSupport.loadEvent = NetLoadingEvent;
    
    __weak typeof(self) temp = self;
    __weak NSMutableArray *spotsArray_block = spotsArray;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SpotsNearbyRecommendData mj_objectArrayWithKeyValuesArray:array];
            if (clear) {
                [spotsArray_block removeAllObjects];
            }
            NSLog(@"getSpotNearbyRecommendsType succ type:%d total:%@ data:%@",type,[dic objectForKey:@"total"],array);

            [spotsArray_block addObjectsFromArray:returnArray];
            spotsArray_block.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        spotsArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        spotsArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

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
            BOOL collecteState = [[result objectForKey:@"collecteState"] boolValue];
            if (collecteState != temp.isCollected) {//状态有变化的时候
                temp.isCollected = collecteState;
                if (temp.isCollected) {
                    temp.collecteNum = temp.collecteNum + 1;
                }
                else{
                    temp.collecteNum = temp.collecteNum - 1;
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

@implementation LBB_SpotModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spotDetails = [[LBB_SpotDetailsViewModel alloc]init];
    }
    return self;
}

- (void)setTags:(NSArray<LBB_SpotsTag *> *)tags
{
    NSMutableArray *array = [@[] mutableCopy];
    [tags enumerateObjectsUsingBlock:^(LBB_SpotsTag * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        LBB_SpotsTag *tag = [LBB_SpotsTag mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _tags = array;
}

/**
 3.2.7	景点/美食/民宿详情(已测)
 */
- (void)getSpotDetailsData:(BOOL)clear
{
    NSString *url = [NSString stringWithFormat:@"%@/spot/view/%ld",BASEURL,self.allSpotsId];
    __weak typeof(self) temp = self;
    self.spotDetails.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.spotDetails mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getSpotDetailsData success:%@",[dic objectForKey:@"result"]);
            //pooh add detail allSpotsType
            temp.spotDetails.allSpotsType = temp.allSpotsType;
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            
        }
        
        temp.spotDetails.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.spotDetails.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}


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

