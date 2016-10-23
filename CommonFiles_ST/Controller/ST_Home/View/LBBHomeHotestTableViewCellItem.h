//
//  LBBHomeHotestTableViewCellItem.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohGreatItemView.h"

@interface LBBHomeHotestTableViewCellItem : UICollectionViewCell

@property(nonatomic, retain)UIImageView* mainImageView;
@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)LBBPoohGreatItemView* disView;
@property(nonatomic, retain)LBBPoohGreatItemView* greetView;
@property(nonatomic, retain)UILabel* priceLabel;
@property(nonatomic, retain)UIButton* favoriteButton;

@end
