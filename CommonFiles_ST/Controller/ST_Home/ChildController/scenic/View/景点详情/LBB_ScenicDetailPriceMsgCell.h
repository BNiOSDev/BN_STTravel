//
//  LBB_ScenicDetailPriceMsgCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SpotDetailsViewModel.h"
@interface LBB_ScenicDetailPriceMsgCell : LBBPoohBaseTableViewCell


@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* priceLabel;

@property(nonatomic, retain)UIButton* signButton;
@property(nonatomic, retain)UILabel* signLabel;

@property(nonatomic, retain)UIButton* greatView;
@property(nonatomic, retain)UIButton* commentsView;
@property(nonatomic, retain)UIButton* favoriteView;


@property(nonatomic, retain)LBB_SpotDetailsViewModel* model;

@end
