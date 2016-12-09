//
//  LBB_ScenicDetailTravelRecommendCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SpotDetailsViewModel.h"

@interface LBB_ScenicDetailTravelRecommendCell : LBBPoohBaseTableViewCell

@property(nonatomic,retain)UIImageView* mainImageView;
@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)UILabel* addressLabel;
@property(nonatomic,retain)UILabel* priceLable;
@property(nonatomic,retain)UIButton* styleButton;

@property(nonatomic,retain)LBB_SpotsNearbyRecommendData* model;

@property(nonatomic,retain)LBB_SpotSpecialRecommendSpecials* specialsModel;


@end
