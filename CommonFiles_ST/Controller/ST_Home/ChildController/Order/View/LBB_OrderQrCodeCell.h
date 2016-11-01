//
//  LBB_OrderQrCodeCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_OrderQrCodeCell : LBBPoohBaseTableViewCell

@property(nonatomic,retain)UILabel* qrCodeLabel;
@property(nonatomic,retain)UIImageView* qrCodeImageView;
@property(nonatomic,retain)UILabel* payWayLabel;

@property(nonatomic,retain)id model;

@end
