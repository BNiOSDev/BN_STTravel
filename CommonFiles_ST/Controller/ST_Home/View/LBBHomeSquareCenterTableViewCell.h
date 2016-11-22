//
//  LBBHomeSquareCenterTableViewCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_HomeViewModel.h"

@interface LBBHomeSquareCenterTableViewCellItem : UIControl

@property(nonatomic, retain)UIImageView* bgImageView;
@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* userLable;
@property(nonatomic, retain)UIButton* commentsView;
@property(nonatomic, retain)UIButton* greetView;
@property(nonatomic, retain)UIButton* favoriteButton;

@property(nonatomic, retain)UIButton* videoButton;

@end


@interface LBBHomeSquareCenterTableViewCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)LBBHomeSquareCenterTableViewCellItem* item1;
@property(nonatomic, retain)LBBHomeSquareCenterTableViewCellItem* item2;
@property(nonatomic, retain)UIView* sep;

@property(nonatomic, retain)BN_HomeUgcList* model1;
@property(nonatomic, retain)BN_HomeUgcList* model2;


@end
