//
//  LLBB_ScenicDetailVipMPaiCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_ScenicDetailVipMPaiCellItem.h"
#import "LBB_SpotDetailsViewModel.h"

@interface LBB_ScenicDetailVipMPaiCell : LBBPoohBaseTableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong)NSMutableArray<LBB_SpotsUgc*> *ugc ;// 视频记录


@end
