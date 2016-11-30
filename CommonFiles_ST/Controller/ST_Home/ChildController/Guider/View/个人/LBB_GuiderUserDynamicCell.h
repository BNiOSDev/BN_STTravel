//
//  LBB_GuiderUserDynamicCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SquareViewModel.h"

@interface LBB_GuiderUserDynamicCellItem : UIView

@property(nonatomic,retain)UIImageView* bgImageView;


@end


@interface LBB_GuiderUserDynamicCell : LBBPoohBaseTableViewCell

@property(nonatomic,retain)LBB_GuiderUserDynamicCellItem* item1;
@property(nonatomic,retain)LBB_GuiderUserDynamicCellItem* item2;

@property(nonatomic,retain)LBB_UserAction* model1;
@property(nonatomic,retain)LBB_UserAction* model2;

@end
