//
//  LBB_GuiderUserHeaderCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_GuiderUserHeaderCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UIImageView* bgImageView;
@property(nonatomic, retain)UIButton* privateLetterButton;//私信
@property(nonatomic, retain)UIButton* favoriteButton;//关注

@property(nonatomic, retain)UIButton* labelButton1;//标签1
@property(nonatomic, retain)UIButton* labelButton2;//标签2

@property(nonatomic, retain)UILabel* locationLabel;//地点
@property(nonatomic, retain)UILabel* photoNumLabel;//几张照片

@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* nameLabel;

@property(nonatomic, retain)UIImageView* vImageView;
@property(nonatomic, retain)UIButton* levelButton;

@property(nonatomic, retain)UIButton* greatButton;

@property(nonatomic, retain)id model;



@end
