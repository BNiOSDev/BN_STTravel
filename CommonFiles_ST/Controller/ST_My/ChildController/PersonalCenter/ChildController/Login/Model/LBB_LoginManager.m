//
//  LBB_LoginManager.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LoginManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation LoginUserInfo


@end


@interface LBB_LoginManager()

@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *checkNum;
@property(nonatomic,copy) NSString *userToken;
@property(nonatomic,copy) NSString *address;
@property(nonatomic,assign) NSInteger sex;
@property(nonatomic,assign) LoginType loginType;
@property(nonatomic,assign) BOOL isLogin;
@property(nonatomic,strong) UIImage *userHeadImage;

@end

@implementation LBB_LoginManager

/*
 * 获取登录实例
 */
+ (instancetype)shareInstance
{
    static LBB_LoginManager *_shareLoginManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareLoginManager = [[LBB_LoginManager alloc] init];
    });
    return _shareLoginManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)registered:(LoginType)loginType
     UserHeadImage:(UIImage*)headImage
           Account:(NSString*)account
          Password:(NSString*)password
          CheckNum:(NSString*)checkNum
               Sex:(NSInteger)sex
           Address:(NSString*)address
     CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock
{
    
    self.userHeadImage = headImage;
    self.account = account;
    self.password = password;
    self.loginType = loginType;
    self.checkNum = checkNum;
    self.resgisterCompleteBlock = completeBlock;
    
    self.sex = sex;
    if (address) {
        self.address = address;
    }
    //todo 调用注册接口
    NSString *deviceID  =  [self uuid];
    NSDictionary *paraDic = @{
                              @"phoneNum":self.account,
                              @"passwd":self.password,
                              @"deviceSystemType":@(2),
                              @"deviceId":deviceID,
                              @"verifyCode" : self.checkNum
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/mime/register",BASEURL];
    __weak typeof(self) weakSelf = self;

    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
         NSDictionary *dict = (NSDictionary*)responseObject;
         NSLog(@"responseObject = %@",dict);
         int code = [[dict objectForKey:@"code"] intValue];
         NSString *remark = [dict objectForKey:@"remark"];
         NSString *token = [dict objectForKey:@"token"];
          if (code == 0) {
             if (weakSelf.resgisterCompleteBlock) {
                 weakSelf.resgisterCompleteBlock(token,YES);
             }
              LoginUserInfo *loginCountInfo = [[LoginUserInfo alloc] init];
              loginCountInfo.account = weakSelf.account;
              loginCountInfo.password = weakSelf.password;
              [weakSelf saveLoginUserInfo:loginCountInfo];
          }else{
              if (weakSelf.resgisterCompleteBlock) {
                  weakSelf.resgisterCompleteBlock(remark,NO);
              }
          }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        if (weakSelf.resgisterCompleteBlock) {
            weakSelf.resgisterCompleteBlock(nil,NO);
        }
        NSLog(@"error = %@",error);
        
    }];
}

- (void)login:(LoginType)loginType
      Account:(NSString*)account
     Password:(NSString*)password
CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock
{
    self.account = account;
    self.password = password;
    self.loginType = loginType;
    self.loginCompleteBlock = completeBlock;
    
    NSString *deviceID  =  [self uuid];
    //todo 调用登录接口，登录完成后回调登录block
    NSDictionary *paraDic = @{
                              @"phoneNum":self.account,
                              @"passwd":self.password,
                              @"deviceSystemType":@(2),
                              @"deviceId":deviceID,
                              };

    NSString *url = [NSString stringWithFormat:@"%@/mime/login",BASEURL];
    __weak typeof(self) weakSelf = self;
    
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
        weakSelf.isLogin = YES;

         NSDictionary *dict = (NSDictionary*)responseObject;
         NSLog(@"responseObject = %@",dict);
         int code = [[dict objectForKey:@"code"] intValue];
         NSString *remark = [dict objectForKey:@"remark"];
         weakSelf.userToken = [dict objectForKey:@"token"];
         if (code == 0) {
             if (weakSelf.loginCompleteBlock) {
                 weakSelf.loginCompleteBlock(weakSelf.userToken,YES);
             }
             if (weakSelf.loginType == eLoginTelePhone) {
                 LoginUserInfo *loginCountInfo = [[LoginUserInfo alloc] init];
                 loginCountInfo.account = weakSelf.account;
                 loginCountInfo.password = weakSelf.password;
                 [weakSelf saveLoginUserInfo:loginCountInfo];
             }
            
         }else{
             if (weakSelf.loginCompleteBlock) {
                 weakSelf.loginCompleteBlock(remark,YES);
             }
         }

    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        weakSelf.isLogin = NO;
        NSLog(@"error = %@",error);
        if (weakSelf.loginCompleteBlock) {
            weakSelf.loginCompleteBlock(weakSelf.userToken,YES);
        }
    }];
}

