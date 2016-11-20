//
//  LBB_AddressModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_AddressModel : NSObject

@property(nonatomic,copy) NSString *addressId; //地址唯一ID
@property(nonatomic,copy) NSString *userName;//用户名
@property(nonatomic,copy) NSString *phoneNum;//手机号码
@property(nonatomic,copy) NSString *adress;//省份市区
@property(nonatomic,copy) NSString *street;//街道地址
@property(nonatomic,assign) BOOL isDefault;//默认地址

@end

@interface LBB_AddressDataModel : NSObject

- (NSMutableArray<LBB_AddressModel*>*)getData;

@end
