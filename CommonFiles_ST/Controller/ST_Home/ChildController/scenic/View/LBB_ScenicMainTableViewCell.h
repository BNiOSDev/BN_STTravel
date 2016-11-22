//
//  LBB_ScenicMainTableViewCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SpotDetailsViewModel.h"
@interface LBB_ScenicMainTableViewCell : LBBPoohBaseTableViewCell


@property(nonatomic, retain)UIImageView* bgImageView;
@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* addressLabel;
@property(nonatomic, retain)UILabel* streetLabel;
@property(nonatomic, retain)UILabel* distanceLabel;

@property(nonatomic, retain)UILabel* priceLabel;
@property(nonatomic, retain)UILabel* deletePriceLabel;

@property(nonatomic, retain)UIButton* favoriteButton;

@property(nonatomic, retain)UIButton* commentsButton;
@property(nonatomic, retain)UIButton* greatButton;

@property(nonatomic, retain)LBB_SpotModel* model;

-(void)showTopSepLine:(BOOL)show;

@end
