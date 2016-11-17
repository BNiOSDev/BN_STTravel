//
//  LBB_PoohMyFavoriteSubjectCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_PoohMyFavoriteSubjectCell : LBBPoohBaseTableViewCell


@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UIImageView* bgImageView;
@property(nonatomic, retain)UIButton* favoriteButton;

@property(nonatomic, retain)UILabel* subjectLabel;
@property(nonatomic, retain)UIButton* checkButton;

@property(nonatomic, retain)id model;

@end
