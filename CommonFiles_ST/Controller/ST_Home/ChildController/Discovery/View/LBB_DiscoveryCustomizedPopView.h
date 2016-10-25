//
//  LBB_DiscoveryCustomizedPopView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_DiscoveryCustomizedPopView : UIWindow

@property(nonatomic, retain)UIButton* confirmButton;
@property(nonatomic, retain)UILabel* noteLabel;

-(void)showPopView;
-(void)dismissPopView;

@end
