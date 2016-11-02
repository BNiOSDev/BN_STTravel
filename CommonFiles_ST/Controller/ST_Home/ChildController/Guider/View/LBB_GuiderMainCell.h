//
//  LBB_GuiderMainCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_GuiderMainCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* nameLabel;
@property(nonatomic, retain)UIImageView* vImageView;//加V
@property(nonatomic, retain)UIImageView* genderImageView;//性别

@property(nonatomic, retain)UIButton* favoriteButton;
@property(nonatomic, retain)UILabel* favoriteLabel;//关注
@property(nonatomic, retain)UILabel* funsLabel;//粉丝
@property(nonatomic, retain)UILabel* dynamicLabel;//动态

@property(nonatomic, retain)UILabel* identityLable;//认证
@property(nonatomic, retain)UILabel* signLable;//签名

@property(nonatomic, retain)UIButton* labelButton1;//标签1
@property(nonatomic, retain)UIButton* labelButton2;//标签1
@property(nonatomic, retain)UIButton* labelButton3;//标签1

@property(nonatomic, retain)id model;

@end
