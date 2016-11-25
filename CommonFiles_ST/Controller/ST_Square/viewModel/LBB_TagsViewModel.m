//
//  LBB_TagsViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TagsViewModel.h"
#import "LBB_UserShowViewModel.h"

@implementation LBB_TagUserObj

@end

@implementation LBB_TagUser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userShowViewModel = [[NSClassFromString(@"LBB_UserShowViewModel") alloc]init];
    }
    return self;
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
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        
        temp.userShowViewModel.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.userShowViewModel.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

- (void)setObjs:(NSMutableArray *)objs
{
    NSMutableArray *array = (NSMutableArray *)[objs map:^id(NSDictionary *element) {
        return [LBB_TagUserObj mj_objectWithKeyValues:element];
    }];
    _objs = array;
}



@end

@implementation LBB_TagShowViewData

- (void)setTags:(NSMutableArray<LBB_SquareTags *> *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_SquareTags mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

@end

@implementation LBB_SquareTags

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tagsViewModel = [[LBB_TagsViewModel alloc]init];
        self.showImageHotArray = [[NSMutableArray alloc]initFromNet];
         self.showImageTimeArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}

/**
 1.1.1	广场-广场主页-标签主页-列表（已测）
 
 */
- (void)getTagsViewModelData
{
    NSString *url = [NSString stringWithFormat:@"%@/square/tags/view",BASEURL];
    
    NSDictionary *paraDic = @{
                              @"tagId":@(self.tagId),
                              };
    
    __weak typeof(self) temp = self;
    self.tagsViewModel.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.tagsViewModel mj_setKeyValues:[dic objectForKey:@"result"]];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
        }
        
        temp.tagsViewModel.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.tagsViewModel.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.4.11	广场-广场主页-标签主页-列表（已测）
 
 
 @param type 标签类型 1：热门排序 2：时间排序
 @param clear 清空原数据
 */
- (void)getShowImageArrayOrderType:(int)type ClearData:(BOOL)clear
{
    NSMutableArray *showArray = type == 2 ? self.showImageTimeArray:self.showImageHotArray;
    
    int curPage = clear == YES ? 0 : round(showArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"tagId":@(self.tagId),
                              @"orderType":@(type),
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/square/tags/view/list",BASEURL];
    __weak typeof(self) temp = self;
    __weak NSMutableArray *showArray_block = showArray;
    showArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_TagShowViewData mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [showArray_block removeAllObjects];
            }
            
            [showArray_block addObjectsFromArray:returnArray];
            showArray_block.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        showArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        showArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
    
}


@end

@implementation LBB_TagsViewModel


- (void)setTags:(NSMutableArray<LBB_SquareTags *> *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_SquareTags mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

@end
