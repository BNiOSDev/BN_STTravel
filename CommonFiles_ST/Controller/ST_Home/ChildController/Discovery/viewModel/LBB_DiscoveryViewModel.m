//
//  LBB_DiscoveryViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryViewModel.h"

@implementation LBB_DiscoveryDetailModel

-(id)init{
    
    if (self = [super init]) {
        self.name = @"";// 标题
        self.coverImagesUrl = @"";// 封面图片
        self.lineTime = @"" ;// 线路时长 如:1日游

        self.lineContent = @"" ;// 行程内容 为富文本
        self.lineFeature = @"" ;// 路线特色 为富文本
        self.shareUrl = @"" ;// 分享URL
        self.shareTitle = @"" ;// 分享标题
        self.shareContent = @"" ;// 分享内容

    }
    return self;
}


/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.lineId),
                              @"allSpotsType":@(10),
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
                              @"allSpotsId":@(self.lineId),
                              @"allSpotsType":@(10),
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

@implementation LBB_DiscoveryModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.discoveryDetail = [[LBB_DiscoveryDetailModel alloc]init];
    }
    return self;
}

/**
 3.3.5	攻略详情(已测)
 */
- (void)getDiscoveryDetailData
{
    NSString *url = [NSString stringWithFormat:@"%@/line/detail",BASEURL];
    NSDictionary *paraDic = @{
                              @"lineId":@(self.lineId)
                              };
    NSLog(@"getDiscoveryDetailData paraDic:%@",paraDic);

    __weak typeof(self) temp = self;
    self.discoveryDetail.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.discoveryDetail mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getDiscoveryDetailData success:%@",[dic objectForKey:@"result"]);

        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getDiscoveryDetailData faile:%@",errorStr);

        }
        
        temp.discoveryDetail.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.discoveryDetail.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getDiscoveryDetailData error:%@",error.domain);

    }];
}

@end

@implementation LBB_DiscoveryViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.discoveryArray = [[NSMutableArray alloc]initFromNet];
        self.squareSpotsArray = [[NSMutableArray alloc]initFromNet];
        self.advertisementArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}

- (void)getDiscoveryArrayClearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.discoveryArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    NSLog(@"getDiscoveryArrayClearData paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/line/list",BASEURL];
    __weak typeof(self) temp = self;
    self.discoveryArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getDiscoveryArrayClearData success:%@",array);

            NSArray *returnArray = [LBB_DiscoveryModel mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.discoveryArray removeAllObjects];
            }
            
            [temp.discoveryArray addObjectsFromArray:returnArray];
            temp.discoveryArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getDiscoveryArrayClearData faile:%@",errorStr);

        }
        
        temp.discoveryArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.discoveryArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getDiscoveryArrayClearData error:%@",error.domain);

    }];

}

/**
 3.3.4 攻略列表(已测)
 
 @param lineTime  lineTime	Long	行程时间
 @param allSpots  allSpots	String	场景列表  逗号隔开 1,2,3
 @param tags      tags	String	个性标签列表 逗号隔开 1,2,3
 @param clear    是否清空原数据
 */
- (void)getDiscoveryArrayClearData:(LBB_SquareTags*)lineTime
                          allSpots:(NSArray<LBB_SpotAddress*>*)allSpotArray
                              tags:(NSArray<LBB_SquareTags*>*)tagArray
                             clear:(BOOL)clear{
    int curPage = clear == YES ? 0 : round(self.discoveryArray.count/10.0);
    
    
    NSString* tagString = @"";
    for (int i = 0; i<tagArray.count; i++) {
        LBB_SquareTags* tag = tagArray[i];
       tagString = [tagString stringByAppendingString:[NSString stringWithFormat:@"%ld",tag.tagId]];
        if (i < tagArray.count - 1) {
           tagString = [tagString stringByAppendingString:@","];
        }
    }
    
    NSString* allSpotString = @"";
    for (int i = 0; i<allSpotArray.count; i++) {
        LBB_SpotAddress* tag = allSpotArray[i];
       allSpotString = [allSpotString stringByAppendingString:[NSString stringWithFormat:@"%ld",tag.allSpotsId]];
        if (i < allSpotArray.count - 1) {
           allSpotString = [allSpotString stringByAppendingString:@","];
        }
    }

    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              @"lineTime":@(lineTime.tagId),
                              @"tags":tagString,
                              @"allSpots":allSpotString,
                              };
    NSLog(@"getDiscoveryArrayClearData paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/line/list",BASEURL];
    __weak typeof(self) temp = self;
    self.discoveryArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getDiscoveryArrayClearData success:%@",array);
            
            NSArray *returnArray = [LBB_DiscoveryModel mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.discoveryArray removeAllObjects];
            }
            
            [temp.discoveryArray addObjectsFromArray:returnArray];
            temp.discoveryArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getDiscoveryArrayClearData faile:%@",errorStr);
            
        }
        
        temp.discoveryArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        temp.discoveryArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getDiscoveryArrayClearData error:%@",error.domain);
        
    }];

}

/**
 3.4.26	主页-游记添加地址（已测）
 
 @param allSpotsType 1.美食 2.民宿 3景点(可为空)
 @param name 可为空 模糊查询
 @param clear 是否清空原数据
 */
- (void)getsTravelNotesDetailAllSpotsType:(int)allSpotsType name:(NSString *)name ClearData:(BOOL)clear
{
    NSMutableArray *showArray = self.squareSpotsArray;
    
    int curPage = clear == YES ? 0 : round(showArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"allSpotsType":@(allSpotsType),
                              @"name":name,
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotesDetail/allSpots",BASEURL];
 //   __weak typeof(self) temp = self;
    __weak NSMutableArray *showArray_block = showArray;
    showArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SpotAddress mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [showArray_block removeAllObjects];
            }
            
            [showArray_block addObjectsFromArray:returnArray];
            showArray_block.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
  //          NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        showArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        showArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
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
                              @"position":@(7)
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
            NSString *errorStr = [dic objectForKey:@"remark"];
            
        }
        
        temp.advertisementArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.advertisementArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}


@end
