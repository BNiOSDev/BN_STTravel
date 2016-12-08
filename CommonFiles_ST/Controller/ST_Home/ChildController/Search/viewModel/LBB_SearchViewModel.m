//
//  LBB_SearchViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SearchViewModel.h"

@implementation LBB_SearchHotWordModel



@end

@implementation LBB_SearchSquareUgc
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
@end

@implementation LBB_SearchViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hotWordArray = [[NSMutableArray alloc]initFromNet];
        self.scenicSpotsArray = [[NSMutableArray alloc]initFromNet];
        self.foodSpotsArray = [[NSMutableArray alloc]initFromNet];
        self.hostelSpotsArray = [[NSMutableArray alloc]initFromNet];
        self.allSpotWordArray = [[NSMutableArray alloc]initFromNet];
        self.userArray = [[NSMutableArray alloc]initFromNet];
        self.ugcArray = [[NSMutableArray alloc]initFromNet];
        self.travelNoteArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}


- (void)getHotWordArray
{

    NSDictionary *paraDic = @{};
    
    NSString *url = [NSString stringWithFormat:@"%@/search/hotWords",BASEURL];
    __weak typeof(self) temp = self;
    self.hotWordArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SearchHotWordModel mj_objectArrayWithKeyValuesArray:array];
            NSLog(@"getHotWordArray success:%@",returnArray);
            [temp.hotWordArray removeAllObjects];
            [temp.hotWordArray addObjectsFromArray:returnArray];
            temp.hotWordArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            
        }
        
        temp.hotWordArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.hotWordArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.6.4	搜索-景点/美食/民宿（已测）
 
 @param longitude Y坐标
 @param dimensionality X坐标
 @param allSpotsType 1.美食 2.民宿 3景点
 @param name 搜索名称
 @param clear 清空原数据
 */
- (void)getAllSpotsArrayLongitude:(NSString *)longitude
                 dimensionality:(NSString *)dimensionality
                   allSpotsType:(int)allSpotsType
                           name:(NSString*)name
                      clearData:(BOOL)clear
{
    NSMutableArray *sportArray;
    switch (allSpotsType) {
        case 1:
            sportArray = self.foodSpotsArray;
            break;
        case 2:
            sportArray = self.hostelSpotsArray;
            break;
        case 3:
            sportArray = self.scenicSpotsArray;
            break;
        default:
            break;
    }
    int curPage = clear == YES ? 0 : round(sportArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"longitude":longitude,
                              @"dimensionality":dimensionality,
                              @"allSpotsType":@(allSpotsType),
                              @"name":name,
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };
    NSLog(@"getAllSpotsArrayLongitude paraDic: %@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/search/allSpots",BASEURL];
    __weak typeof(self) temp = self;
    __weak NSMutableArray *sportArray_block = sportArray;
    sportArray.loadSupport.loadEvent = NetLoadingEvent;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getAllSpotsArrayLongitude成功 allSpotsType:%d, data %@",allSpotsType,[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SpotModel mj_objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [sportArray_block removeAllObjects];
            }
            
            [sportArray_block addObjectsFromArray:returnArray];
            sportArray_block.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        sportArray_block.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getAllSpotsArrayLongitude失败  %@",error.domain);
        
        sportArray_block.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.6.5 搜索-景点/美食/民宿 词汇（已测）
 
 @param allSpotsType 1.美食 2.民宿 3景点
 @param name         搜索名称
 */
- (void)getSearchAllSpotsWordsArrayWithType:(int)allSpotsType
                                       name:(NSString*)name{

    NSDictionary *paraDic = @{
                              @"allSpotsType":@(allSpotsType),
                              @"name":name,
                              };
    NSLog(@"getSearchAllSpotsWordsArrayWithType paraDic: %@",paraDic);

    NSString *url = [NSString stringWithFormat:@"%@/search/allSpots/words",BASEURL];
    __weak typeof(self) temp = self;
    self.allSpotWordArray.loadSupport.loadEvent = NetLoadingEvent;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getSearchAllSpotsWordsArrayWithType成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SearchHotWordModel mj_objectArrayWithKeyValuesArray:array];
            
         
            [temp.allSpotWordArray removeAllObjects];
            
            [temp.allSpotWordArray addObjectsFromArray:returnArray];
            temp.allSpotWordArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.allSpotWordArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getSearchAllSpotsWordsArrayWithType失败  %@",error.domain);
        
        temp.allSpotWordArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}


/**
 3.6.6 搜索-用户（已测）
 
 @param name   搜索名称
 @param clear 清空原数据
 */
-(void)getUserArrayName:(NSString*)name
              clearData:(BOOL)clear{

    int curPage = clear == YES ? 0 : round(self.userArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              @"name":name,
                              };
    NSLog(@"getUserArrayName paraDic: %@",paraDic);
    
    NSString *url = [NSString stringWithFormat:@"%@/search/users",BASEURL];
    __weak typeof(self) temp = self;
    self.userArray.loadSupport.loadEvent = NetLoadingEvent;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getUserArrayName 成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_UserOther mj_objectArrayWithKeyValuesArray:array];
            
            if (clear) {
                [temp.userArray removeAllObjects];
            }
            [temp.userArray addObjectsFromArray:returnArray];
            temp.userArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.userArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getUserArrayName失败  %@",error.domain);
        
        temp.userArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
    
}

