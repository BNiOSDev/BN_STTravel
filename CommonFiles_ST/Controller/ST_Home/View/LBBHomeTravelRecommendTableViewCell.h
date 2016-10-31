//
//  LBBHomeTravelRecommendTableViewCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBBPoohGreatItemView.h"

@interface LBBHomeTravelRecommendTableViewCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UIImageView* bgImageView;
@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* userLable;
@property(nonatomic, retain)UILabel* travlTitleLable;
@property(nonatomic, retain)LBBPoohGreatItemView* commentsView;
@property(nonatomic, retain)LBBPoohGreatItemView* greetView;
@property(nonatomic, retain)UIButton* favoriteButton;

@property(nonatomic, retain)UIButton* specialLabelButton1;
@property(nonatomic, retain)UIButton* specialLabelButton2;
@property(nonatomic, retain)UIButton* specialLabelButton3;
@property(nonatomic, retain)UIButton* specialLabelButton4;
@property(nonatomic, retain)UIButton* specialLabelButton5;
@property(nonatomic, retain)UIButton* specialLabelButton6;

@property(nonatomic, retain)id model;
+(CGFloat)getCellHeight;

@end
