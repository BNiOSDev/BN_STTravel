//
//  LBB_GuiderUserMsgCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_GuiderUserDeatilMsgCell : LBBPoohBaseTableViewCell


@property(nonatomic, retain)UIImageView* iconImageView;
@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UITextField* textField;

@property(nonatomic, retain)UIButton* rightButton;
@property(nonatomic, retain)UIView* sepLineTop;
@property(nonatomic, retain)UIView* sepLineBottom;
@property(nonatomic, retain)UILabel* detailLabel;

@property(nonatomic, retain)NSString* detailString;

@property(nonatomic, retain)id model;

@property(nonatomic, assign)BOOL isOpen;

@end
