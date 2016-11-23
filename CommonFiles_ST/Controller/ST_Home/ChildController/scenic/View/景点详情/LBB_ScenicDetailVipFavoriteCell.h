//
//  LBB_ScenicDetailVipFavoriteCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SpotDetailsViewModel.h"
@interface LBB_ScenicDetailVipFavoriteCell : LBBPoohBaseTableViewCell

@property(nonatomic,retain)UILabel* titleLable;

@property(nonatomic,retain)UIButton* addButton;

@property(nonatomic,retain)UIImageView* favoriteImageView1;
@property(nonatomic,retain)UIImageView* favoriteImageView2;
@property(nonatomic,retain)UIImageView* favoriteImageView3;
@property(nonatomic,retain)UIImageView* favoriteImageView4;
@property(nonatomic,retain)UIImageView* favoriteImageView5;
@property(nonatomic,retain)UIImageView* favoriteImageView6;

@property(nonatomic, strong)NSMutableArray<LBB_SpotsCollectedRecord*> *collectedRecord ;// 收藏记录（具体几个后台控制）

@end
