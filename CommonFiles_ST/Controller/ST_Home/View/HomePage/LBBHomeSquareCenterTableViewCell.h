//
//  LBBHomeSquareCenterTableViewCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBBPoohGreatItemView.h"


@interface LBBHomeSquareCenterTableViewCellItem : UIControl

@property(nonatomic, retain)UIImageView* bgImageView;
@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* userLable;
@property(nonatomic, retain)LBBPoohGreatItemView* commentsView;
@property(nonatomic, retain)LBBPoohGreatItemView* greetView;
@property(nonatomic, retain)UIButton* favoriteButton;

@property(nonatomic, retain)UIButton* videoButton;

@end


@interface LBBHomeSquareCenterTableViewCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)LBBHomeSquareCenterTableViewCellItem* item1;
@property(nonatomic, retain)LBBHomeSquareCenterTableViewCellItem* item2;
@property(nonatomic, retain)UIView* sep;

@property(nonatomic, retain)id model;


@end
