//
//  LBB_PersonalModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_PersonalModel : BN_BaseDataModel

@property(nonatomic,copy) NSString *userPicUrl;//用户头像
@property(nonatomic,copy) NSString *coverImageUrl;//封面地址
@property(nonatomic,copy) NSString *userName;//用户名
@property(nonatomic,copy) NSString *signature;//签名
@property(nonatomic,copy) NSString *phoneNum;//手机号
@property(nonatomic,assign) int  gender;//0女  1男  2未知（保密)
@property(nonatomic,copy) NSString *birthDate;//出生日期
@property(nonatomic,assign) long provId;//省份ID
@property(nonatomic,assign) long cityId;//城市ID
@property(nonatomic,copy) NSString *area;//地址区域名称
@property(nonatomic,copy) NSString *address;//地址
@property(nonatomic,assign) int  isUpdatePasswd;//0不可修改 1可修改

/**
 3.5.21 我的-个人中心（已测）
 */
- (void)getPersonInfo;

/**
3.5.22 我的-头像修改 （已测）
 */
- (void)updateUserPicture:(NSString*)imageUrl;

/**
 3.5.23 我的-用户名修改（已测）
 */
- (void)updateUserName:(NSString*)userName;

/**
  3.5.24 我的-签名修改 （已测)
 */
- (void)updateSignature:(NSString*)signature;

/**
3.5.25 我的-手机号修改（已测)
 */
- (void)updatePhoneNum:(NSString*)phoneNum VerifyCode:(NSString*)verifyCode;

/**
  3.5.26 我的-性别修改（已测）
 */
- (void)updateGender:(int)gender;

/**
 3.5.27 我的-出生日期修改（已测）
 */
- (void)updateBirthDate:(NSString*)birthDate;

/**
 3.5.28 我的-地区修改（已测）
 */
- (void)updateArea:(int)provinceId CityId:(int)cityId;

@end
