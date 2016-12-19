//
//  LBB_GuiderApplyViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"
#import "LBB_GuiderConditionOption.h"

@interface LBB_GuiderApplyViewController : Base_BaseViewController

//@property(nonatomic, assign)BOOL showLabelTag;
@property(nonatomic,strong)NSMutableArray<LBB_GuiderConditionOption*>* tags;//	List	标签选择

@end
