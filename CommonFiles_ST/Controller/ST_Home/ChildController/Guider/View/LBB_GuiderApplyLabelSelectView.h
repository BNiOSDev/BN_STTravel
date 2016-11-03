//
//  LBB_GuiderApplyLabelSelectView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoohCommon.h"
@interface LBB_GuiderApplyLabelSelectView : UIView

@property(nonatomic, retain)UIView* contentView;
-(void)configContentView:(NSArray*)array;

@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *selectArray;
@property (nonatomic, strong) NSMutableArray *flagArray;
@property (nonatomic, assign) BOOL canMultiSel;

@property (nonatomic, strong) ClickBlock click;


@property (nonatomic, retain) UIColor* borderColor;
@property (nonatomic, retain) UIColor* titleColor;
@property (nonatomic, retain) UIColor* buttonBgColor;

@property (nonatomic, retain) UIColor* selectBorderColor;
@property (nonatomic, retain) UIColor* selectTitleColor;
@property (nonatomic, retain) UIColor* selectButtonBgColor;

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, retain) UIFont* buttonFont;


@end
