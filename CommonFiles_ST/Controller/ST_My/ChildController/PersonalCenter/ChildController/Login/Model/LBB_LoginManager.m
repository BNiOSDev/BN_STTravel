//
//  LBB_LoginManager.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LoginManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "SPKitExample.h"

#define WeiXinAPPID         @"wx94b0ac5b1ba8e1c3"
#define WeiXinAppsecret     @"1ef86c4ca4dcbe00b93064c4186bda4b"

static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";

@implementation LoginUserInfo


@end


@interface LBB_LoginManager()<TencentSessionDelegate>

@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *checkNum;
@property(nonatomic,copy) NSString *userToken;
@property(nonatomic,copy) NSString *address;
@property(nonatomic,assign) NSInteger sex;
@property(nonatomic,assign) BOOL isLogin;
@property(nonatomic,strong) UIImage *userHeadImage;
@property(nonatomic,strong) TencentOAuth* oauth;

@end

@implementation LBB_LoginManager

@synthesize  userToken = _userToken;

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
 * 3.5.18 我的-正常登录（已测）
 */
- (void)login:(LoginType)loginType
      Account:(NSString*)account
     Password:(NSString*)password
CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock
{
    self.account = account;
    self.password = password;
    self.loginType = eLoginTelePhone;
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
         if (code == 0) {
             NSDictionary *result = [dict objectForKey:@"result"];
             if (result && [result isKindOfClass:[NSDictionary class]]) {
                  weakSelf.userToken = [result objectForKey:@"token"];
                 NSString *chatId  = [result objectForKey:@"chatId"];
                 [[SPKitExample sharedInstance] exampleLoginWithUserID:chatId password:chatId successBlock:^{
                     NSLog(@"百川登录成功");
                 } failedBlock:^(NSError *error){
                 }];
             }
             [BC_ToolRequest sharedManager].token = weakSelf.userToken;
             if (weakSelf.loginCompleteBlock) {
                 weakSelf.loginCompleteBlock(weakSelf.userToken,YES);
                 weakSelf.loginCompleteBlock = nil;
             }
             if (weakSelf.loginType == eLoginTelePhone) {
                 LoginUserInfo *loginCountInfo = [[LoginUserInfo alloc] init];
                 loginCountInfo.account = weakSelf.account;
                 loginCountInfo.password = weakSelf.password;
                 [weakSelf saveLoginUserInfo:loginCountInfo];
             }
            
         }else{
             if (weakSelf.loginCompleteBlock) {
                 weakSelf.loginCompleteBlock(remark,NO);
                 weakSelf.loginCompleteBlock = nil;
             }
         }

    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        weakSelf.isLogin = NO;
        NSLog(@"error = %@",error);
        if (weakSelf.loginCompleteBlock) {
            weakSelf.loginCompleteBlock(weakSelf.userToken,YES);
            weakSelf.loginCompleteBlock = nil;
        }
    }];
}

/*
 * 3.5.19 我的-第三方登录（已测）
 *@parames thirdType 1 微信 2 QQ
 */
