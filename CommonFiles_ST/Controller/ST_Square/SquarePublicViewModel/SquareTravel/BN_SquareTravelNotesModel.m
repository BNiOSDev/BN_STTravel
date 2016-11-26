//
//  LBB_SquareTravelDetailViewModel.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "BN_SquareTravelNotesModel.h"

@implementation TravelNotesPics


@end


@implementation TravelNotesDetails

-(void)setPics:(NSArray<TravelNotesPics *> *)pics{

    NSMutableArray *array = [@[] mutableCopy];
    [pics enumerateObjectsUsingBlock:^(TravelNotesPics * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        TravelNotesPics *tag = [TravelNotesPics mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _pics = array;
}

@end

@implementation BN_SquareTravelNotesModel

-(void)setTravelNotesDetails:(NSArray<TravelNotesDetails *> *)travelNotesDetails{
    NSMutableArray *array = [@[] mutableCopy];
    [travelNotesDetails enumerateObjectsUsingBlock:^(TravelNotesDetails * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        TravelNotesDetails *tag = [TravelNotesDetails mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _travelNotesDetails = array;
}


- (void)setTags:(NSArray<LBB_SquareTags *> *)tags
{
    NSMutableArray *array = [@[] mutableCopy];
    [tags enumerateObjectsUsingBlock:^(LBB_SquareTags * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        LBB_SquareTags *tag = [LBB_SquareTags mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _tags = array;
}

@end

