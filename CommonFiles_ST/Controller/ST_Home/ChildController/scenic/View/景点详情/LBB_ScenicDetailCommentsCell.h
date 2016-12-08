//
//  LBB_ScenicDetailCommentsCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SpotDetailsViewModel.h"


@interface LBB_ScenicDetailCommentsCell : LBBPoohBaseTableViewCell

@property(nonatomic,retain)UIImageView* portraitImageView;
@property(nonatomic,retain)UILabel* nickLabel;

@property(nonatomic,retain)UIButton* moreButton;
@property(nonatomic,retain)UILabel* contentLabel;
@property(nonatomic,retain)UIImageView* arrow;

@property(nonatomic,retain)UIImageView* imageView1;
@property(nonatomic,retain)UIImageView* imageView2;
@property(nonatomic,retain)UIImageView* imageView3;

@property(nonatomic,retain)UILabel* timeLabel;

@property(nonatomic, retain)UIButton* commentsView;
@property(nonatomic, retain)UIButton* greetView;
@property(nonatomic, retain)UIView* sep;

@property(nonatomic, retain)UIButton* commentsButton;

@property(nonatomic, strong)NSMutableArray<LBB_SpotsCommentsRecord*> *commentsRecord ;// 评论记录（具体几个后台控制）


@end
