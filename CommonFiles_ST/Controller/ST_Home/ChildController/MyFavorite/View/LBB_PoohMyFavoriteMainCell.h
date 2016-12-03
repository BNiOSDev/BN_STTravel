//
//  LBB_PoohMyFavoriteMainCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_PoohMyFavoriteViewModel.h"

@interface LBB_PoohMyFavoriteMainCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UIImageView* bgImageView;
@property(nonatomic, retain)UIButton* favoriteButton;
@property(nonatomic, retain)UILabel* addressLabel;
@property(nonatomic, retain)UILabel* priceTitleLabel;
@property(nonatomic, retain)UILabel* priceLabel;

@property(nonatomic, retain)LBB_PoohMyFavoriteModel* model;

@end
