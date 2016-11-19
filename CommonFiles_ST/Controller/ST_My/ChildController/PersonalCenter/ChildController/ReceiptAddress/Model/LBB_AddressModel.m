//
//  LBB_AddressModel.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AddressModel.h"

@implementation LBB_AddressModel

@end

@implementation LBB_AddressDataModel

 
- (NSMutableArray<LBB_AddressModel*>*)getData
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        LBB_AddressModel *model = [[LBB_AddressModel alloc] init];
        model.addressId = [NSString stringWithFormat:@"%@",@(i)];
        model.userName = @"王大锤";
        model.phoneNum = @"186****9876";
        model.adress = @"福建省 厦门市 思明区";
        model.street = @"软件园望海路59号楼1号楼鑫海科技";
        model.isDefault = (i == 0) ? YES: NO;
        [array addObject:model];
    }
    return array;
}

@end
