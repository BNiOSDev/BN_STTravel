//
//  LBB_MyVideoModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyVideoModel.h"

@implementation LBB_MyVideoTagModel


@end


@implementation LBB_MyVideoModel

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setTags:(NSMutableArray<LBB_MyVideoTagModel *> *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_MyVideoTagModel mj_objectWithKeyValues:element];
    }];
    _tags  = array;
}

@end

@implementation LBB_MyVideoViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.videoArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

/**
 *3.5.3 我的-广场视频列表（已测）
 *3.5.14 我的-收藏 广场 视频（已测）
 */
- (void)getMyVideoList:(BOOL)isClear VidewType:(MySquareViewType)videoType
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/square/video/list",BASEURL];
    if (videoType == MySquareVideoViewFravorite) {
       [NSString stringWithFormat:@"%@/mime/myCollect/square/video/list",BASEURL];
    } 
    
    int curPage = isClear == YES ? 0 : round(self.videoArray.count/10.0);
    
    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    __weak typeof(self) weakSelf = self;
    self.videoArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_MyVideoModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
                [weakSelf.videoArray removeAllObjects];
            }
            
            [weakSelf.videoArray addObjectsFromArray:returnArray];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        
        weakSelf.videoArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.videoArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}

@end
