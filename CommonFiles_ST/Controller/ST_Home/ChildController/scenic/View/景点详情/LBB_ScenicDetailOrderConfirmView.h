//
//  LBB_ScenicDetailOrderConfirmView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_PoohPlusMinTextField.h"

@interface LBB_ScenicDetailOrderConfirmView : UIWindow

@property(nonatomic, retain)UIImageView* imageView;
@property(nonatomic, retain)UILabel* priceLabel;
@property(nonatomic, retain)UILabel* noteLable;
@property(nonatomic, retain)UIButton* closeButton;

@property(nonatomic, retain)UILabel* adultTypeLabel;
@property(nonatomic, retain)UILabel* childTypeLabel;
@property(nonatomic, retain)UILabel* studenTypeLabel;
@property(nonatomic, retain)UILabel* soldierTypeLabel;

@property(nonatomic, retain)LBB_PoohPlusMinTextField* adultTextField;
@property(nonatomic, retain)LBB_PoohPlusMinTextField* childTextField;
@property(nonatomic, retain)LBB_PoohPlusMinTextField* studenTextField;
@property(nonatomic, retain)LBB_PoohPlusMinTextField* soldierTextField;

@property(nonatomic, retain)UIButton* confirmButton;




-(void)showPopView;
-(void)dismissPopView;
@end
