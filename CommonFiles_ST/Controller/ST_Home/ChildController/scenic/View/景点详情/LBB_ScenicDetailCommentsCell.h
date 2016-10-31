//
//  LBB_ScenicDetailCommentsCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBBPoohGreatItemView.h"
@interface LBB_ScenicDetailCommentsCell : LBBPoohBaseTableViewCell

@property(nonatomic,retain)UIImageView* portraitImageView;
@property(nonatomic,retain)UILabel* nickLabel;

@property(nonatomic,retain)UIButton* moreButton;
@property(nonatomic,retain)UILabel* contentLabel;

@property(nonatomic,retain)UIImageView* imageView1;
@property(nonatomic,retain)UIImageView* imageView2;
@property(nonatomic,retain)UIImageView* imageView3;

@property(nonatomic,retain)UILabel* timeLabel;

@property(nonatomic, retain)LBBPoohGreatItemView* commentsView;
@property(nonatomic, retain)LBBPoohGreatItemView* greetView;

@property(nonatomic, retain)UIButton* commentsButton;

@end
