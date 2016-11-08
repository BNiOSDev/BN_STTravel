//
//  LBB_DownloadedViewController.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "LGSegment.h"

@interface LBB_DownloadedViewController :  Base_BaseViewController<SegmentDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property (nonatomic, weak)LGSegment *segment;
@property(nonatomic,weak)CALayer *LGLayer;

@end
