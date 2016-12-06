//
//  LBB_LabelDetailHeaderView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_TagsViewModel.h"

@interface LBB_LabelDetailHeaderView : UIView

@property(nonatomic,retain)UIImageView* portraitImageView;
@property(nonatomic,retain)UIImageView* bgImageView;

@property(nonatomic,retain)UILabel* typeLabel;
@property(nonatomic,retain)UILabel* numLabel;

@property(nonatomic,retain)UIButton* labelButton1;
@property(nonatomic,retain)UIButton* labelButton2;
@property(nonatomic,retain)UIButton* labelButton3;
@property(nonatomic,retain)UIButton* labelButton4;

+(CGFloat)getHeight;

@property(nonatomic,retain)LBB_TagsViewModel* model;

@end
