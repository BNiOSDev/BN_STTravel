//
//  LBB_GuiderConditionOption.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderConditionOption.h"

@implementation LBB_GuiderConditionOption

@end

@implementation LBB_GuiderGenderConditionOption



@end


@implementation LBB_GuiderCondition

-(id)init{
    
    if (self = [super init]) {
        self.tags = [[NSMutableArray alloc] initFromNet];
        self.gender = [[NSMutableArray alloc] initFromNet];
        self.jobTime = [[NSMutableArray alloc] initFromNet];

    }
    return self;
}

-(void)setTags:(NSMutableArray<LBB_GuiderConditionOption *> *)tags{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_GuiderConditionOption mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

-(void)setGender:(NSMutableArray<LBB_GuiderGenderConditionOption *> *)gender{
    NSMutableArray *array = (NSMutableArray *)[gender map:^id(NSDictionary *element) {
        return [LBB_GuiderGenderConditionOption mj_objectWithKeyValues:element];
    }];
    _gender = array;
}

-(void)setJobTime:(NSMutableArray<LBB_GuiderConditionOption *> *)jobTime{
    NSMutableArray *array = (NSMutableArray *)[jobTime map:^id(NSDictionary *element) {
        return [LBB_GuiderConditionOption mj_objectWithKeyValues:element];
    }];
    _jobTime = array;
}


@end
