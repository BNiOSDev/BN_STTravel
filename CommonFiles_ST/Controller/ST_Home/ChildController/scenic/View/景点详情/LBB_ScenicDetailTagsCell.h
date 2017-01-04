//
//  LBB_ScenicDetailTagsCell.h
//  ST_Travel
//
//  Created by pooh on 17/1/4.
//  Copyright © 2017年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SpotDetailsViewModel.h"
#import "PoohCommon.h"
@interface LBB_ScenicDetailTagsCell : LBBPoohBaseTableViewCell
@property(nonatomic, strong)NSMutableArray<LBB_SpotsTag*> *tags;//	List	标签列表

@property(nonatomic, retain)UIButton* showButton;
@property(nonatomic, assign)BOOL isOpen;
@property(nonatomic, assign)LBBPoohHomeType homeType;
@property(nonatomic, strong)ClickBlock block;

@end
