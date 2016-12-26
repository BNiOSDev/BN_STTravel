//
//  LBBHomeTravelRecommendTableViewCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_HomeViewModel.h"
@interface LBBHomeTravelRecommendTableViewCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UIImageView* bgImageView;
@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* userLable;
@property(nonatomic, retain)UILabel* travlTitleLable;
@property(nonatomic, retain)UIButton* commentsView;
@property(nonatomic, retain)UIButton* greetView;
@property(nonatomic, retain)UIButton* favoriteButton;


@property(nonatomic, retain)BN_HomeTravelNotes* model;

@end
