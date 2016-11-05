//
//  LBB_GuiderApplyTextField.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_GuiderApplyTextField : UIView

@property(nonatomic, retain)UILabel* titleLable;
@property(nonatomic, retain)UITextField* rightTextField;
@property(nonatomic, retain)UITextView* bottomTextField;
@property(nonatomic, retain)UILabel* mark;

@property(nonatomic, retain)UIView* sepLine;

-(void)showBottomTextField:(BOOL)show;

@end
