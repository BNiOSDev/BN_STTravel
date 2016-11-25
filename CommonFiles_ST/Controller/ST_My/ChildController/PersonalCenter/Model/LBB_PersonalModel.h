//
//  LBB_PersonalModel.h
//  ST_Travel
//
//  Created by dhxiang on 16/11/23.
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

/**
 3.5.21 我的-个人中心（已测）
 */
- (void)getPersonInfo:(NSString*)userToken;

@end
