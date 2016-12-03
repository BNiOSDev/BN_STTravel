//
//  LBB_DiscoveryCustomizedLabelView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoohCommon.h"
#import "LBB_TagsViewModel.h"
@interface LBB_DiscoveryCustomizedLabelView : UIView


@property(nonatomic, retain)UIView* contentView;
-(void)configContentView:(NSArray*)array;

@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *selectArray;
@property (nonatomic, strong) NSMutableArray *flagArray;
@property (nonatomic, assign) BOOL canMultiSel;

@property (nonatomic, strong) ClickBlock click;

-(void)refreshContentView;


@end
