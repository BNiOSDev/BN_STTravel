//
//  LBB_LoginManager.m
//  ST_Travel
//
//  Created by Diana on 16/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LoginManager.h"

@interface LBB_LoginManager()

@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *userID;
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
               Sex:(NSInteger)sex
           Address:(NSString*)address
{
    self.userHeadImage = headImage;
    self.account = account;
    self.password = password;
    self.loginType = loginType;
    self.sex = sex;
    if (address) {
        self.address = address;
    }
    //todo 调用注册接口
    if (self.resgisterCompleteBlock) {
        self.resgisterCompleteBlock(YES);
    }
}

- (void)login:(LoginType)loginType
      Account:(NSString*)account
     Password:(NSString*)password
{
    self.account = account;
    self.password = password;
    self.loginType = loginType;
    
    //todo 调用登录接口，登录完成后回调登录block
    
    self.isLogin = YES;
    if (self.loginCompleteBlock) {
        self.loginCompleteBlock(nil,YES);
    }
}

- (void)logout
{
    self.isLogin = NO;
}

- (BOOL)isLogin
{
    return _isLogin;
}

- (NSString *)userID
{
    return _userID;
}

@end
