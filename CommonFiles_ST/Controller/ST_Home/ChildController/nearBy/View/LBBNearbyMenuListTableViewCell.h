//
//  LBBNearbyMenuListTableViewCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_NearViewModel.h"

@interface LBBNearbyMenuListTableViewCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* subTitleLabel;
@property(nonatomic, retain)UILabel* descLabel;
@property(nonatomic, retain)UIImageView* arrowImageView;

@property(nonatomic, retain)UIView* sep;

@property(nonatomic, retain)LBB_SpotModel* model;

@end
