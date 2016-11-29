//
//  LBB_PersonalModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/23.
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
 3.5.23 我的-个人中心（已测）
 */
- (void)getPersonInfo
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/personalCenter",BASEURL];
    
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

/**
 3.5.24 我的-头像修改 （已测）
 */
- (void)updateUserPicture:(UIImage*)pictureImage
{
    if (!pictureImage) {
        return;
    }
    
    [[BC_ToolRequest sharedManager] uploadfile:@[pictureImage] block:^(NSArray *files, NSError *error){
        if (!error && [files count]) {
            
            NSString *qiniuImageURL = [files firstObject];
            
            if (!qiniuImageURL || [qiniuImageURL length] == 0) {
                return;
            }
            
            NSString *url = [NSString stringWithFormat:@"%@/mime/userPicUrl/update",BASEURL];
            self.loadSupport.loadEvent = NetLoadingEvent;
            if (!qiniuImageURL || [qiniuImageURL length] == 0) {
                return;
            }
            NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
            [parames setObject:qiniuImageURL forKey:@"userPicUrl"];
           
            [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
                NSDictionary *dic = (NSDictionary*)responseObject;
                NSNumber *codeNumber = [dic objectForKey:@"code"];
                NSString *remark = [dic objectForKey:@"remark"];
                NSLog(@"responseObject = %@",responseObject);
                if(codeNumber.intValue == 0)
                {
                    [self getPersonInfo];
                }else{
                    self.loadSupport.netRemark = remark;
                    self.loadSupport.loadFailEvent = codeNumber.intValue;
                }
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                self.loadSupport.loadEvent = NetLoadFailedEvent;
            }];
        }
    }];
}

/**
 3.5.25 我的-用户名修改（已测）
 */
- (void)updateUserName:(NSString*)userName
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/userName/update",BASEURL];
    
    if (!userName || [userName length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:userName forKey:@"userName"];

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
 3.5.26 我的-签名修改 （已测））
 */
- (void)updateSignature:(NSString*)signature
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/signature/update",BASEURL];
    
    if (!signature || [signature length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:signature forKey:@"signature"];
    
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

/**
 3.5.27 我的-手机号修改前校验（已测)
 */
- (void)updateCheckPhoneNum:(NSString*)phoneNum VerifyCode:(NSString*)verifyCode
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/phoneNum/update/check",BASEURL];
    
    if (!phoneNum || [phoneNum length] == 0 || !verifyCode || [verifyCode length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:phoneNum forKey:@"phoneNum"];
    [parames setObject:verifyCode forKey:@"verifyCode"];
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
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
 3.5.28 我的-手机号修改（已测)
 */
- (void)updatePhoneNum:(NSString*)phoneNum VerifyCode:(NSString*)verifyCode
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/phoneNum/update",BASEURL];
    
    if (!phoneNum || [phoneNum length] == 0 || !verifyCode || [verifyCode length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:phoneNum forKey:@"phoneNum"];
    [parames setObject:verifyCode forKey:@"verifyCode"];
    
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
 3.5.29 我的-性别修改（已测）
 */
- (void)updateGender:(int)gender
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/gender/update",BASEURL];

    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:[NSNumber numberWithInt:gender] forKey:@"gender"];
    
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
 3.5.30 我的-出生日期修改（已测）
 */
- (void)updateBirthDate:(NSString*)birthDate
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/birthDate/update",BASEURL];
    
    if (!birthDate || [birthDate length] == 0) {
        return;
    }
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:birthDate forKey:@"birthDate"];
    
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
 3.5.31 我的-地区修改（已测）
 */
- (void)updateArea:(int)provinceId CityId:(int)cityId AddressName:(NSString*)detailName
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/area/update",BASEURL];
    
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:[NSNumber numberWithInt:provinceId] forKey:@"provinceId"];
    [parames setObject:[NSNumber numberWithInt:cityId] forKey:@"cityId"];
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
            weakSelf.area = detailName;
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
