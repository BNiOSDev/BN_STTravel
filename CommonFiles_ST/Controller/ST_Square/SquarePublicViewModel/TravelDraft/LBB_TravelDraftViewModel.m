//
//  LBB_TravelDraftViewModel.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelDraftViewModel.h"

@implementation LBB_TravelDraftViewModel

-(id)init{
    
    if (self = [super init]) {
        self.travelDraftModel = [[BN_SquareTravelNotesModel alloc] init];
    }
    return self;
}


/**
 3.4.17 主页-游记详情/游记下载（已测）
 */
-(void)getTravelDraftData{
    
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/edit",BASEURL];
    __weak typeof(self) temp = self;
    self.travelDraftModel.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.travelDraftModel mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getTravelDraftData 成功  %@",[dic objectForKey:@"result"]);
            NSLog(@"getTravelDraftData temp.travelDetailModel:  %@",temp.travelDraftModel);
            
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getTravelDraftData errorStr : %@",errorStr);
            
        }
        
        temp.travelDraftModel.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getTravelDraftData 失败 : %@",error.domain);
        
        temp.travelDraftModel.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}


/**
 3.4.21 主页-游记修改草稿保存（已测）
 */
-(void)saveTravelDraftData:(void (^)(NSError *error))block;{
    
    
    NSMutableArray *tagsArray = (NSMutableArray *)[self.travelDraftModel.tags map:^id(LBB_SquareTags *element) {
        
        NSDictionary* dic = @{@"tagId":@(element.tagId)};
        return dic;
    }];
    NSDictionary *paraDic = @{
                            //  @"travelNoteId":@(self.travelDraftModel.travelNotesId),
                              @"picUrl":self.travelDraftModel.picUrl,
                              @"picRemark":self.travelDraftModel.picRemark,
                              @"name":self.travelDraftModel.name,
                              @"displayState":@(self.travelDraftModel.displayState),
                              @"tags":tagsArray,

                              };
    NSLog(@"paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/save",BASEURL];
    __weak typeof(self) temp = self;
    self.travelDraftModel.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp.travelDraftModel mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"saveTravelDraftData 成功  %@",[dic objectForKey:@"result"]);
            NSLog(@"saveTravelDraftData temp.travelDetailModel:  %@",temp.travelDraftModel);
            
            NSLog(@"saveTravelDraftData travelNotesId:%ld",temp.travelDraftModel.travelNotesId);
            NSLog(@"saveTravelDraftData userName:%@",temp.travelDraftModel.userName);
            NSLog(@"saveTravelDraftData userPicUrl:%@",temp.travelDraftModel.userPicUrl);
            NSLog(@"saveTravelDraftData lastReleaseTime:%@",temp.travelDraftModel.lastReleaseTime);
            block(nil);

        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"saveTravelDraftData errorStr : %@",errorStr);
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
        
        temp.travelDraftModel.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getTravelDraftModel 失败 : %@",error.domain);
        
        temp.travelDraftModel.loadSupport.loadEvent = NetLoadFailedEvent;
        block(error);
    }];
    
}

/**
 3.4.22 主页-游记删除（已测）
 */
-(void)deleteTravelDraftData:(void (^)(NSError *error))block{
    

    NSDictionary *paraDic = @{
                              @"travelNoteId":@(self.travelDraftModel.travelNotesId),
   
                              };
    NSLog(@"paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/delete",BASEURL];
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"deleteTravelDraftData成功:%d",[codeNumber intValue]);
            block(nil);
            
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"deleteTravelDraftData errorStr : %@",errorStr);
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"deleteTravelDraftData 失败 : %@",error.domain);
        
        block(error);
    }];

}

/**
 3.4.23 主页-游记发布（已测）
 */
-(void)publicTravelDraftData:(void (^)(NSError *error))block{

    
    NSDictionary *paraDic = @{
                              @"travelNoteId":@(self.travelDraftModel.travelNotesId),
            
                              };
    NSLog(@"paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/release",BASEURL];
    
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"publicTravelDraftData成功:%d",[codeNumber intValue]);
            block(nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"publicTravelDraftData errorStr : %@",errorStr);
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"publicTravelDraftData 失败 : %@",error.domain);
        
        block(error);
    }];
}


@end
