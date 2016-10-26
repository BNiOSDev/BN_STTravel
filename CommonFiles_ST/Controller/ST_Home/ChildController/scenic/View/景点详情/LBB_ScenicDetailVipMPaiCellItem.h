//
//  LBB_ScenicDetailVipMPaiCellItem.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohGreatItemView.h"

#define LBB_ScenicDetailVipMPaiCellMainImageViewHeight AutoSize(268.0/2)
#define LBB_ScenicDetailVipMPaiCellPortraitImageViewHeight AutoSize(30.0)

#define LBB_ScenicDetailVipMPaiCellItemHeight LBB_ScenicDetailVipMPaiCellMainImageViewHeight+LBB_ScenicDetailVipMPaiCellPortraitImageViewHeight/2 + 8


@interface LBB_ScenicDetailVipMPaiCellItem : UICollectionViewCell

@property(nonatomic, retain)UIImageView* mainImageView;
@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* nickNameLabel;

@property(nonatomic, retain)LBBPoohGreatItemView* commentsView;
@property(nonatomic, retain)LBBPoohGreatItemView* greetView;

@property(nonatomic, retain)UIButton* playButton;

@end
