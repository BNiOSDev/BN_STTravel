//
//  LBB_AddressAddViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"
#import "LBB_SquareAddressViewModel.h"

@interface LBB_AddressAddViewController : Base_BaseViewController

@property(nonatomic, strong)ClickBlockEx click;

@property(nonatomic, retain)NSArray<LBB_SpotAddress*>* selectedArray;
@end
