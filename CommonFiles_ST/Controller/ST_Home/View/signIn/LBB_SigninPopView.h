//
//  LBB_SigninPopView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_SigninPopView : UIWindow

@property(nonatomic, retain)UIButton* signinButton;
@property(nonatomic, retain)UILabel* locationLabel;

-(void)showPopView;
-(void)dismissPopView;
-(void)setSigninStatus:(BOOL)signin;

@end

