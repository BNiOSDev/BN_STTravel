//
//  LBB_HomeSearchGoodsCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_HomeSearchGoodsCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UIImageView* goodImageView;
@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* weightLable;

@property(nonatomic, retain)UILabel* priceLabel;
@property(nonatomic, retain)UILabel* originalPriceLabel;
@property(nonatomic, retain)UILabel* evaluateLabel;

@property(nonatomic, retain)id model;

@end
