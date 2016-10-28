//
//  LBB_FoodsMainHeaderView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohVerticalButton.h"
#import "SDCycleScrollView.h"

@interface LBB_FoodsMainHeaderView : UIView<SDCycleScrollViewDelegate>

@property(nonatomic, retain)SDCycleScrollView* cycScrollView;

-(void)setCycleScrollViewUrls:(NSArray*)urlArray;

+(CGFloat)getHeaderViewHeight;

@end
