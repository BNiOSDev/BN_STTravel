//
//  LBB_PersonalModel.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PersonalModel.h"
#import "LBB_LoginManager.h"

@implementation LBB_PersonalModel

- (id)init {
    self = [super init];
    if (self) {
        self.gender = 2;
    }
    return self;
}

/**
 3.5.21 我的-个人中心（已测）
 */
- (void)getPersonInfo:(NSString*)userToken
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/personalCenter",BASEURL];
    
    self.loadSupport.loadEvent = NetLoadingEvent;
    NSDictionary *parames = nil;
    if (!userToken) {
        userToken = [LBB_LoginManager shareInstance].userToken;
    }
    if (userToken && [userToken length]) {
        parames = @{
                    @"Token":userToken
                    };
    }
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
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

/**
 3.5.22 我的-头像修改 （已测）
 */
- (void)updateUserPicture:(NSString*)imageUrl Token:(NSString*)userToken
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/userPicUrl/update",BASEURL];
    self.loadSupport.loadEvent = NetLoadingEvent;
    if (!imageUrl || [imageUrl length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:imageUrl forKey:@"userPicUrl"];
    if (!userToken) {
        userToken = [LBB_LoginManager shareInstance].userToken;
    }
    
    if (userToken && [userToken length]) {
         [parames setObject:userToken forKey:@"Token"];
    }
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.userPicUrl = imageUrl;
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
 3.5.23 我的-用户名修改（已测）
 */
- (void)updateUserName:(NSString*)userName Token:(NSString*)userToken
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/userName/update",BASEURL];
    
    if (!userName || [userName length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:userName forKey:@"userName"];
    if (!userToken) {
        userToken = [LBB_LoginManager shareInstance].userToken;
    }
    if (userToken && [userToken length]) {
        [parames setObject:userToken forKey:@"Token"];
    }
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.userName = userName;
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else {
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
       
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.5.24 我的-签名修改 （已测））
 */
- (void)updateSignature:(NSString*)signature Token:(NSString*)userToken
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/signature/update",BASEURL];
    
    if (!signature || [signature length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:signature forKey:@"signature"];
    if (!userToken) {
        userToken = [LBB_LoginManager shareInstance].userToken;
    }
    if (userToken && [userToken length]) {
        [parames setObject:userToken forKey:@"Token"];
    }
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.signature = signature;
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else {
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

- (void)updatePhoneNum:(NSString*)phoneNum VerifyCode:(NSString*)verifyCode Token:(NSString*)userToken
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/phoneNum/update",BASEURL];
    
    if (!phoneNum || [phoneNum length] == 0 || !verifyCode || [verifyCode length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:phoneNum forKey:@"phoneNum"];
    [parames setObject:verifyCode forKey:@"verifyCode"];
    if (!userToken) {
        userToken = [LBB_LoginManager shareInstance].userToken;
    }
    if (userToken && [userToken length]) {
        [parames setObject:userToken forKey:@"Token"];
    }
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.phoneNum = phoneNum;
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else {
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadFailEvent = NetLoadFailedEvent;
    }];
}

/**
 3.5.26 我的-性别修改（已测）
 */
- (void)updateGender:(int)gender Token:(NSString*)userToken
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/gender/update",BASEURL];

    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:[NSNumber numberWithInt:gender] forKey:@"gender"];
    if (!userToken) {
        userToken = [LBB_LoginManager shareInstance].userToken;
    }
    if (userToken && [userToken length]) {
        [parames setObject:userToken forKey:@"Token"];
    }
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.gender = gender;
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
 3.5.27 我的-出生日期修改（已测）
 */
- (void)updateBirthDate:(NSString*)birthDate Token:(NSString*)userToken
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/birthDate/update",BASEURL];
    
    if (!birthDate || [birthDate length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:birthDate forKey:@"birthDate"];
    if (!userToken) {
        userToken = [LBB_LoginManager shareInstance].userToken;
    }
    if (userToken && [userToken length]) {
        [parames setObject:userToken forKey:@"Token"];
    }
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.birthDate = birthDate;
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
 3.5.28 我的-地区修改（已测）
 */
- (void)updateArea:(int)provinceId CityId:(int)cityId Token:(NSString*)userToken
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/area/update",BASEURL];
    
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:[NSNumber numberWithInt:provinceId] forKey:@"provinceId"];
    [parames setObject:[NSNumber numberWithInt:cityId] forKey:@"cityId"];
    if (!userToken) {
        userToken = [LBB_LoginManager shareInstance].userToken;
    }
    if (userToken && [userToken length]) {
        [parames setObject:userToken forKey:@"Token"];
    }
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.provId = provinceId;
            weakSelf.cityId = cityId;
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