- (void)logout:(void (^)(NSString *userToken,BOOL result))completeBlock;
{
    self.logoutCompleteBlock = completeBlock;
    
    NSDictionary *paraDic = @{
                              @"Token":self.userToken
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/mime/logout",BASEURL];
    __weak typeof(self) weakSelf = self;
    
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
                                     
         NSDictionary *dict = (NSDictionary*)responseObject;
         NSLog(@"responseObject = %@",dict);
         int code = [[dict objectForKey:@"code"] intValue];
         NSString *remark = [dict objectForKey:@"remark"];
         if (code == 0) {
             weakSelf.isLogin = NO;
             weakSelf.userToken = nil;
             if (weakSelf.logoutCompleteBlock) {
                 weakSelf.logoutCompleteBlock(nil,YES);
             }
         }else {
             if (weakSelf.logoutCompleteBlock) {
                 weakSelf.logoutCompleteBlock(remark,YES);
             }
         }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        weakSelf.isLogin = NO;
        if (weakSelf.logoutCompleteBlock) {
            weakSelf.logoutCompleteBlock(@"请求异常",NO);
        }
        NSLog(@"error = %@",error);
    }];
}

/*
 *  3.1.12获取验证码
  1:注册短信2.服务通知类短信3营销类短信4修改密码5:修改手机号码
 */
- (void)getVerificationCode:(NSString*)phoneNum Type:(int)type
{
    self.account = phoneNum;
    NSDictionary *paraDic = @{
                              @"phoneNum":self.account,
                              @"type":@(type)
                              };
    NSString *url = [NSString stringWithFormat:@"%@/homePage/smsVerifyCode",BASEURL];
 
    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
                                     NSLog(@"responseObject = %@",responseObject);
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                    NSLog(@"error = %@",error);
                                 }];
}

/*
 * 找回密码
 */
- (void)findPassword:(NSString*)phoneNum
            CheckNum:(NSString*)checkNum
       CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock
{
    self.account = phoneNum;
    self.checkNum = checkNum;
    self.findPSCompleteBlock = completeBlock;
    NSDictionary *paraDic = @{
                              @"phoneNum":self.account,
                              @"verifyCode":self.checkNum
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/mime/password/retrieve",BASEURL];
    __weak typeof(self) weakSelf = self;
    
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
                                     NSDictionary *dict = (NSDictionary*)responseObject;
                                     NSLog(@"responseObject = %@",dict);
                                     int code = [[dict objectForKey:@"code"] intValue];
                                     NSString *remark = [dict objectForKey:@"remark"];
                                     if (code == 0) {
                                         
                                         if (weakSelf.findPSCompleteBlock) {
                                             weakSelf.findPSCompleteBlock(self.account,YES);
                                         }
                                         LoginUserInfo *loginCountInfo = [[LoginUserInfo alloc] init];
                                         loginCountInfo.account = weakSelf.account;
                                         loginCountInfo.password = weakSelf.password;
                                         [weakSelf saveLoginUserInfo:loginCountInfo];
                                     }else {
                                         if (weakSelf.findPSCompleteBlock) {
                                             weakSelf.findPSCompleteBlock(remark,NO);
                                         }
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                     if (weakSelf.findPSCompleteBlock) {
                                         weakSelf.findPSCompleteBlock(@"请求异常",NO);
                                     }
                                     NSLog(@"error = %@",error);
                                 }];
}

/*
 * 设置密码
 */
- (void)setPassword:(NSString*)phoneNum
           Password:(NSString*)password
      CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock
{
    self.account = phoneNum;
    self.password = password;
    self.setPSCompleteBlock = completeBlock;
    NSDictionary *paraDic = @{
                              @"phoneNum":self.account,
                              @"verifyCode":self.checkNum,
                              @"passwd":self.password
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/mime/password/setting",BASEURL];
    __weak typeof(self) weakSelf = self;
    
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
                                     NSDictionary *dict = (NSDictionary*)responseObject;
                                     NSLog(@"responseObject = %@",dict);
                                     int code = [[dict objectForKey:@"code"] intValue];
                                     NSString *remark = [dict objectForKey:@"remark"];
                                     if (code == 0) {
                                         if (weakSelf.setPSCompleteBlock) {
                                             weakSelf.setPSCompleteBlock(weakSelf.userToken,YES);
                                         }
                                     }else {
                                         if (weakSelf.setPSCompleteBlock) {
                                             weakSelf.setPSCompleteBlock(remark,YES);
                                         }
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                     if (weakSelf.setPSCompleteBlock) {
                                         weakSelf.setPSCompleteBlock(@"请求异常",NO);
                                     }
                                     NSLog(@"error = %@",error);
                                 }];
}

