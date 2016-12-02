//
//  LBB_MessageCenterModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/12/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MessageCenterModel.h"

@implementation LBB_MessageCenterModel

/**
 *3.10.2 消息-消息中心(已测)
 */
- (void)getMessage
{
    NSString *url = [NSString stringWithFormat:@"%@/msg/center",BASEURL];
    
    self.loadSupport.loadEvent = NetLoadingEvent;
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSLog(@"responseObject = %@",responseObject);
        NSString *remark = [dic objectForKey:@"remark"];
        if(codeNumber.intValue == 0)
        {
            [weakSelf mj_setKeyValues:[dic objectForKey:@"result"]];
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else {
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
