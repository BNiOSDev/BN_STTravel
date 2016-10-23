//
//  ST_HomeViewController.h
//  ST_Travel
//
//  Created by newman on 16/10/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "LGSegment.h"

@interface ST_SquareViewController : Base_BaseViewController<SegmentDelegate>
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property (nonatomic, weak)LGSegment *segment;
@property(nonatomic,weak)CALayer *LGLayer;

@end
