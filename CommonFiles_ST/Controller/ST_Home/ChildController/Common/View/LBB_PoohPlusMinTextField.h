//
//  LBB_PoohPlusMinTextField.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_PoohPlusMinTextField : UIView


@property(nonatomic, retain)UIButton* plusButton;
@property(nonatomic, retain)UIButton* minButton;
@property(nonatomic, assign)NSInteger inputNum;
@property(nonatomic, retain)UITextField* textField;
@property(nonatomic, assign)NSInteger maxNum;
@property(nonatomic, retain)UIView*  sep1;
@property(nonatomic, retain)UIView*  sep2;

@end
