//
//  LBB_PoohMyFavoriteViewModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PoohMyFavoriteViewModel.h"

@implementation LBB_PoohMyFavoriteModel

/**
 *3.1.4 收藏(已测)
 */
//allSpotsType	Int	1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略11 美食专题 12民宿专题 13景点专题

- (void)collect:(int)allSpotsType
{
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/collecte",BASEURL];
    
    NSDictionary *parames = @{
                              @"allSpotsId":@(self.allSpotsId),
                              @"allSpotsType" :@(allSpotsType)
                              };
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSDictionary *result = [dic objectForKey:@"result"];
            int collecteState = [[result objectForKey:@"collecteState"] intValue];
            weakSelf.isCollected = collecteState;
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            weakSelf.loadSupport.netRemark = errorStr;
            weakSelf.loadSupport.loadFailEvent =  codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end


@implementation LBB_PoohMyFavoriteViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.favoriteArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.5.15 我的-收藏 广场 景点/美食/民宿 列表（已测）
 @parames allSpotsType	1.美食 2.民宿 3景点
 @parames isClear 是否清除缓存
 */
- (void)getPoohMyFavoriteData:(int)allSpotsType Clear:(BOOL)isClear
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/myCollect/allSpots/list",BASEURL];

    int curPage = isClear == YES ? 0 : round(self.favoriteArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              @"allSpotsType" : [NSNumber numberWithInt:allSpotsType]
                              };
    NSLog(@"getPoohMyFavoriteData parames:%@",parames);
    __weak typeof(self) weakSelf = self;
    self.favoriteArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getPoohMyFavoriteData 成功:%@",array);

            NSArray *returnArray = [LBB_PoohMyFavoriteModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
                [weakSelf.favoriteArray removeAllObjects];
            }
            
            [weakSelf.favoriteArray addObjectsFromArray:returnArray];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getPoohMyFavoriteData失败 errorStr: %@",errorStr);
        }
        weakSelf.favoriteArray.networkTotal = [dic objectForKey:@"total"];
        weakSelf.favoriteArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.favoriteArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getPoohMyFavoriteData失败 error: %@",error.domain);

    }];
}

@end



@implementation LBB_PoohMyFavoriteSpecialModel

/**
 *3.1.4 收藏(已测)
 */
//allSpotsType	Int	1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略11 美食专题 12民宿专题 13景点专题

- (void)collect:(int)allSpotsType
{
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/collecte",BASEURL];
    
    NSDictionary *parames = @{
                              @"allSpotsId":@(self.specialId),
                              @"allSpotsType" :@(allSpotsType)
                              };
    NSLog(@"collect parames:%@",parames);

    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSDictionary *result = [dic objectForKey:@"result"];
            int collecteState = [[result objectForKey:@"collecteState"] intValue];
            weakSelf.isCollected = collecteState;
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
            NSLog(@"collect 成功:%@",result);

        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            weakSelf.loadSupport.netRemark = errorStr;
            weakSelf.loadSupport.loadFailEvent =  codeNumber.intValue;
            NSLog(@"collect 失败errorStr:%@",errorStr);

        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"collect 失败error:%@",error.domain);

    }];
}


@end


@implementation LBB_PoohMyFavoriteSpecialViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.favoriteSpeciallArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.5.15 我的-收藏 广场 景点/美食/民宿 列表（已测）
 @parames allSpotsType	1.美食 2.民宿 3景点
 @parames isClear 是否清除缓存
 */
- (void)getPoohMyFavoriteSpecialData:(int)allSpotsType Clear:(BOOL)isClear
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/myCollect/special/list",BASEURL];

    int curPage = isClear == YES ? 0 : round(self.favoriteSpeciallArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              @"type" : [NSNumber numberWithInt:allSpotsType]
                              };
    NSLog(@"getPoohMyFavoriteSpecialData parames:%@",parames);

    __weak typeof(self) weakSelf = self;
    self.favoriteSpeciallArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSLog(@"getPoohMyFavoriteSpecialData 成功:%@",array);

            NSArray *returnArray = [LBB_PoohMyFavoriteSpecialModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
                [weakSelf.favoriteSpeciallArray removeAllObjects];
            }
            [weakSelf.favoriteSpeciallArray addObjectsFromArray:returnArray];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getPoohMyFavoriteSpecialData失败errorStr:  %@",errorStr);
        }
        weakSelf.favoriteSpeciallArray.networkTotal = [dic objectForKey:@"total"];
        weakSelf.favoriteSpeciallArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.favoriteSpeciallArray.loadSupport.loadEvent = NetLoadFailedEvent;
        NSLog(@"getPoohMyFavoriteSpecialData失败error:  %@",error.domain);

    }];
}

@end
