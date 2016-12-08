//
//  LBB_ScenicDetailEquipmentCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SpotDetailsViewModel.h"

@interface LBB_ScenicDetailEquipmentCell : LBBPoohBaseTableViewCell

@property(nonatomic, strong)NSMutableArray<LBB_SpotsFacilities*> *facilities ;// 设施

@end
