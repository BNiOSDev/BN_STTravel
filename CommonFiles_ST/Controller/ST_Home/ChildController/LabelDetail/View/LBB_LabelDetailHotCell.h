//
//  LBB_LabelDetailHotCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohBaseTableViewCell.h"
#import "LBB_TagsViewModel.h"

@interface LBB_LabelDetailHotCellItem : UIView

@property(nonatomic,retain)UIImageView* bgImageView;

@property(nonatomic,retain)LBB_TagShowViewData* model;

@end


@interface LBB_LabelDetailHotCell : LBBPoohBaseTableViewCell

@property(nonatomic,retain)LBB_LabelDetailHotCellItem* item1;
@property(nonatomic,retain)LBB_LabelDetailHotCellItem* item2;

@property(nonatomic,retain)LBB_TagShowViewData* model1;
@property(nonatomic,retain)LBB_TagShowViewData* model2;

@end
