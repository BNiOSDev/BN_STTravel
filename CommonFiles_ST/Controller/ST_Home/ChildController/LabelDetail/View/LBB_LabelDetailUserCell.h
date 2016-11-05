//
//  LBB_LabelDetailUserCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_LabelDetailUserCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UIImageView* vipImageView;

@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* subTitleLabel;

@property(nonatomic, retain)UIImageView* rightImageView1;
@property(nonatomic, retain)UIImageView* rightImageView2;
@property(nonatomic, retain)UIImageView* rightImageView3;

@property(nonatomic,retain)id model;


@end
