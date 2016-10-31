//
//  LBB_NewOrderPlayTimeSelectView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LBBPoohVerticalLableControl.h"

@interface LBB_NewOrderPlayTimeSelectView : UIView

@property(nonatomic, retain)UILabel* titleLabel;

@property(nonatomic, retain)LBBPoohVerticalLableControl* todayView;
@property(nonatomic, retain)LBBPoohVerticalLableControl* tomorrowView;
@property(nonatomic, retain)LBBPoohVerticalLableControl* afterTomorrowView;//后天

@property(nonatomic, retain)LBBPoohVerticalLableControl* otherDayView;//其他

@property(nonatomic, assign)NSInteger selectIndex;
@property(nonatomic, copy)NSString* selectTime;

@end