- (BOOL)loginWithThirdParty:(int)thirdType
             ViewController:(UIViewController*)vc
              CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock
{
    self.loginType = thirdType;
    BOOL isSuccess = NO;
    
    self.loginCompleteBlock = completeBlock;
    
    if(self.loginType == eLoginWeChat){
        if (![WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还未安装微信app,或者版本不支持" message:@"是否马上去下载更新微信?" delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"去下载", nil];
            alertView.tag = 1;
            [alertView show];
      
            return isSuccess;
        }
        
        SendAuthReq* req = [[SendAuthReq alloc] init];
        req.scope = kAuthScope;
        isSuccess = [WXApi sendAuthReq:req
                             viewController:vc
                                   delegate:self];
    }else if(self.loginType == eLoginQQ){
        if (![TencentOAuth iphoneQQInstalled]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还未安装QQapp,或者版本不支持" message:@"是否马上去下载更新微信?" delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"去下载", nil];
            
            alertView.tag = 2;
            [alertView show];
            return isSuccess;
        }
        
        [self loginWithQQ];
    }
   
    return isSuccess;
}

- (void)thirdPartyLogin:(NSString*)openID username:(NSString*)username userPicUrl:(NSString*)userPicUrl
{
    NSString *deviceID  =  [self uuid];
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [paraDic setObject:@(self.loginType) forKey:@"thirdType"];
    [paraDic setObject:openID forKey:@"openId"];
    [paraDic setObject:@(2) forKey:@"deviceSystemType"];
    [paraDic setObject:deviceID forKey:@"deviceId"];
    if ([userPicUrl length]) {
        [paraDic setObject:userPicUrl forKey:@"userPicUrl"];
    }
    if ([username length]) {
        [paraDic setObject:username forKey:@"username"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/mime/third/login",BASEURL];
    __weak typeof(self) weakSelf = self;
    
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
                                     NSDictionary *dict = (NSDictionary*)responseObject;
                                     NSLog(@"responseObject = %@",dict);
                                     int code = [[dict objectForKey:@"code"] intValue];
                                     NSString *remark = [dict objectForKey:@"remark"];
                                     if (code == 0) {
                                         NSDictionary *result = [dict objectForKey:@"result"];
                                         if (result && [result isKindOfClass:[NSDictionary class]]) {
                                             weakSelf.userToken = [result objectForKey:@"token"];
                                             NSString *chatId  = [result objectForKey:@"chatId"];
                                             [[SPKitExample sharedInstance] exampleLoginWithUserID:chatId password:chatId successBlock:^{
                                                 NSLog(@"百川登录成功");
                                             } failedBlock:^(NSError *error){
                                             }];
                                         }
                                         [BC_ToolRequest sharedManager].token = weakSelf.userToken;
                                         if (weakSelf.loginCompleteBlock) {
                                             weakSelf.loginCompleteBlock(weakSelf.userToken,YES);
                                             weakSelf.loginCompleteBlock = nil;
                                         }
                                     }else{
                                         if (weakSelf.loginCompleteBlock) {
                                             weakSelf.loginCompleteBlock(weakSelf.userToken,NO);
                                             weakSelf.loginCompleteBlock = nil;
                                         }
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                      NSLog(@"error = %@",error);
                                     if (weakSelf.loginCompleteBlock) {
                                         weakSelf.loginCompleteBlock(weakSelf.userToken,NO);
                                         weakSelf.loginCompleteBlock = nil;
                                     }
                                 }];
}

- (void)weiXinRegisterApp
{
    [WXApi registerApp:@"wx94b0ac5b1ba8e1c3" withDescription:@"demo 2.0"];
    
//  [WXApi registerApp:WeiXinAPPID];
}
/*
 * 3.5.20 我的-注册（已测）
 */
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
                                     if (code == 0) {
                                         NSDictionary *result = [dict objectForKey:@"result"];
                                         if (result && [result isKindOfClass:[NSDictionary class]]) {
                                             weakSelf.userToken = [result objectForKey:@"token"];
                                             weakSelf.resgisterCompleteBlock(weakSelf.userToken,YES);
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

/*
 * 3.5.21 我的-退出登录（已测）
 */
- (void)logout:(void (^)(NSString *userToken,BOOL result))completeBlock;
{
    self.logoutCompleteBlock = completeBlock;
    
    NSDictionary *paraDic = nil;
    
    if (self.userToken && [self.userToken length]) {
        paraDic = @{
                    @"Token":self.userToken
                    };
    }
    
    [self.oauth logout:self];
    
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
             [BC_ToolRequest sharedManager].token = nil;
             if (weakSelf.logoutCompleteBlock) {
                 weakSelf.logoutCompleteBlock(nil,YES);
                 weakSelf.logoutCompleteBlock = nil;
             }
         }else {
             if (weakSelf.logoutCompleteBlock) {
                 weakSelf.logoutCompleteBlock(remark,YES);
                 weakSelf.logoutCompleteBlock = nil;
             }
         }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        weakSelf.isLogin = NO;
        if (weakSelf.logoutCompleteBlock) {
            weakSelf.logoutCompleteBlock(@"请求异常",NO);
            weakSelf.logoutCompleteBlock = nil;
        }
        NSLog(@"error = %@",error);
    }];
}

/*
 *3.5.22 我的-找回密码（已测）
 */
- (void)findPassword:(NSString*)phoneNum
            CheckNum:(NSString*)checkNum
            Password:(NSString*)password
       CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock
{
    self.account = phoneNum;
    self.checkNum = checkNum;
    self.password = password;
    self.findPSCompleteBlock = completeBlock;
    NSDictionary *paraDic = @{
                              @"phoneNum":self.account,
                              @"verifyCode":self.checkNum,
                              @"passwd":self.password
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/mime/passwd/retrieve",BASEURL];
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
                                             weakSelf.findPSCompleteBlock = nil;
                                         }
                                         LoginUserInfo *loginCountInfo = [[LoginUserInfo alloc] init];
                                         loginCountInfo.account = weakSelf.account;
                                         loginCountInfo.password = weakSelf.password;
                                         [weakSelf saveLoginUserInfo:loginCountInfo];
                                     }else {
                                         if (weakSelf.findPSCompleteBlock) {
                                             weakSelf.findPSCompleteBlock(remark,NO);
                                             weakSelf.findPSCompleteBlock = nil;
                                         }
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                     if (weakSelf.findPSCompleteBlock) {
                                         weakSelf.findPSCompleteBlock(@"请求异常",NO);
                                         weakSelf.findPSCompleteBlock = nil;
                                     }
                                     NSLog(@"error = %@",error);
                                 }];
}

/*
 *3.5.36 我的-密码修改（已测）
 */
