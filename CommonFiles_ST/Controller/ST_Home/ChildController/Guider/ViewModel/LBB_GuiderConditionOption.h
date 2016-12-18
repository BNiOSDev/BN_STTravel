//
//  LBB_GuiderConditionOption.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_GuiderConditionOption : BN_BaseDataModel

@property(nonatomic,assign)int key;//主键(字典表里面的key，到手根据key来定义规则)
@property (nonatomic,strong)NSString *name;//显示名称

@end


@interface LBB_GuiderGenderConditionOption : BN_BaseDataModel

@property(nonatomic,assign)int key;//主键(字典表里面的key，到手根据key来定义规则)
@property (nonatomic,strong)NSString *gender;//显示名称

@end

@interface LBB_GuiderCondition : BN_BaseDataModel

@property(nonatomic,strong)NSMutableArray<LBB_GuiderConditionOption*>* tags;//	List	标签选择
@property(nonatomic,strong)NSMutableArray<LBB_GuiderConditionOption*>* jobTime;//	List	从业时间
@property(nonatomic,strong)NSMutableArray<LBB_GuiderGenderConditionOption*>* gender;//	List	性别


@end
