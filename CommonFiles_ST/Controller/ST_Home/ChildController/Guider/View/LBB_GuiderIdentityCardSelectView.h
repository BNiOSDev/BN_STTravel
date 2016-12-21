//
//  LBB_GuiderIdentityCardSelectView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_GuiderApplyTextField.h"

@interface LBB_GuiderIdentityCardSelectView : UIView

@property(nonatomic, retain)UILabel* titleLable;
@property(nonatomic, retain)UILabel* mark;

@property(nonatomic, retain)UILabel* placeHolderLabel;
@property(nonatomic, retain)UIImageView* selectImageView;
@property(nonatomic, retain)UIButton* addButton;

-(void)hiddenMarkView:(BOOL)hidden;

-(void)hiddenTitleView:(BOOL)hidden;

-(void)setAddButtonBgImage:(UIImage*)image;

@end
