//
//  LBB_ScenicDetailViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"
#import "LBB_SpotDetailsViewModel.h"

@interface LBB_ScenicDetailViewController : Base_BaseViewController

@property(nonatomic, assign)LBBPoohHomeType homeType;
@property(nonatomic, strong)LBB_SpotModel* spotModel;

@end
