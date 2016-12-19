//
//  LBB_GuiderApplyViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"
#import "LBB_GuiderConditionOption.h"
#import "LBB_GuiderApplyViewModel.h"

@interface LBB_GuiderApplyViewController : Base_BaseViewController

//@property(nonatomic, strong)NSMutableArray<LBB_GuiderApplyTagsObject*>* auditTags;//	List	认证标签
@property(nonatomic, retain)LBB_GuiderApplyViewModel* viewModel;
@property(nonatomic,strong)NSMutableArray<LBB_GuiderGenderConditionOption*>* gender;//	List	性别

@end
