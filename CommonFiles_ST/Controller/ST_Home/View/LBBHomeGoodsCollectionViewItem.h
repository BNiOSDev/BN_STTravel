//
//  LBBHomeGoodsCollectionViewItem.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_HomeViewModel.h"

@interface LBBHomeGoodsCollectionViewItem : UICollectionViewCell
@property(nonatomic, retain)UIImageView* mainImageView;
@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UIButton* disView;
@property(nonatomic, retain)UIButton* greetView;
@property(nonatomic, retain)UILabel* priceLabel;
@property(nonatomic, retain)UIButton* favoriteButton;

@property(nonatomic, retain)BN_HomeHotGoodsObject* model;
@end