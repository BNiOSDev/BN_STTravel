//
//  LBB_DiscoveryCustomizedSelectView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohGreatItemView.h"

@interface LBB_DiscoveryCustomizedSelectView : UIView

@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UITextField* bgCtrlView;
@property(nonatomic, retain)UILabel* contentLable;
@property(nonatomic, retain)UIImageView* arrowImageView;
@property(nonatomic, retain)LBBPoohGreatItemView* addMoreView;

-(void)setContentLableText:(NSString *)content;
-(void)showAddMoreView:(BOOL)show;



@end
