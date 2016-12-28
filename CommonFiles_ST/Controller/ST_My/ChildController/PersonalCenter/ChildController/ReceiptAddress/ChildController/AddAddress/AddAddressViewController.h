//
//  AddAddressViewController.h
//  ST_Travel
//
//  Created by 晨曦 on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "MineBaseViewController.h"
#import "LBB_AddressModel.h"

typedef void(^AddressBlock)(LBB_AddressModel *model);
@interface AddAddressViewController : MineBaseViewController

@property(nonatomic,strong) LBB_AddressModel *addressModel;
@property(nonatomic,strong) AddressBlock completeBlock;

@end
