//
//  LBB_LoginManager.h
//  ST_Travel
//
//  Created by Diana on 16/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoginBlock)(NSString *userID,BOOL result);
typedef void(^RegisterBlock)(BOOL result);

typedef NS_ENUM(NSInteger,LoginType)
{
    eLoginTelePhone = 1,//手机号码登录
    eLoginQQ,//QQ登录
    eLoginWeChat//微信登录
};

@interface LBB_LoginManager : NSObject

//登录完成回调 返回是否成功和失败信息
@property (nonatomic,copy) LoginBlock loginCompleteBlock;
//注册完成回调，返回是否注册成功
@property (nonatomic,copy) RegisterBlock resgisterCompleteBlock;

/*
 * 获取登录实例
 */
+ (instancetype)shareInstance;

/*
 * 注册
 */
- (void)registered:(LoginType)loginType
     UserHeadImage:(UIImage*)headImage
           Account:(NSString*)account
          Password:(NSString*)password
          CheckNum:(NSString*)checkNum
               Sex:(NSInteger)sex
           Address:(NSString*)address;

/*
 * 登录
 */
- (void)login:(LoginType)loginType
      Account:(NSString*)account
     Password:(NSString*)password;


/*
 * 退出登录
 */
- (void)logout;

/*
 * 判断是否登录
 */
- (BOOL)isLogin;

/*
 * 获取用户ID
 */
- (NSString *)userID;

@end
