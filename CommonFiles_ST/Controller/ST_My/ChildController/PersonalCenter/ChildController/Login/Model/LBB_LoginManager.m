//
//  LBB_LoginManager.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LoginManager.h"

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
                              @"passwd":[self.password stringFromMD5],
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
    self.logoutCompleteBlock = completeBlock;
    
    NSString *deviceID  =  [self uuid];
    //todo 调用登录接口，登录完成后回调登录block
    NSDictionary *paraDic = @{
                              @"phoneNum":self.account,
                              @"passwd":[password stringFromMD5],
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
        weakSelf.isLogin = NO;
        weakSelf.userToken = nil;
        if (weakSelf.logoutCompleteBlock) {
            weakSelf.logoutCompleteBlock(nil,YES);
        }
        NSLog(@"responseObject = %@",responseObject);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        weakSelf.isLogin = NO;
        if (weakSelf.logoutCompleteBlock) {
            weakSelf.logoutCompleteBlock(weakSelf.userToken,NO);
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
                                     weakSelf.isLogin = NO;
//                                     self.account = 
                                     if (weakSelf.findPSCompleteBlock) {
//                                         self.account = 
                                         weakSelf.findPSCompleteBlock(self.account,YES);
                                     }
                                     NSLog(@"responseObject = %@",responseObject);
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                     weakSelf.isLogin = NO;
                                     if (weakSelf.logoutCompleteBlock) {
                                         weakSelf.logoutCompleteBlock(weakSelf.userToken,NO);
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
    self.password = [password stringFromMD5];
    self.setPSCompleteBlock = completeBlock;
    NSDictionary *paraDic = @{
                              @"phoneNum":self.account,
                              @"verifyCode":self.checkNum
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/mime/password/setting",BASEURL];
    __weak typeof(self) weakSelf = self;
    
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
                                     weakSelf.isLogin = NO;
                                     if (weakSelf.setPSCompleteBlock) {
                                         //正确返回token
                                         weakSelf.setPSCompleteBlock(weakSelf.userToken,YES);
                                     }
                                     NSLog(@"responseObject = %@",responseObject);
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                     weakSelf.isLogin = NO;
                                     if (weakSelf.logoutCompleteBlock) {
                                         weakSelf.logoutCompleteBlock(weakSelf.userToken,NO);
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
            [newUserList addObject:userList[i]];
        }
        if (!isExit) {
            [newUserList addObject:@{@"account":userInfo.account,@"password":userInfo.password}];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newUserList forKey:@"LocalUserList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