/**
 3.6.7 搜索-用户 词汇（已测）
 @param name 搜索名称
 */
- (void)getSearchUserWordsArray:(NSString*)name{

    NSDictionary *paraDic = @{
                              @"name":name,
                              };
    NSLog(@"getSearchUserWordsArray paraDic: %@",paraDic);
    
    NSString *url = [NSString stringWithFormat:@"%@/search/users/words",BASEURL];
    __weak typeof(self) temp = self;
    self.allSpotWordArray.loadSupport.loadEvent = NetLoadingEvent;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getSearchUserWordsArray成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SearchHotWordModel mj_objectArrayWithKeyValuesArray:array];
            
            
            [temp.allSpotWordArray removeAllObjects];
            
            [temp.allSpotWordArray addObjectsFromArray:returnArray];
            temp.allSpotWordArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.allSpotWordArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getSearchUserWordsArray失败  %@",error.domain);
        
        temp.allSpotWordArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.6.2 搜索-广场（已测）
 @param name 搜索名称
 */
- (void)getSquareUgcArray:(NSString*)name
                clearData:(BOOL)clear
{
    int curPage = clear == YES ? 0 : round(self.ugcArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              @"name":name,
                              };
    NSLog(@"getSquareUgcArray paraDic: %@",paraDic);
    
    NSString *url = [NSString stringWithFormat:@"%@/search/square",BASEURL];
    __weak typeof(self) temp = self;
    self.ugcArray.loadSupport.loadEvent = NetLoadingEvent;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getSquareUgcArray 成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SearchSquareUgc mj_objectArrayWithKeyValuesArray:array];
            
            if (clear) {
                [temp.ugcArray removeAllObjects];
            }
            [temp.ugcArray addObjectsFromArray:returnArray];
            temp.ugcArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.ugcArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getSquareUgcArray失败  %@",error.domain);
        
        temp.ugcArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}

/**
 3.6.3 搜索-广场 词汇（已测）
 @param name 搜索名称
 */
- (void)getSearchSquareWordsArray:(NSString*)name{
    
    NSDictionary *paraDic = @{
                              @"name":name,
                              };
    NSLog(@"getSearchSquareWordsArray paraDic: %@",paraDic);
    
    NSString *url = [NSString stringWithFormat:@"%@/search/square/words",BASEURL];
    __weak typeof(self) temp = self;
    self.allSpotWordArray.loadSupport.loadEvent = NetLoadingEvent;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getSearchSquareWordsArray成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SearchHotWordModel mj_objectArrayWithKeyValuesArray:array];
            
            
            [temp.allSpotWordArray removeAllObjects];
            
            [temp.allSpotWordArray addObjectsFromArray:returnArray];
            temp.allSpotWordArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.allSpotWordArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getSearchSquareWordsArray失败  %@",error.domain);
        
        temp.allSpotWordArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}

/**
 3.6.9 搜索-游记 词汇（已测）
 @param name 搜索名称
 */
- (void)getSearchTravelNotesWordsArray:(NSString*)name{
    
    NSDictionary *paraDic = @{
                              @"name":name,
                              };
    NSLog(@"getSearchTravelNotesWordsArray paraDic: %@",paraDic);
    
    NSString *url = [NSString stringWithFormat:@"%@/search/travelNotes/words",BASEURL];
    __weak typeof(self) temp = self;
    self.allSpotWordArray.loadSupport.loadEvent = NetLoadingEvent;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getSearchTravelNotesWordsArray成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_SearchHotWordModel mj_objectArrayWithKeyValuesArray:array];
            
            
            [temp.allSpotWordArray removeAllObjects];
            
            [temp.allSpotWordArray addObjectsFromArray:returnArray];
            temp.allSpotWordArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.allSpotWordArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getSearchTravelNotesWordsArray失败  %@",error.domain);
        
        temp.allSpotWordArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];

}

/**
 3.6.8 搜索-游记（已测）
 @param name 搜索名称
 */
- (void)getSquareTravelNoteArray:(NSString*)name
                       clearData:(BOOL)clear{
    int curPage = clear == YES ? 0 : round(self.travelNoteArray.count/10.0);
    NSDictionary *paraDic = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              @"name":name,
                              };
    NSLog(@"getSquareTravelNoteArray paraDic: %@",paraDic);
    
    NSString *url = [NSString stringWithFormat:@"%@/search/travelNotes",BASEURL];
    __weak typeof(self) temp = self;
    self.travelNoteArray.loadSupport.loadEvent = NetLoadingEvent;
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"getSquareTravelNoteArray 成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [BN_SquareTravelList mj_objectArrayWithKeyValuesArray:array];
            
            if (clear) {
                [temp.travelNoteArray removeAllObjects];
            }
            [temp.travelNoteArray addObjectsFromArray:returnArray];
            temp.travelNoteArray.networkTotal = [dic objectForKey:@"total"];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
        }
        
        temp.travelNoteArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getSquareTravelNoteArray失败  %@",error.domain);
        
        temp.travelNoteArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];


}

@end
