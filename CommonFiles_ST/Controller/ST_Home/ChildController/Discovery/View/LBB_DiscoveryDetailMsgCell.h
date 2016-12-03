//
//  LBB_DiscoveryDetailInfoCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_DiscoveryViewModel.h"

@interface LBB_DiscoveryDetailMsgCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* timeLabel;

@property(nonatomic, retain)UIButton* greatButton;
@property(nonatomic, retain)UIButton* commentsButton;
@property(nonatomic, retain)UIButton* favoriteButton;

@property(nonatomic, retain)UIButton* scenicButton;
@property(nonatomic, retain)UIButton* foodsButton;
@property(nonatomic, retain)UIButton* hostelButton;


@property(nonatomic, retain)LBB_DiscoveryDetailModel* model;


@end
