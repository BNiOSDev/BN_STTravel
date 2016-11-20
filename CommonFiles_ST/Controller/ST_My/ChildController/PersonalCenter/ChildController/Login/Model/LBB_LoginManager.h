//
//  LBB_LoginManager.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

//userToken 用户token或者 手机号
typedef void(^LoginBlock)(NSString *userToken,BOOL result);


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
@property (nonatomic,copy) LoginBlock resgisterCompleteBlock;
//退出登录回调，返回是否退出成功
@property (nonatomic,copy) LoginBlock logoutCompleteBlock;
//找回密码回调
@property (nonatomic,copy) LoginBlock findPSCompleteBlock;
//设置密码回调
@property (nonatomic,copy) LoginBlock setPSCompleteBlock;

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
           Address:(NSString*)address
     CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock;

/*
 * 登录
 */
- (void)login:(LoginType)loginType
      Account:(NSString*)account
     Password:(NSString*)password
CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock;


/*
 * 退出登录
 */
- (void)logout:(void (^)(NSString *userToken,BOOL result))completeBlock;

/*
 * 获取验证码
 1:注册短信2.服务通知类短信3营销类短信4修改密码5:修改手机号码
 */
- (void)getVerificationCode:(NSString*)phoneNum Type:(int)type;

/*
 * 找回密码
 */
- (void)findPassword:(NSString*)phoneNum
            CheckNum:(NSString*)checkNum
CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock;

/*
 * 找回密码
 */
- (void)setPassword:(NSString*)phoneNum
            Password:(NSString*)password
       CompleteBlock:(void (^)(NSString *userToken,BOOL result))completeBlock;

/*
 * 判断是否登录
 */
- (BOOL)isLogin;

/*
 * 获取用户Token
 */
- (NSString *)userToken;


@end
