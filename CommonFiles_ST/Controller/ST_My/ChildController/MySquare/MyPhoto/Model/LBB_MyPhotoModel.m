//
//  LBB_MyPhotoModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyPhotoModel.h"
 

@implementation LBB_MyPhotoModel

/**
 * 3.5.5 我的-广场图片/视频删除（已测）
 */
- (void)deleteMyPhoto
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/square/delete",BASEURL];
   
    NSDictionary *parames = @{
                              @"ugcId":@(self.ugcId)
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

/**
 *3.1.4 收藏(已测)
 */
//allSpotsType	Int	1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略11 美食专题 12民宿专题 13景点专题

- (void)collect
{
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/collecte",BASEURL];
    
    NSDictionary *parames = @{
                              @"allSpotsId":@(self.ugcId),
                              @"allSpotsType" :@(5)
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
                              @"allSpotsId":@(self.ugcId),
                              @"allSpotsType" :@(5)
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

@end

@implementation LBB_MyPhotoViewModel


- (id)init
{
    self = [super init];
    if (self) {
        self.photoArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.5.4 我的-广场图片列表（已测)
 *3.5.13 我的-收藏 广场 照片（已测）
 */
- (void)getMyPhotoList:(BOOL)isClear VidewType:(MySquareViewType)videoType
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/square/image/list",BASEURL];
    if (videoType == MySquarePhotoViewFravorite) {
        url = [NSString stringWithFormat:@"%@/mime/myCollect/square/images/list",BASEURL];
    }
 
    int curPage = isClear == YES ? 0 : round(self.photoArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    __weak typeof(self) weakSelf = self;
    self.photoArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_MyPhotoModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
                [weakSelf.photoArray removeAllObjects];
            }
            
            [weakSelf.photoArray addObjectsFromArray:returnArray];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        
        weakSelf.photoArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.photoArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}

@end
