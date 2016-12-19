//
//  LBB_GuiderApplyResultViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"
#import "LBB_GuiderApplyViewModel.h"

@interface LBB_GuiderApplyResultViewController : Base_BaseViewController

@property(nonatomic, assign)BOOL isRemote;//yes：从后台取数据  no: 本地数据
@property(nonatomic, retain)LBB_GuiderApplyViewModel* viewModel;

@end
