//
//  LBB_LabelDetailHotCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohBaseTableViewCell.h"

@interface LBB_LabelDetailHotCellItem : UIView

@property(nonatomic,retain)UIImageView* bgImageView;
@property(nonatomic,retain)UIButton* labelButton;

@end


@interface LBB_LabelDetailHotCell : LBBPoohBaseTableViewCell

@property(nonatomic,retain)LBB_LabelDetailHotCellItem* item1;
@property(nonatomic,retain)LBB_LabelDetailHotCellItem* item2;

@property(nonatomic,retain)id model;

@end
