//
//  LBB_NewOrderInputTextField.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_NewOrderInputTextField : UIView

@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UITextField* textField;
@property(nonatomic, retain)UIButton* rightButton;

-(void)showRightButton:(BOOL)show;


-(void)setCutDown:(NSTimeInterval)interval;


@end
