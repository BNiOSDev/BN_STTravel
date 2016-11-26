//
//  LBB_SetPushViewModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SetPushViewModel.h"

@implementation LBB_SetPushViewModel

/**
 *3.5.37 我的-查看设置（已测）
 */
- (void)getSettingData
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/setting",BASEURL];
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            [weakSelf mj_setKeyValues:[dic objectForKey:@"result"]];
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else{
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 *3.5.38 我的-设置（已测）
 */
- (void)updateSettingData:(NSString*)settingName settingValue:(int)settingValue
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/setting/update",BASEURL];
    __weak typeof(self) weakSelf = self;
    NSDictionary *parames = @{
                              @"settingName" : settingName,
                              @"settingValue" : @(settingValue)
                              };
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else{
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
