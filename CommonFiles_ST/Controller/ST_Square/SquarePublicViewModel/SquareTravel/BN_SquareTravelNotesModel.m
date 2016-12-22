//
//  LBB_SquareTravelDetailViewModel.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "BN_SquareTravelNotesModel.h"

@implementation BN_TravelNotesDetailsComments

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

@end

@implementation TravelNotesPics

-(id)init{
    
    if (self = [super init]) {
        self.imageUrl = @"";
    }
    return self;
    
}

@end


@implementation TravelNotesDetails

-(id)init{
    
    if (self = [super init]) {
        self.pics = [[NSArray alloc] init];
        self.picRemark = @"";//	String	图片描述
        self.picUrl = @"";
        self.releaseDate = @" 2016-11-15";//	String	发布日期
        self.releaseTime = @"20:30";//	String	发布时间
        self.allSpotsTypeName = @"";//	String	场景类型名称
        self.name = @"";;//	String	名称
        self.longitude = @"-1";//	String	经度
        self.dimensionality = @"-1";//	String	纬度
        self.billAmount = @"0";//	String	账单金额
        self.consumptionType = 1;//	Int	消费类型 1 民宿 2 交通 3 美食 4 门票 5 娱乐 6 购物 7 其他
        self.consumptionDesc = @"";;//	String	消费描述
        self.allSpotsType = 1;//1美食 2 民宿 3 景点
        self.travelNotesDetailsComments = [[BN_TravelNotesDetailsComments alloc]init];
    }
    return self;
}

/**
 3.4.29	主页-足记评论（已测)
 */
-(void)getTravelNotesDetailsCommentsModel{
    
    NSDictionary *paraDic = @{
                              @"travelNotesDetailId":@(self.travelNotesDetailId),
                              };
    NSLog(@"paraDic:%@",paraDic);
    
    
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotesDetail/comments",BASEURL];
    __weak typeof(self) temp = self;
    self.travelNotesDetailsComments.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.travelNotesDetailsComments mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getTravelDetailModel 成功  %@",[dic objectForKey:@"result"]);
            NSLog(@"getTravelDetailModel temp.travelDetailModel:  %@",temp.travelNotesDetailsComments);
            
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getTravelDetailModel errorStr : %@",errorStr);
            
        }
        
        temp.travelNotesDetailsComments.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getTravelDetailModel 失败 : %@",error.domain);
        
        temp.travelNotesDetailsComments.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

-(void)setPics:(NSArray<TravelNotesPics *> *)pics{

    NSMutableArray *array = [@[] mutableCopy];
    [pics enumerateObjectsUsingBlock:^(TravelNotesPics * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        TravelNotesPics *tag = [TravelNotesPics mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _pics = array;
}

/**
 3.4.24 主页-足记保存（已测）
 
 @param isAdd YES:新增足迹  NO:修改足迹
 @param travelNoteId 草稿的游记id
 @param block 结果回调
 */
-(void)saveTravelTrackData:(BOOL)isAdd
                   travelNoteId:(long)travelNoteId
                   address:(LBB_SpotAddress*)spotAddress
                     block:(void (^)(NSError *error))block{
    NSDictionary *paraDic;
    NSMutableArray *picsArray = (NSMutableArray *)[self.pics map:^id(TravelNotesPics *element) {
        
        NSDictionary* dic = @{@"imageUrl":element.imageUrl};
        return dic;
    }];
    
    NSLog(@"picsArray:%@",picsArray);
    
    if (isAdd) {
        paraDic = @{
                                  @"releaseTime":self.releaseTime,
                                  @"releaseDate":self.releaseDate,
                                  @"travelNoteId":@(travelNoteId),
                                  @"name":self.name,
                                  @"picUrl":self.picUrl,
                                  @"picRemark":self.picRemark,
                                  @"longitude":spotAddress.longy,
                                  @"dimensionality":spotAddress.dimx,
                                  @"billAmount":@([self.billAmount doubleValue]),
                                  @"allSpotsType":@(self.allSpotsType),
                                  @"objId":@(spotAddress.allSpotsId),
                                  @"consumptionType":@(self.consumptionType),
                                  @"consumptionDesc":self.consumptionDesc,
                                  @"pics":picsArray,
                                  };
    }
    else{
        paraDic = @{
                                  @"travelNotesDetailId":@(self.travelNotesDetailId),//非空则代表修改
                                  @"releaseTime":self.releaseTime,
                                  @"releaseDate":self.releaseDate,
                                  @"travelNoteId":@(travelNoteId),
                                  @"name":self.name,
                                  @"picUrl":self.picUrl,
                                  @"longitude":spotAddress.longy,
                                  @"dimensionality":spotAddress.dimx,
                                  @"dimensionality":self.dimensionality,
                                  @"billAmount":@([self.billAmount doubleValue]),
                                  @"allSpotsType":@(self.allSpotsType),
                                  @"objId":@(spotAddress.allSpotsId),
                                  @"consumptionType":@(self.consumptionType),
                                  @"consumptionDesc":self.consumptionDesc,
                                  @"pics":picsArray,

                                  };
    }
    

    NSLog(@"saveTravelTrackData paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotesDetail/save",BASEURL];
    
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"saveTravelTrackData成功:%d",[codeNumber intValue]);
            block(nil);
            
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"saveTravelTrackData errorStr : %@",errorStr);
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"saveTravelTrackData 失败 : %@",error.domain);
        
        block(error);
    }];
}


