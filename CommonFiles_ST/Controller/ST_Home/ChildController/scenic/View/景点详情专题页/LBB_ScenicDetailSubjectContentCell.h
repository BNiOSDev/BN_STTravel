//
//  LBB_ScenicDetailSubjectContentCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBBPoohGreatItemView.h"

@interface LBB_ScenicDetailSubjectContentCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* subTitleLabel;

@property(nonatomic, retain)LBBPoohGreatItemView* greatView;
@property(nonatomic, retain)LBBPoohGreatItemView* commentsView;
@property(nonatomic, retain)LBBPoohGreatItemView* favoriteView;

@property(nonatomic, retain)UIImageView* imageView1;
@property(nonatomic, retain)UIImageView* imageView2;
@property(nonatomic, retain)UILabel* contentLabel;

@property(nonatomic, retain)UIButton* moreButton;
@property(nonatomic, retain)UIView* sepLineView;

@property(nonatomic, retain)id model;

@end
