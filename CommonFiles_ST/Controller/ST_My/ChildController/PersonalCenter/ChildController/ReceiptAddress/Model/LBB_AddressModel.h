//
//  LBB_AddressModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_AddressModel : BN_BaseDataModel

@property(nonatomic,assign) long addressId;//地址主键
@property(nonatomic,copy) NSString *name;//收货人
@property(nonatomic,copy) NSString *phone;//收货手机号
@property(nonatomic,assign) BOOL isDefault;//是否默认
@property(nonatomic,copy) NSString *provinceName;//省份名
@property(nonatomic,assign) long provinceId;//省份ID
@property(nonatomic,copy) NSString *cityName;//城市名
@property(nonatomic,assign) long cityId;//城市ID
@property(nonatomic,copy) NSString *districtName;//县、区名称
@property(nonatomic,assign) long  districtId;//县、区ID
@property(nonatomic,assign) NSString  *address;//地址名称
@property(nonatomic,assign) NSString  *zipcode;//地址名称

/**
 3.5.33 我的-收货地址修改/保存
 */
- (void)updateAddress;

/**
 3.5.34 我的-收货地址设置默认（已测）
 */
- (void)setDefaultAddress;

@end


@interface LBB_AddressViewModel : BN_BaseDataModel

@property(nonatomic,strong) NSMutableArray<LBB_AddressModel *>* addressArray;

/**
 3.5.32 我的-收货地址列表（已测）
 */

- (void)getAddressList:(int)curPage PageNum:(int)pageNum IsClear:(BOOL)isClear;

@end
