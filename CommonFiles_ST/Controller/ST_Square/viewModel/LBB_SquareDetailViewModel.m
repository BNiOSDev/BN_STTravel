//
//  LBB_SquareDetailViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareDetailViewModel.h"

@implementation LBB_SquareComments

@end

@implementation LBB_SquareLikeList

@end

@implementation LBB_SquarePics
    -(void)setTags:(NSMutableArray<LBB_SquareTags *> *)tags{
        NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
            return [LBB_SquareTags mj_objectWithKeyValues:element];
        }];
        _tags = array;
    }
@end

@implementation LBB_SquareDetailViewModel



- (void)setPics:(NSMutableArray<LBB_SquarePics *> *)pics
{
    NSMutableArray *array = (NSMutableArray *)[pics map:^id(NSDictionary *element) {
        return [LBB_SquarePics mj_objectWithKeyValues:element];
    }];
    _pics = array;
}

- (void)setTags:(NSMutableArray<LBB_SquareTags *> *)tags
{
    NSMutableArray *array = (NSMutableArray *)[tags map:^id(NSDictionary *element) {
        return [LBB_SquareTags mj_objectWithKeyValues:element];
    }];
    _tags = array;
}

-(void)setLikeds:(NSMutableArray<LBB_SquareLikeList *> *)likeds{
    
    NSMutableArray *array = (NSMutableArray *)[likeds map:^id(NSDictionary *element) {
        return [LBB_SquareLikeList mj_objectWithKeyValues:element];
    }];
    _likeds = array;
}

- (void)setComments:(NSMutableArray<LBB_SquareComments *> *)comments
{
    NSMutableArray *array = (NSMutableArray *)[comments map:^id(NSDictionary *element) {
        return [LBB_SquareComments mj_objectWithKeyValues:element];
    }];
    _comments = array;
}


@end