/*
 * 3.5.33 我的-密码修改（已测）
 */
- (void)changePassword:(NSString*)token
              Password:(NSString*)oldPasswd
           NewPassword:(NSString*)newPasswd
         CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock
{
    self.changePSCompleteBlock = completeBlock;
    NSDictionary *paraDic = @{
                              @"Token":token,
                              @"oldPasswd":oldPasswd,
                              @"newPasswd":newPasswd
                              };
    
    __block NSString *changeToken = token;
    __block NSString *password = newPasswd;
    
    NSString *url = [NSString stringWithFormat:@"%@/mime/password/update",BASEURL];
    __weak typeof(self) weakSelf = self;
    
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
                                     NSDictionary *dict = (NSDictionary*)responseObject;
                                     NSLog(@"responseObject = %@",dict);
                                     int code = [[dict objectForKey:@"code"] intValue];
                                     NSString *remark = [dict objectForKey:@"remark"];
                                     if (code == 0) {
                                         if (weakSelf.changePSCompleteBlock) {
                                             weakSelf.changePSCompleteBlock(weakSelf.userToken,YES);
                                         }
                                         if ([changeToken isEqualToString:weakSelf.userToken]) {
                                             LoginUserInfo *loginCountInfo = [[LoginUserInfo alloc] init];
                                             loginCountInfo.account = weakSelf.account;
                                             loginCountInfo.password = password;
                                             [weakSelf saveLoginUserInfo:loginCountInfo];
                                         }
                                         
                                     }else {
                                         if (weakSelf.changePSCompleteBlock) {
                                             weakSelf.changePSCompleteBlock(remark,YES);
                                         }
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                     if (weakSelf.changePSCompleteBlock) {
                                         weakSelf.changePSCompleteBlock(@"请求异常",NO);
                                     }
                                     NSLog(@"error = %@",error);
                                 }];
}

- (BOOL)isLogin
{
    return _isLogin && _userToken.length;
}

- (NSString *)userToken
{
    return _userToken;
}

-(NSString*) uuid
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


/*
 * 获取本地缓存登录账号和密码
 */
- (LoginUserInfo*)getLoginUserInfo
{
    NSArray *userList = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocalUserList"];
//    NSArray *userList = ditct ? ditct[@"LocalUserList"] : nil;
    if (userList.count) {
        id userCountInfo = [userList lastObject];
        if ([userCountInfo isKindOfClass:[NSDictionary class]]) {
            NSDictionary *tmpDict = (NSDictionary*)userCountInfo;
            LoginUserInfo *userInfo = [[LoginUserInfo alloc] init];
            userInfo.account = [tmpDict objectForKey:@"account"];
            userInfo.password = [tmpDict objectForKey:@"password"];
            return userInfo;
        }
    }
    return nil;
}

- (void)saveLoginUserInfo:(LoginUserInfo*)userInfo
{
    if (userInfo) {
        NSArray *userList = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocalUserList"];
        NSMutableArray *newUserList = [[NSMutableArray alloc] init];
        BOOL isExit = NO;
        for (int i = 0; i < userList.count; i++) {
            NSDictionary *accountInfo = userList[i];
            if ([[accountInfo objectForKey:@"account"] isEqualToString:userInfo.account]) {
                isExit = YES;
            }
            if (!isExit) {
                [newUserList addObject:userList[i]];
            }
        }
        [newUserList addObject:@{@"account":userInfo.account,@"password":userInfo.password}];
        [[NSUserDefaults standardUserDefaults] setObject:newUserList forKey:@"LocalUserList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//
//- (NSString *) md5:(NSString *)str
//{
//      const char *cStr = [str UTF8String];
//   unsigned char result[16];
//     CC_MD5( cStr, strlen(cStr), result );
//    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//                                             result[0], result[1], result[2], result[3],
//                                          result[4], result[5], result[6], result[7],
//                                              result[8], result[9], result[10], result[11],
//                                           result[12], result[13], result[14], result[15]
//                   ];
//    }


@end
