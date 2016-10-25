//
//  LBB_ScenicDetailPriceMsgCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohGreatItemView.h"
@interface LBB_ScenicDetailPriceMsgCell : UITableViewCell


@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* priceLabel;

@property(nonatomic, retain)UIButton* signButton;
@property(nonatomic, retain)UILabel* signLabel;

@property(nonatomic, retain)LBBPoohGreatItemView* greatView;
@property(nonatomic, retain)LBBPoohGreatItemView* commentsView;
@property(nonatomic, retain)LBBPoohGreatItemView* favoriteView;


@property(nonatomic, retain)id model;

@end
