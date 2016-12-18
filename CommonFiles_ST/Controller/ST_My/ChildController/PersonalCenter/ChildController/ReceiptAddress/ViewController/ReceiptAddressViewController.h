//
//  ReceiptAddressViewController.h
//  ST_Travel
//
//  Created by 晨曦 on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "MineBaseViewController.h"
#import "LBB_AddressModel.h"

typedef void(^SelectAddressBlock)(LBB_AddressModel *addressModel);

@interface ReceiptAddressViewController : MineBaseViewController

@property(nonatomic,strong) SelectAddressBlock selectBlock;

@end
