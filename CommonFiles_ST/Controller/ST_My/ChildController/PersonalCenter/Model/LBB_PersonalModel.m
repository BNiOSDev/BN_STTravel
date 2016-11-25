//
//  LBB_PersonalModel.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PersonalModel.h"

@implementation LBB_PersonalModel

- (id)init {
    self = [super init];
    if (self) {
    
    }
    return self;
}

/**
 3.5.21 我的-个人中心（已测）
 */
- (void)getPersonInfo:(NSString*)userToken
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/personalCenter",BASEURL];
    __weak typeof(self) temp = self;
    self.loadSupport.loadEvent = NetLoadingEvent;
    NSDictionary *parames = @{
                              @"Token":userToken
                              };
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            [temp mj_setKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getSpotDetailsData 成功  %@",[dic objectForKey:@"result"]);
            
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getSpotDetailsData 失败  %@",errorStr);
            
        }
        temp.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
