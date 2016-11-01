//
//  LBB_DiscoveryDetailInfoCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBBPoohGreatItemView.h"
@interface LBB_DiscoveryDetailMsgCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* timeLabel;

@property(nonatomic, retain)LBBPoohGreatItemView* greatView;
@property(nonatomic, retain)LBBPoohGreatItemView* commentsView;
@property(nonatomic, retain)LBBPoohGreatItemView* favoriteView;

@property(nonatomic, retain)UIButton* scenicButton;
@property(nonatomic, retain)UIButton* foodsButton;
@property(nonatomic, retain)UIButton* hostelButton;


@property(nonatomic, retain)id model;


@end
