//
//  LBB_SignInListCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohBaseTableViewCell.h"
@interface LBB_SignInListCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UIImageView* portraitImageView;
@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* subTitleLabel;
@property(nonatomic, retain)UIButton* signinButton;
@property(nonatomic, retain)UILabel* rankLabel;
@property(nonatomic, retain)UIImageView* rankImageView;
@property(nonatomic, retain)UIView* sep;

@property(nonatomic, retain)id model;

-(void)showSigninButton:(BOOL)show;


@end
