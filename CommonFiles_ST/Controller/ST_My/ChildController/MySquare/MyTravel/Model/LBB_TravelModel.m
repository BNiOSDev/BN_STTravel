//
//  LBB_TravelModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelModel.h"

@implementation LBB_TravelModel

/**
 *3.1.4 收藏(已测)
 */
//allSpotsType	Int	1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略11 美食专题 12民宿专题 13景点专题

- (void)collect
{
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/collecte",BASEURL];
    
    NSDictionary *parames = @{
                              @"allSpotsId":@(self.travelNoteId),
                              @"allSpotsType" :@(7)
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

/**
 *3.1.5 点赞(已测)
 */
//allSpotsType	Int	1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略11 美食专题 12民宿专题 13景点专题
- (void)like
{
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/like",BASEURL];
    
    NSDictionary *parames = @{
                              @"allSpotsId":@(self.travelNoteId),
                              @"allSpotsType" :@(7)
                              };
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSDictionary *result = [dic objectForKey:@"result"];
            int likedState = [[result objectForKey:@"likedState"] intValue];
            if (weakSelf.isLiked == 1 && likedState == 0 ) {
                weakSelf.totalLike -= 1;
            }else {
                weakSelf.totalLike += 1;
            }
            weakSelf.isLiked = likedState;
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
/**
 *3.5.7 我的-广场游记 删除（已测）
 */
- (void)deleteTravel
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/travelNotes/delete",BASEURL];
    
    NSDictionary *parames = @{
                              @"travelNoteId":@(self.travelNoteId)
                              };
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
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

@implementation LBB_TravelViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.travelArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.5.6 我的-广场 游记（已测）
 *3.5.12 我的-收藏 广场 游记（已测）
 */
- (void)getMyTravelList:(BOOL)isClear VidewType:(MySquareViewType)videoType
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/travelNotes/list",BASEURL];
    if (videoType == MySquareViewFravorite) {
        url =[NSString stringWithFormat:@"%@/mime/myCollect/travelNotes/list",BASEURL];
    }

    int curPage = isClear == YES ? 0 : round(self.travelArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    __weak typeof(self) weakSelf = self;
    self.travelArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_TravelModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
                [weakSelf.travelArray removeAllObjects];
            }
            
            [weakSelf.travelArray addObjectsFromArray:returnArray];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        
        weakSelf.travelArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.travelArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
