//
//  LBB_GuiderUserFunsListCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SquareViewModel.h"
@interface LBB_GuiderUserFunsListCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* subTitleLabel;
@property(nonatomic, retain)UIButton* rightButton;

//主页搜索页面，类型为用户时使用
@property(nonatomic, retain)UIImageView* vImageView;
@property(nonatomic, retain)UIButton* levelButton;
@property(nonatomic, retain)UILabel* identityLable;//认证


@property(nonatomic, retain)LBB_UserOther* model;
-(void)setModel:(LBB_UserOther*)model isTour:(BOOL)isTour show:(BOOL)isShow;

@end
