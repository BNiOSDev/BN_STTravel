//
//  LBB_NearSign.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NearSign.h"

@implementation LBB_NearSign



/**
 3.1.9	签到(已测)
 
 @param objId 主键ID
 @param type 1美食 2 民宿 3 景点
 @param block 回调函数
 */
+ (void)signObjId:(long)objId type:(int)type block:(void (^)(NSError *error))block
{
    NSDictionary *paraDic = @{
                              @"objId":@(objId),
                              @"type":@(type),
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/sign",BASEURL];
    __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            id result = [dic objectForKey:@"result"];
            block(nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        block(error);
    }];
}

@end