/**
 3.4.26 主页-足记删除（已测）
 
 @param block 结果回调
 */
-(void)deleteTravelTrackData:(void (^)(NSError *error))block{
    NSDictionary *paraDic = @{
                              @"travelNotesDetailId":@(self.travelNotesDetailId),
                    };
    
    NSLog(@"deleteTravelTrackData paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotesDetail/delete",BASEURL];
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"deleteTravelTrackData成功:%d",[codeNumber intValue]);
            block(nil);
            
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"deleteTravelTrackData errorStr : %@",errorStr);
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"deleteTravelTrackData 失败 : %@",error.domain);
        
        block(error);
    }];
    
}

/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSDictionary*dic, NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"allSpotsId":@(self.travelNotesDetailId),
                              @"allSpotsType":@(9),
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

@implementation BN_SquareTravelNotesModel

-(id)init{
    
    if (self = [super init]) {
        self.travelBillModel = [[BN_SquareTravelNotesBillModel alloc] init];
        self.displayState = 1;//	查看状态 1公开游记 2好友可见 3 自己可见
        
        self.name = @"";//	String	游记名称
        self.picUrl = @"";//	String	游记封面
        self.picRemark = @"";//	String	游记封面备注

        self.userName = @"";//	String	用户名称
        self.userPicUrl = @"";//	String	用户头像
        self.lastReleaseTime = @"";//	String	发表日期
        self.shareUrl = @"";//	String	分享URL
        self.shareTitle = @"";//	String	分享标题
        self.shareContent = @"";//	String	分享内容
        self.picUrl = @"";
        self.tags = [[NSArray alloc] init];
        
    }
    return self;
}

-(void)setTravelNotesDetails:(NSArray<TravelNotesDetails *> *)travelNotesDetails{
    NSMutableArray *array = [@[] mutableCopy];
    [travelNotesDetails enumerateObjectsUsingBlock:^(TravelNotesDetails * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        TravelNotesDetails *tag = [TravelNotesDetails mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _travelNotesDetails = array;
}


- (void)setTags:(NSArray<LBB_SquareTags *> *)tags
{
    NSMutableArray *array = [@[] mutableCopy];
    [tags enumerateObjectsUsingBlock:^(LBB_SquareTags * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        LBB_SquareTags *tag = [LBB_SquareTags mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _tags = array;
}


/**
 3.4.18 主页-游记账单（已测）
 */
-(void)getTravelBilllModel{

    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/bill/%ld",BASEURL,self.travelNotesId];
    __weak typeof(self) temp = self;
    self.travelBillModel.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.travelBillModel mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getTravelBilllModel 成功  %@",[dic objectForKey:@"result"]);
            NSLog(@"getTravelBilllModel temp.travelBillModel:  %@",temp.travelBillModel);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getTravelBilllModel errorStr : %@",errorStr);
            
        }
        temp.travelBillModel.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getTravelBilllModel 失败 : %@",error.domain);
        
        temp.travelBillModel.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end

