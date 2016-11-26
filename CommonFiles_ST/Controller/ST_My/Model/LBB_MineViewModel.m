//
//  LBB_MineViewModel.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/24.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MineViewModel.h"
#import "LBB_LoginManager.h"

@implementation LBB_MineModelData

/**
 3.5.1 我的-首页（已测）
 */
- (void)getMineInfo
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/index",BASEURL];
    
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