- (void)changePassword:(NSString*)oldPasswd
           NewPassword:(NSString*)newPasswd
         CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock
{
    self.changePSCompleteBlock = completeBlock;
    NSDictionary *paraDic = @{
                              @"oldPasswd":oldPasswd,
                              @"newPasswd":newPasswd
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/mime/passwd/update",BASEURL];
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
                                             weakSelf.changePSCompleteBlock = nil;
                                         }
  
                                     }else {
                                         if (weakSelf.changePSCompleteBlock) {
                                             weakSelf.changePSCompleteBlock(remark,YES);
                                             weakSelf.changePSCompleteBlock = nil;
                                         }
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                     if (weakSelf.changePSCompleteBlock) {
                                         weakSelf.changePSCompleteBlock(@"请求异常",NO);
                                         weakSelf.changePSCompleteBlock = nil;
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
    if (!_userToken) {
        _userToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"Login_UserToken"];
    }
    return _userToken;
}

- (void)setUserToken:(NSString *)userToken
{
    _userToken = userToken;
    if (!_userToken && [userToken length]) {
        [[NSUserDefaults standardUserDefaults] setObject:_userToken forKey:@"Login_UserToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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

#pragma mark - QQ登录
- (TencentOAuth*)oauth
{
    //注意： 初始化授权 开发者需要在这里填入自己申请到的 AppID
    if (!_oauth) {
      _oauth = [[TencentOAuth alloc] initWithAppId:@"1105843602" andDelegate:self];
    }
    return _oauth;
}

- (void)loginWithQQ
{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    
    [self.oauth authorize:permissions inSafari:NO];
}
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin
{
    NSLog(@"tencentDidLogin");
    [self.oauth getUserInfo];
}
/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请检查下是否网络原因等" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
    
    alertView.tag = 3;
    [alertView show];
}

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog(@"response =%@",response);
    NSString *openid = _oauth.openId;
    NSDictionary *dict = response.jsonResponse;
    NSString *nickname = @"";
    NSString *headimgurl = @"";
    if (dict) {
        nickname = [dict objectForKey:@"nickname"];
        headimgurl = [dict objectForKey:@"figureurl_qq_2"];
    }
    
    [self thirdPartyLogin:openid username:nickname userPicUrl:headimgurl];
}
/**
 * 退出登录的回调
 */
- (void)tencentDidLogout
{
   NSLog(@"tencentDidLogout");
}
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController
{
    NSLog(@"tencentOAuth");
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

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *authResp = (SendAuthResp *)resp;
        if (authResp.code && [authResp.code length]) {
             [self getWeiXinOpenID:authResp.code];
        }
    }
}
-(void) onReq:(BaseReq*)req
{
    NSLog(@"adfa");
}
- (void)getWeiXinOpenID:(NSString*)code
{
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WeiXinAPPID,WeiXinAppsecret,code];
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:nil
                                 success:^(NSURLSessionDataTask *operation, id responseObject){
                                     NSDictionary *dict = (NSDictionary*)responseObject;
                                     NSLog(@"responseObject = %@",dict);
                                     
//                                     NSString *expires_in = [dict objectForKey:@"expires_in"];
//                                     NSString *refresh_token = [dict objectForKey:@"refresh_token"];
//                                     NSString *scope = [dict objectForKey:@"scope"];
//                                     NSNumber *errcode = [dict objectForKey:@"errcode"];
                                     NSString *access_token = [dict objectForKey:@"access_token"];
                                     NSString *openid = [dict objectForKey:@"openid"];
                                     if([openid length] && [access_token length] ){
                                         [weakSelf getWeiXinUserInfo:access_token OpenID:openid];
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                     
                                     NSLog(@"error = %@",error);
                                 }];
}

- (void)getWeiXinUserInfo:(NSString*)accessToken OpenID:(NSString*)openID
{
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openID];
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:nil
                                success:^(NSURLSessionDataTask *operation, id responseObject){
                                    NSDictionary *dict = (NSDictionary*)responseObject;
                                    NSLog(@"responseObject = %@",dict);
                                    NSNumber *errcode = [dict objectForKey:@"errcode"];
                                    NSString *openid = [dict objectForKey:@"openid"];
                                    NSString *nickName = [dict objectForKey:@"nickname"];
                                    NSString *headimgurl = [dict objectForKey:@"headimgurl"];
                                    
                                    if(openid && [openid length]){
                                        [weakSelf thirdPartyLogin:openid username:nickName userPicUrl:headimgurl];
                                    }
                                    
                                } failure:^(NSURLSessionDataTask *operation, NSError *error){
                                    
                                    NSLog(@"error = %@",error);
                                }];
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = %ld",buttonIndex);
    if (buttonIndex == 1 && self.loginType == eLoginWeChat) {//去下载微信
        NSString *weixinURL = [WXApi getWXAppInstallUrl];
        if (weixinURL) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weixinURL]];
        }
    }
}



@end
